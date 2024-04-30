package com.ruoyi.controller;

import java.util.*;

import com.alibaba.druid.support.json.JSONUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.common.constant.HttpStatus;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.page.PageDomain;
import com.ruoyi.common.core.page.TableSupport;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.domain.AsqChat;
import com.ruoyi.domain.AsqCommentTree;
import com.ruoyi.domain.AsqRankParm;
import com.ruoyi.service.IAsqRankParmService;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.domain.AsqComment;
import com.ruoyi.service.IAsqCommentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;


/**
 * 评论Controller
 *
 * @author zjh
 * @date 2022-10-27
 */
@RestController
@RequestMapping("/comment/comment")
public class AsqCommentController extends BaseController {
    @Autowired
    private IAsqCommentService asqCommentService;
    @Autowired
    private IAsqRankParmService asqRankParmService;
    @Autowired
    private RedisCache redisCache;
    @Autowired
    private ISysUserService sysUserService;

    /**
     * 查询评论列表
     */
    @PreAuthorize("@ss.hasPermi('comment:comment:list')")
    @GetMapping("/list")
    public TableDataInfo list(AsqComment asqComment) {
//        startPage();
        PageDomain pageDomain = TableSupport.buildPageRequest();
        Integer pageNum = pageDomain.getPageNum();
        Integer pageSize = pageDomain.getPageSize();
        List<AsqCommentTree> list = asqCommentService.selectAsqCommentList(asqComment);
        TableDataInfo tableDataInfo = new TableDataInfo();
        tableDataInfo.setCode(HttpStatus.SUCCESS);
        tableDataInfo.setMsg("查询成功");
        tableDataInfo.setRows(this.getPartList(list, pageNum, pageSize));
        tableDataInfo.setTotal(list.size());
        return tableDataInfo;
    }


    /**
     * 按分页方式截取inLs的一部分
     *
     * @param inLs  传入列表
     * @param page  页码
     * @param limit 页容量
     * @param <T>   元素类型
     * @return 指定页的元素列表
     */
    public <T> List<T> getPartList(List<T> inLs, int page, int limit) {
        page = (page <= 0) ? 1 : page;
        limit = (limit <= 0) ? 10 : limit;
        int total = inLs.size();

        return inLs.subList(Math.min((page - 1) * limit, total), Math.min(page * limit, total));
    }

    /**
     * 导出评论列表
     */
    @PreAuthorize("@ss.hasPermi('comment:comment:export')")
    @Log(title = "评论", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(AsqComment asqComment) {
        List<AsqCommentTree> list = asqCommentService.selectAsqCommentList(asqComment);
        ExcelUtil<AsqCommentTree> util = new ExcelUtil<AsqCommentTree>(AsqCommentTree.class);
        return util.exportExcel(list, "评论数据");
    }

    /**
     * 获取评论详细信息
     */
    @PreAuthorize("@ss.hasPermi('comment:comment:query')")
    @GetMapping(value = "/{commentId}")
    public AjaxResult getInfo(@PathVariable("commentId") Long commentId) {
        return AjaxResult.success(asqCommentService.selectAsqCommentByCommentId(commentId));
    }

    /**
     * 新增评论
     */
//    @PreAuthorize("@ss.hasPermi('comment:comment:add')")
    @Log(title = "评论", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AsqComment asqComment) {
        asqComment.setCreateDate(new Date());
        asqComment.setUserId(SecurityUtils.getUserId());
        if (asqComment.getComBodyType() == 1) {
            AsqRankParm asqRankParm2 = new AsqRankParm();
            asqRankParm2.setBookId(asqComment.getComBodyId());
            List<AsqRankParm> asqRankParm1 = asqRankParmService.selectAsqRankParmList(asqRankParm2);
            if (asqRankParm1.size() == 0) {
                asqRankParm2.setCommentNum(1L);
                asqRankParmService.insertAsqRankParm(asqRankParm2);
            } else {
                if (asqRankParm1.get(0).getCommentNum() != null) {
                    asqRankParm1.get(0).setCommentNum(asqRankParm1.get(0).getCommentNum() + 1);
                } else {
                    asqRankParm1.get(0).setCommentNum(1L);
                }
                asqRankParmService.updateAsqRankParm(asqRankParm1.get(0));
            }
        }
        int i = asqCommentService.insertAsqComment(asqComment);
        if (asqComment.getCommentParentId() != null) {
            AsqComment commentParent = asqCommentService.selectAsqCommentByCommentId(asqComment.getCommentParentId());
            if (!commentParent.getUserId().equals(SecurityUtils.getUserId())) {
//                发送方
                SysUser sysUser = sysUserService.selectUserById(SecurityUtils.getUserId());
                AsqComment asqComment1 = new AsqComment();
                asqComment1 = asqComment;
                asqComment1.setSysUser(sysUser);
                asqComment1.setCommentId(asqComment.getCommentId());
                String key = "comment_" + commentParent.getUserId() + "_cId_" + asqComment.getCommentId();
                redisCache.setCacheObject(key, asqComment1);
            }
        }
        return toAjax(i);
    }


    /**
     * 查询未读评论
     */
    @GetMapping("/unreadComment")
    public AjaxResult unreadComment() {
        Collection<String> keys = redisCache.keys("comment_" + SecurityUtils.getUserId() + "_cId_*");
        Object[] objects = keys.toArray();
        ArrayList<AjaxResult> asqComments = new ArrayList<>();
        for (int i = 0; i < objects.length; i++) {
            Object cacheObject = redisCache.getCacheObject((String) objects[i]);
            AjaxResult result = new AjaxResult();
            result.put("comment", cacheObject);
            asqComments.add(result);
        }
        return AjaxResult.success(asqComments);
    }

    /**
     * 去除未读评论
     */
    @GetMapping("/readComment/{id}")
    public AjaxResult readComment(@PathVariable("id") Long id) {
        return AjaxResult.success(redisCache.deleteObject("comment_" + SecurityUtils.getUserId() + "_cId_" + id));
    }

    /**
     * 修改评论
     */
//    @PreAuthorize("@ss.hasPermi('comment:comment:edit')")
    @Log(title = "评论", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AsqComment asqComment) {
//        TODO  功能不完善，可以重复点赞
        return toAjax(asqCommentService.updateAsqComment(asqComment));
    }

    /**
     * 删除评论
     */
    @PreAuthorize("@ss.hasPermi('comment:comment:remove')")
    @Log(title = "评论", businessType = BusinessType.DELETE)
    @DeleteMapping("/{commentIds}")
    public AjaxResult remove(@PathVariable Long[] commentIds) {
        return toAjax(asqCommentService.deleteAsqCommentByCommentIds(commentIds));
    }
}
