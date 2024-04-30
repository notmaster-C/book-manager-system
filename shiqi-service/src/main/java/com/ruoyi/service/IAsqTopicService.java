package com.ruoyi.service;

import java.util.List;
import com.ruoyi.domain.AsqTopic;

/**
 * 话题Service接口
 * 
 * @author zjh
 * @date 2022-10-29
 */
public interface IAsqTopicService 
{
    /**
     * 查询话题
     * 
     * @param topicId 话题主键
     * @return 话题
     */
    public AsqTopic selectAsqTopicByTopicId(Long topicId);

    /**
     * 查询话题列表
     * 
     * @param asqTopic 话题
     * @return 话题集合
     */
    public List<AsqTopic> selectAsqTopicList(AsqTopic asqTopic);

    /**
     * 新增话题
     * 
     * @param asqTopic 话题
     * @return 结果
     */
    public int insertAsqTopic(AsqTopic asqTopic);

    /**
     * 修改话题
     * 
     * @param asqTopic 话题
     * @return 结果
     */
    public int updateAsqTopic(AsqTopic asqTopic);

    /**
     * 批量删除话题
     * 
     * @param topicIds 需要删除的话题主键集合
     * @return 结果
     */
    public int deleteAsqTopicByTopicIds(Long[] topicIds);

    /**
     * 删除话题信息
     * 
     * @param topicId 话题主键
     * @return 结果
     */
    public int deleteAsqTopicByTopicId(Long topicId);
}
