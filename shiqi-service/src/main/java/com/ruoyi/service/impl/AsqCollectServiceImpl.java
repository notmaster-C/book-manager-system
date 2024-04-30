package com.ruoyi.service.impl;

import java.util.List;

import com.ruoyi.domain.vo.AsqCollectAndBookInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mapper.AsqCollectMapper;
import com.ruoyi.domain.AsqCollect;
import com.ruoyi.service.IAsqCollectService;

/**
 * 加入书架Service业务层处理
 *
 * @author zjh
 * @date 2022-10-26
 */
@Service
public class AsqCollectServiceImpl implements IAsqCollectService
{
    @Autowired
    private AsqCollectMapper asqCollectMapper;

    /**
     * 查询加入书架
     *
     * @param collectId 加入书架主键
     * @return 加入书架
     */
    @Override
    public AsqCollect selectAsqCollectByCollectId(Long collectId)
    {
        return asqCollectMapper.selectAsqCollectByCollectId(collectId);
    }

    /**
     * 查询加入书架列表
     *
     * @param asqCollect 加入书架
     * @return 加入书架
     */
    @Override
    public List<AsqCollect> selectAsqCollectList(AsqCollect asqCollect)
    {
        return asqCollectMapper.selectAsqCollectList(asqCollect);
    }

    /**
     * 新增加入书架
     *
     * @param asqCollect 加入书架
     * @return 结果
     */
    @Override
    public int insertAsqCollect(AsqCollect asqCollect)
    {
        return asqCollectMapper.insertAsqCollect(asqCollect);
    }

    /**
     * 修改加入书架
     *
     * @param asqCollect 加入书架
     * @return 结果
     */
    @Override
    public int updateAsqCollect(AsqCollect asqCollect)
    {
        return asqCollectMapper.updateAsqCollect(asqCollect);
    }

    /**
     * 批量删除加入书架
     *
     * @param collectIds 需要删除的加入书架主键
     * @return 结果
     */
    @Override
    public int deleteAsqCollectByCollectIds(Long[] collectIds)
    {
        return asqCollectMapper.deleteAsqCollectByCollectIds(collectIds);
    }

    /**
     * 删除加入书架信息
     *
     * @param collectId 加入书架主键
     * @return 结果
     */
    @Override
    public int deleteAsqCollectByCollectId(Long collectId)
    {
        return asqCollectMapper.deleteAsqCollectByCollectId(collectId);
    }

    @Override
    public List<AsqCollectAndBookInfoVo> selectAsqCollectAndBookInfoList(AsqCollectAndBookInfoVo infoVo) {
        return asqCollectMapper.selectAsqCollectAndBookInfoList(infoVo);
    }
}
