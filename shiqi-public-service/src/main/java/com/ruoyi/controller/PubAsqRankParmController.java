package com.ruoyi.controller;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.domain.AsqBooks;
import com.ruoyi.domain.AsqPpt;
import com.ruoyi.domain.AsqRankParm;
import com.ruoyi.service.IAsqBooksService;
import com.ruoyi.service.IAsqRankParmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 排名参数Controller
 *
 * @author ruoyi
 * @date 2022-07-28
 */
@RestController
@RequestMapping("/public/rankParm/rankParm")
public class PubAsqRankParmController extends BaseController {
    @Autowired
    private IAsqRankParmService asqRankParmService;
    @Autowired
    private IAsqBooksService asqBooksService;
    @Autowired
    private RedisCache redisCache;

    /**
     * 查询排名参数列表
     */
    @GetMapping("/list")
    public TableDataInfo list(AsqRankParm asqRankParm) {
        startPage();
        List<AsqRankParm> list = asqRankParmService.selectAsqRankParmList(asqRankParm);
        return getDataTable(list);
    }

    /**
     * 导出排名参数列表
     */
    @Log(title = "排名参数", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(AsqRankParm asqRankParm) {
        List<AsqRankParm> list = asqRankParmService.selectAsqRankParmList(asqRankParm);
        ExcelUtil<AsqRankParm> util = new ExcelUtil<AsqRankParm>(AsqRankParm.class);
        return util.exportExcel(list, "排名参数数据");
    }

    /**
     * 获取排名参数详细信息
     */
    @GetMapping(value = "/{rankParmId}")
    public AjaxResult getInfo(@PathVariable("rankParmId") Long rankParmId) {
        return AjaxResult.success(asqRankParmService.selectAsqRankParmByRankParmId(rankParmId));
    }

    /**
     * 新增排名参数
     */
    @Log(title = "排名参数", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AsqRankParm asqRankParm) {

//        浏览历史加入redis
        if (asqRankParm.getBookId() != null) {
            AsqBooks asqBooks = asqBooksService.selectAsqBooksByBookId(asqRankParm.getBookId());
            String key = "history_" + SecurityUtils.getUserId() + "_bookId_" + asqRankParm.getBookId();
            redisCache.setCacheObject(key, asqBooks, 1, TimeUnit.DAYS);
        }
        AsqRankParm asqRankParm2 = new AsqRankParm();
        asqRankParm2.setBookId(asqRankParm.getBookId());
        List<AsqRankParm> asqRankParm1 = asqRankParmService.selectAsqRankParmList(asqRankParm2);
        if (asqRankParm1.size() == 0) {
            if (asqRankParm.getReadNum() != null) {
                asqRankParm.setReadNum(1L);
            }
            return toAjax(asqRankParmService.insertAsqRankParm(asqRankParm));
        } else {
            if (asqRankParm.getReadNum() != null) {
                asqRankParm1.get(0).setReadNum(asqRankParm1.get(0).getReadNum() + 1);
            }
            return toAjax(asqRankParmService.updateAsqRankParm(asqRankParm1.get(0)));
        }
    }

    /**
     * 拾柒推荐 （权值）
     */
    @GetMapping("/listByWeight")
    public TableDataInfo listByWeight() {
        startPage();
        String key = "indexCache_BooksByWeight";
        Object cacheObject = redisCache.getCacheObject(key);
        if (cacheObject != null) {
            return getDataTable((List<?>) cacheObject);
        } else {
            List<AsqBooks> list = asqRankParmService.selectAsqRankParmByWeightList();
            redisCache.setCacheObject(key, list);
            return getDataTable(list);
        }
    }

    /**
     * 修改排名参数
     */
    @Log(title = "排名参数", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AsqRankParm asqRankParm) {
        return toAjax(asqRankParmService.updateAsqRankParm(asqRankParm));
    }

    /**
     * 删除排名参数
     */
    @Log(title = "排名参数", businessType = BusinessType.DELETE)
    @DeleteMapping("/{rankParmIds}")
    public AjaxResult remove(@PathVariable Long[] rankParmIds) {
        return toAjax(asqRankParmService.deleteAsqRankParmByRankParmIds(rankParmIds));
    }
}
