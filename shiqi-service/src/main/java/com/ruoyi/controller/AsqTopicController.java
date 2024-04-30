package com.ruoyi.controller;

import java.util.List;

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
import com.ruoyi.domain.AsqTopic;
import com.ruoyi.service.IAsqTopicService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 话题Controller
 *
 * @author zjh
 * @date 2022-10-29
 */
@RestController
@RequestMapping("/topic/topic")
public class AsqTopicController extends BaseController {
    @Autowired
    private IAsqTopicService asqTopicService;

    /**
     * 查询话题列表
     */
    @PreAuthorize("@ss.hasPermi('topic:topic:list')")
    @GetMapping("/list")
    public TableDataInfo list(AsqTopic asqTopic) {
        startPage();
        List<AsqTopic> list = asqTopicService.selectAsqTopicList(asqTopic);
        return getDataTable(list);
    }

    /**
     * 导出话题列表
     */
    @PreAuthorize("@ss.hasPermi('topic:topic:export')")
    @Log(title = "话题", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(AsqTopic asqTopic) {
        List<AsqTopic> list = asqTopicService.selectAsqTopicList(asqTopic);
        ExcelUtil<AsqTopic> util = new ExcelUtil<AsqTopic>(AsqTopic.class);
        return util.exportExcel(list, "话题数据");
    }

    /**
     * 获取话题详细信息
     */
    @PreAuthorize("@ss.hasPermi('topic:topic:query')")
    @GetMapping(value = "/{topicId}")
    public AjaxResult getInfo(@PathVariable("topicId") Long topicId) {
        return AjaxResult.success(asqTopicService.selectAsqTopicByTopicId(topicId));
    }

    /**
     * 新增话题
     */
    @PreAuthorize("@ss.hasPermi('topic:topic:add')")
    @Log(title = "话题", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AsqTopic asqTopic) {
        return toAjax(asqTopicService.insertAsqTopic(asqTopic));
    }

    /**
     * 修改话题
     */
    @PreAuthorize("@ss.hasPermi('topic:topic:edit')")
    @Log(title = "话题", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AsqTopic asqTopic) {
        return toAjax(asqTopicService.updateAsqTopic(asqTopic));
    }

    /**
     * 删除话题
     */
    @PreAuthorize("@ss.hasPermi('topic:topic:remove')")
    @Log(title = "话题", businessType = BusinessType.DELETE)
    @DeleteMapping("/{topicIds}")
    public AjaxResult remove(@PathVariable Long[] topicIds) {
        return toAjax(asqTopicService.deleteAsqTopicByTopicIds(topicIds));
    }
}
