package com.ruoyi.controller;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.domain.AsqComment;
import com.ruoyi.domain.AsqCommentTree;
import com.ruoyi.domain.AsqRankParm;
import com.ruoyi.domain.AsqTopic;
import com.ruoyi.service.IAsqCommentService;
import com.ruoyi.service.IAsqRankParmService;
import com.ruoyi.service.IAsqTopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 话题Controller
 *
 * @author zjh
 * @date 2022-10-29
 */
@RestController
@RequestMapping("/public/topic/topic")
public class PubAsqTopicController extends BaseController {
    @Autowired
    private IAsqTopicService asqTopicService;
    @Autowired
    private IAsqCommentService asqCommentService;

    /**
     * 查询话题列表
     */
    @GetMapping("/list")
    public TableDataInfo list(AsqTopic asqTopic) {
        startPage();
        List<AsqTopic> list = asqTopicService.selectAsqTopicList(asqTopic);
        return getDataTable(list);
    }

    /**
     * 查询自己的话题列表
     */
    @GetMapping("/listMine")
    public TableDataInfo listMine(AsqTopic asqTopic) {
        startPage();
        asqTopic.setUserId(SecurityUtils.getUserId());
        List<AsqTopic> list = asqTopicService.selectAsqTopicList(asqTopic);
        return getDataTable(list);
    }

    @Log(title = "话题", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AsqTopic asqTopic) {
        return toAjax(asqTopicService.insertAsqTopic(asqTopic));
    }


    /**
     * 获取话题详细信息
     */
    @GetMapping(value = "/{topicId}")
    public AjaxResult getInfo(@PathVariable("topicId") Long topicId) {
        return AjaxResult.success(asqTopicService.selectAsqTopicByTopicId(topicId));
    }

    /**
     * 删除话题
     */
    @Log(title = "话题", businessType = BusinessType.DELETE)
    @DeleteMapping("/{topicIds}")
    public AjaxResult remove(@PathVariable Long[] topicIds) {
        return toAjax(asqTopicService.deleteAsqTopicByTopicIds(topicIds));
    }

    /**
     * 修改话题
     */
    @Log(title = "话题", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AsqTopic asqTopic) {
        return toAjax(asqTopicService.updateAsqTopic(asqTopic));
    }
}
