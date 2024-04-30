package com.ruoyi.controller;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.domain.AsqRankParm;
import com.ruoyi.domain.vo.AsqApplaudAndBookInfoVo;
import com.ruoyi.service.IAsqApplaudService;
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
import com.ruoyi.domain.AsqApplaud;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 用户喜欢Controller
 *
 * @author zjh
 * @date 2022-10-24
 */
@RestController
@RequestMapping("/applaud/applaud")
public class AsqApplaudController extends BaseController {
    @Autowired
    private IAsqApplaudService asqApplaudService;
    @Autowired
    private IAsqRankParmService asqRankParmService;

    /**
     * 查询用户喜欢列表
     */
//    @PreAuthorize("@ss.hasPermi('applaud:applaud:list')")
    @GetMapping("/list")
    public TableDataInfo list(AsqApplaud asqApplaud) {
        startPage();
        asqApplaud.setUserId(SecurityUtils.getUserId());
        List<AsqApplaud> list = asqApplaudService.selectAsqApplaudList(asqApplaud);
        return getDataTable(list);
    }
    /**
     * 查询用户喜欢列表 and 书籍信息
     */
    @GetMapping("/listAndBookInfo")
    public TableDataInfo listAndBookInfo(AsqApplaudAndBookInfoVo infoVo) {
        startPage();
        List<AsqApplaudAndBookInfoVo> list = asqApplaudService.selectAsqApplaudAndBookInfoList(infoVo);
        return getDataTable(list);
    }


    /**
     * 导出用户喜欢列表
     */
    @PreAuthorize("@ss.hasPermi('applaud:applaud:export')")
    @Log(title = "用户喜欢", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(AsqApplaud asqApplaud) {
        List<AsqApplaud> list = asqApplaudService.selectAsqApplaudList(asqApplaud);
        ExcelUtil<AsqApplaud> util = new ExcelUtil<AsqApplaud>(AsqApplaud.class);
        return util.exportExcel(list, "用户喜欢数据");
    }

    /**
     * 获取用户喜欢详细信息
     */
    @PreAuthorize("@ss.hasPermi('applaud:applaud:query')")
    @GetMapping(value = "/{applaudId}")
    public AjaxResult getInfo(@PathVariable("applaudId") Long applaudId) {
        return AjaxResult.success(asqApplaudService.selectAsqApplaudByApplaudId(applaudId));
    }

    /**
     * 新增用户喜欢
     */
//    @PreAuthorize("@ss.hasPermi('applaud:applaud:add')")
    @Log(title = "用户喜欢", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AsqApplaud asqApplaud) {

        asqApplaud.setUserId(SecurityUtils.getUserId());
        asqApplaud.setCreadData(new Date());

        AsqRankParm asqRankParm2 = new AsqRankParm();
        asqRankParm2.setBookId(asqApplaud.getBookId());
        List<AsqRankParm> asqRankParm1 = asqRankParmService.selectAsqRankParmList(asqRankParm2);
        if (asqRankParm1.size() == 0) {
            asqRankParm2.setApplaudNum(1L);
            asqRankParmService.insertAsqRankParm(asqRankParm2);
        } else {
            if (asqRankParm1.get(0).getApplaudNum() != null) {
                asqRankParm1.get(0).setApplaudNum(asqRankParm1.get(0).getApplaudNum() + 1);
            } else {
                asqRankParm1.get(0).setApplaudNum(1L);
            }
            asqRankParmService.updateAsqRankParm(asqRankParm1.get(0));
        }
        return toAjax(asqApplaudService.insertAsqApplaud(asqApplaud));
    }

    /**
     * 修改用户喜欢
     */
    @PreAuthorize("@ss.hasPermi('applaud:applaud:edit')")
    @Log(title = "用户喜欢", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AsqApplaud asqApplaud) {
        return toAjax(asqApplaudService.updateAsqApplaud(asqApplaud));
    }

    /**
     * 删除用户喜欢
     */
//    @PreAuthorize("@ss.hasPermi('applaud:applaud:remove')")
    @Log(title = "用户喜欢", businessType = BusinessType.DELETE)
    @DeleteMapping("/{bookId}")
    public AjaxResult remove(@PathVariable Long bookId) {
        AsqApplaud asqApplaud = new AsqApplaud();
        asqApplaud.setBookId(bookId);
        asqApplaud.setUserId(SecurityUtils.getUserId());
        List<AsqApplaud> list = asqApplaudService.selectAsqApplaudList(asqApplaud);
        Long[] applaudIds = new Long[1];
        applaudIds[0] = list.get(0).getApplaudId();

        AsqRankParm asqRankParm2 = new AsqRankParm();
        asqRankParm2.setBookId(asqApplaud.getBookId());
        List<AsqRankParm> asqRankParm1 = asqRankParmService.selectAsqRankParmList(asqRankParm2);
        asqRankParm1.get(0).setApplaudNum(asqRankParm1.get(0).getApplaudNum() - 1);
        asqRankParmService.updateAsqRankParm(asqRankParm1.get(0));

        return toAjax(asqApplaudService.deleteAsqApplaudByApplaudIds(applaudIds));
    }
}
