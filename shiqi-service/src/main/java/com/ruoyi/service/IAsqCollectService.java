package com.ruoyi.service;

import java.util.List;
import com.ruoyi.domain.AsqCollect;
import com.ruoyi.domain.vo.AsqCollectAndBookInfoVo;

/**
 * 加入书架Service接口
 *
 * @author zjh
 * @date 2022-10-26
 */
public interface IAsqCollectService
{
    /**
     * 查询加入书架
     *
     * @param collectId 加入书架主键
     * @return 加入书架
     */
    public AsqCollect selectAsqCollectByCollectId(Long collectId);

    /**
     * 查询加入书架列表
     *
     * @param asqCollect 加入书架
     * @return 加入书架集合
     */
    public List<AsqCollect> selectAsqCollectList(AsqCollect asqCollect);

    /**
     * 新增加入书架
     *
     * @param asqCollect 加入书架
     * @return 结果
     */
    public int insertAsqCollect(AsqCollect asqCollect);

    /**
     * 修改加入书架
     *
     * @param asqCollect 加入书架
     * @return 结果
     */
    public int updateAsqCollect(AsqCollect asqCollect);

    /**
     * 批量删除加入书架
     *
     * @param collectIds 需要删除的加入书架主键集合
     * @return 结果
     */
    public int deleteAsqCollectByCollectIds(Long[] collectIds);

    /**
     * 删除加入书架信息
     *
     * @param collectId 加入书架主键
     * @return 结果
     */
    public int deleteAsqCollectByCollectId(Long collectId);

    List<AsqCollectAndBookInfoVo> selectAsqCollectAndBookInfoList(AsqCollectAndBookInfoVo infoVo);
}
