package com.ruoyi.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.domain.*;
import com.ruoyi.service.IAsqBooksService;
import com.ruoyi.service.IAsqPptService;
import com.ruoyi.service.IAsqRankParmService;
import com.ruoyi.service.IAsqWriterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 前台首页幻灯片Controller
 *
 * @author ruoyi
 * @date 2022-07-24
 */
@RestController
@RequestMapping("/public/bookM/books")
public class PubAsqBooksController extends BaseController {
    @Autowired
    private IAsqBooksService asqBooksService;
    @Autowired
    private IAsqWriterService asqWriterService;
    @Autowired
    private IAsqRankParmService asqRankParmService;

    /**
     * 查询前台图书列表
     */
    @GetMapping("/list")
    public TableDataInfo list(AsqBooks asqBooks) {
        startPage();
        List<AsqBooks> list = asqBooksService.selectAsqBooksList(asqBooks);
        AsqWriter asqWriter = new AsqWriter();
        AsqRankParm asqRankParm = new AsqRankParm();
        for (int i = 0; i < list.size(); i++) {
            asqWriter.setWriterName(list.get(i).getBookWriterName());
            list.get(i).setWriter(asqWriterService.selectAsqWriterList(asqWriter).get(0));
            asqRankParm.setBookId(list.get(i).getBookId());
            if (asqRankParmService.selectAsqRankParmList(asqRankParm).size() != 0){
                list.get(i).setRankParm(asqRankParmService.selectAsqRankParmList(asqRankParm).get(0));
            }else {
                list.get(i).setRankParm(asqRankParm);
            }
        }
        return getDataTable(list);
    }

    /**
     * 获取图书详细信息
     */
    @GetMapping(value = "/{bookId}")
    public AjaxResult getInfo(@PathVariable("bookId") Long bookId) {
        return AjaxResult.success(asqBooksService.selectAsqBooksByBookId(bookId));
    }

}
