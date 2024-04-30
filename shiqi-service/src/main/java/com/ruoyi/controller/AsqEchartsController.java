package com.ruoyi.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.domain.AsqCommentTree;
import com.ruoyi.domain.echarts.AsqBookRank;
import com.ruoyi.service.IAsqEchartsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


/**
 * @Author zjh
 * @Date 2023-04-26 上午 12:18
 **/
@RestController
@RequestMapping("/echarts")
public class AsqEchartsController extends BaseController {
    @Autowired
    private IAsqEchartsService asqEchartsService;
    /**
     * 查询排名参数
     */
    @GetMapping("/bookrank")
    public AjaxResult bookRank() {
        return AjaxResult.success(asqEchartsService.bookRank());
    }
}
