package com.ruoyi.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.domain.AsqBooks;
import com.ruoyi.domain.AsqBooksRank;
import com.ruoyi.service.IAsqBooksService;
import com.ruoyi.service.IAsqRankParmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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
@RequestMapping("/public/rank")
public class PubAsqRankController extends BaseController {
    @Autowired
    private IAsqBooksService asqBooksService;
    @Autowired
    private IAsqRankParmService asqRankParmService;
    @Autowired
    private RedisCache redisCache;
    /**
     * 查询拾柒书库阅读总榜
     */
    @GetMapping("/readAllRank")
    public TableDataInfo list() {
        startPage();
        String key = "indexCache_BooksByRead";
        Object cacheObject = redisCache.getCacheObject(key);
        if (cacheObject != null) {
            return getDataTable((List<?>) cacheObject);
        } else {
            List<AsqBooksRank> list = asqBooksService.readAllRank();
            redisCache.setCacheObject(key, list);
            return getDataTable(list);
        }
    }

    /**
     * 查询拾柒热榜
     */
    @GetMapping("/hotRank")
    public TableDataInfo listHot() {
        startPage();
        List<AsqBooks> asqBooks = asqRankParmService.selectAsqRankParmByHotList();
        return getDataTable(asqBooks);
    }

    /**
     * 猜你喜欢
     */
    @GetMapping("/GYWLike")
    public TableDataInfo GYWLike() {
        startPage();
        List<AsqBooks> list = asqBooksService.GYWLike();
        return getDataTable(list);
    }

}
