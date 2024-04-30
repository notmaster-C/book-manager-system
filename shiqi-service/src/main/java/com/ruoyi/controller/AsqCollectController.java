package com.ruoyi.controller;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.domain.AsqRankParm;
import com.ruoyi.domain.vo.AsqApplaudAndBookInfoVo;
import com.ruoyi.domain.vo.AsqCollectAndBookInfoVo;
import com.ruoyi.service.IAsqRankParmService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.domain.AsqCollect;
import com.ruoyi.service.IAsqCollectService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 加入书架Controller
 *
 * @author zjh
 * @date 2022-10-26
 */
@RestController
@RequestMapping("/collect/collect")
public class AsqCollectController extends BaseController {
    @Autowired
    private IAsqCollectService asqCollectService;
    @Autowired
    private IAsqRankParmService asqRankParmService;

    /**
     * 查询加入书架列表
     */
//    @PreAuthorize("@ss.hasPermi('collect:collect:list')")
    @GetMapping("/list")
    public TableDataInfo list(AsqCollect asqCollect) {
        startPage();
        asqCollect.setUserId(SecurityUtils.getUserId());
        List<AsqCollect> list = asqCollectService.selectAsqCollectList(asqCollect);
        return getDataTable(list);
    }

    /**
     * 查询加入书架列表 and 书籍信息
     */
    @GetMapping("/listAndBookInfo")
    public TableDataInfo listAndBookInfo(AsqCollectAndBookInfoVo infoVo) {
        startPage();
        List<AsqCollectAndBookInfoVo> list = asqCollectService.selectAsqCollectAndBookInfoList(infoVo);
        return getDataTable(list);
    }

    /**
     * 导出加入书架列表
     */
    @PreAuthorize("@ss.hasPermi('collect:collect:export')")
    @Log(title = "加入书架", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(AsqCollect asqCollect) {
        List<AsqCollect> list = asqCollectService.selectAsqCollectList(asqCollect);
        ExcelUtil<AsqCollect> util = new ExcelUtil<AsqCollect>(AsqCollect.class);
        return util.exportExcel(list, "加入书架数据");
    }

    /**
     * 获取加入书架详细信息
     */
    @PreAuthorize("@ss.hasPermi('collect:collect:query')")
    @GetMapping(value = "/{collectId}")
    public AjaxResult getInfo(@PathVariable("collectId") Long collectId) {
        return AjaxResult.success(asqCollectService.selectAsqCollectByCollectId(collectId));
    }

    /**
     * 新增加入书架
     */
//    @PreAuthorize("@ss.hasPermi('collect:collect:add')")
    @Log(title = "加入书架", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AsqCollect asqCollect)  {
        asqCollect.setUserId(SecurityUtils.getUserId());
        asqCollect.setCreateDate(new Date());

        AsqRankParm asqRankParm2 = new AsqRankParm();
        asqRankParm2.setBookId(asqCollect.getBookId());
        List<AsqRankParm> asqRankParm1 = asqRankParmService.selectAsqRankParmList(asqRankParm2);
        if (asqRankParm1.size() == 0) {
            asqRankParm2.setCollectNum(1L);
            asqRankParmService.insertAsqRankParm(asqRankParm2);
        } else {
            if (asqRankParm1.get(0).getCollectNum() != null) {
                asqRankParm1.get(0).setCollectNum(asqRankParm1.get(0).getCollectNum() + 1);
            } else {
                asqRankParm1.get(0).setCollectNum(1L);
            }
            asqRankParmService.updateAsqRankParm(asqRankParm1.get(0));
        }

        return toAjax(asqCollectService.insertAsqCollect(asqCollect));
    }

    /**
     * 修改加入书架
     */
    @PreAuthorize("@ss.hasPermi('collect:collect:edit')")
    @Log(title = "加入书架", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AsqCollect asqCollect) {
        return toAjax(asqCollectService.updateAsqCollect(asqCollect));
    }

    /**
     * 删除加入书架
     */
//    @PreAuthorize("@ss.hasPermi('collect:collect:remove')")
    @Log(title = "加入书架", businessType = BusinessType.DELETE)
    @DeleteMapping("/{bookId}")
    public AjaxResult remove(@PathVariable Long bookId){
        AsqCollect asqCollect = new AsqCollect();
        asqCollect.setUserId(SecurityUtils.getUserId());
        asqCollect.setBookId(bookId);
        List<AsqCollect> asqCollects = asqCollectService.selectAsqCollectList(asqCollect);
        Long[] longs = new Long[1];
        longs[0] = asqCollects.get(0).getCollectId();

        AsqRankParm asqRankParm2 = new AsqRankParm();
        asqRankParm2.setBookId(bookId);
        List<AsqRankParm> asqRankParm1 = asqRankParmService.selectAsqRankParmList(asqRankParm2);
        asqRankParm1.get(0).setCollectNum(asqRankParm1.get(0).getCollectNum() - 1);
        asqRankParmService.updateAsqRankParm(asqRankParm1.get(0));

        return toAjax(asqCollectService.deleteAsqCollectByCollectIds(longs));
    }
}
