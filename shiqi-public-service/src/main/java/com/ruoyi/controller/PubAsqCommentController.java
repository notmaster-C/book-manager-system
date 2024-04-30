package com.ruoyi.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.domain.AsqComment;
import com.ruoyi.domain.AsqCommentTree;
import com.ruoyi.service.IAsqCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @Author zjh
 * @Date 2022-10-28 下午 2:00
 **/
@RestController
@RequestMapping("/public/comment/comment")
public class PubAsqCommentController extends BaseController {
    @Autowired
    private IAsqCommentService asqCommentService;

    /**
     * 查询评论列表
     */
    @GetMapping("/list")
    public TableDataInfo list(AsqComment asqComment) {
        startPage();
        List<AsqCommentTree> list = asqCommentService.selectAsqCommentList(asqComment);
        return getDataTable(list);
    }
}
