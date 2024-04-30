package com.ruoyi.service.impl;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.domain.AsqBooks;
import com.ruoyi.utils.redisCacheDel.RedisDelByIndex;
import com.ruoyi.utils.websocket.WebSocketServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mapper.AsqRankParmMapper;
import com.ruoyi.domain.AsqRankParm;
import com.ruoyi.service.IAsqRankParmService;

/**
 * 排名参数Service业务层处理
 *
 * @author ruoyi
 * @date 2022-07-28
 */
@Service
public class AsqRankParmServiceImpl implements IAsqRankParmService {
    @Autowired
    private AsqRankParmMapper asqRankParmMapper;
    @Autowired
    private IAsqRankParmService asqRankParmService;
    @Autowired
    private WebSocketServer webSocketServer;
    @Autowired
    private RedisDelByIndex delByIndex;

    /**
     * 查询排名参数
     *
     * @param rankParmId 排名参数主键
     * @return 排名参数
     */
    @Override
    public AsqRankParm selectAsqRankParmByRankParmId(Long rankParmId) {
        return asqRankParmMapper.selectAsqRankParmByRankParmId(rankParmId);
    }

    /**
     * 查询排名参数列表
     *
     * @param asqRankParm 排名参数
     * @return 排名参数
     */
    @Override
    public List<AsqRankParm> selectAsqRankParmList(AsqRankParm asqRankParm) {
        return asqRankParmMapper.selectAsqRankParmList(asqRankParm);
    }

    /**
     * 新增排名参数
     *
     * @param asqRankParm 排名参数
     * @return 结果
     */
    @Override
    public int insertAsqRankParm(AsqRankParm asqRankParm) {
        delByIndex.delete();
        int i = asqRankParmMapper.insertAsqRankParm(asqRankParm);
        List<AsqBooks> asqBooks = asqRankParmService.selectAsqRankParmByHotList();
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.put("type", 1);
        ajaxResult.put("data", asqBooks);
        return i;
    }

    /**
     * 修改排名参数
     *
     * @param asqRankParm 排名参数
     * @return 结果
     */
    @Override
    public int updateAsqRankParm(AsqRankParm asqRankParm) {
        delByIndex.delete();
        return asqRankParmMapper.updateAsqRankParm(asqRankParm);
    }

    /**
     * 批量删除排名参数
     *
     * @param rankParmIds 需要删除的排名参数主键
     * @return 结果
     */
    @Override
    public int deleteAsqRankParmByRankParmIds(Long[] rankParmIds) {
        delByIndex.delete();
        return asqRankParmMapper.deleteAsqRankParmByRankParmIds(rankParmIds);
    }

    /**
     * 删除排名参数信息
     *
     * @param rankParmId 排名参数主键
     * @return 结果
     */
    @Override
    public int deleteAsqRankParmByRankParmId(Long rankParmId) {
        delByIndex.delete();
        return asqRankParmMapper.deleteAsqRankParmByRankParmId(rankParmId);
    }

    @Override
    public List<AsqBooks> selectAsqRankParmByWeightList() {
        return asqRankParmMapper.selectAsqRankParmByWeightList();
    }

    @Override
    public List<AsqBooks> selectAsqRankParmByHotList() {
        return asqRankParmMapper.selectAsqRankParmByHotList();
    }
}
