package com.ruoyi.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.domain.AsqComment;
import com.ruoyi.mapper.AsqCommentMapper;
import com.ruoyi.system.mapper.SysUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mapper.AsqTopicMapper;
import com.ruoyi.domain.AsqTopic;
import com.ruoyi.service.IAsqTopicService;

/**
 * 话题Service业务层处理
 *
 * @author zjh
 * @date 2022-10-29
 */
@Service
public class AsqTopicServiceImpl implements IAsqTopicService
{
    @Autowired
    private AsqTopicMapper asqTopicMapper;
    @Autowired
    private SysUserMapper userMapper;
    @Autowired
    private AsqCommentMapper asqCommentMapper;

    /**
     * 查询话题
     *
     * @param topicId 话题主键
     * @return 话题
     */
    @Override
    public AsqTopic selectAsqTopicByTopicId(Long topicId)
    {
        return asqTopicMapper.selectAsqTopicByTopicId(topicId);
    }

    /**
     * 查询话题列表
     *
     * @param asqTopic 话题
     * @return 话题
     */
    @Override
    public List<AsqTopic> selectAsqTopicList(AsqTopic asqTopic)
    {
        List<AsqTopic> asqTopics = asqTopicMapper.selectAsqTopicList(asqTopic);
        AsqComment asqComment = new AsqComment();
        asqComment.setComBodyType(2);
        // 使用缓存来存储用户信息
        Map<Long, SysUser> userCache = new HashMap<>();
        for (AsqTopic topic : asqTopics) {
            // 从缓存中获取用户信息，如果没有则从数据库中查询并存入缓存
            SysUser user = userCache.get(topic.getUserId());
            if (user == null) {
                user = userMapper.selectUserById(topic.getUserId());
                userCache.put(topic.getUserId(), user);
            }
            topic.setSysUser(user);
            asqComment.setComBodyId(topic.getTopicId());
            topic.setCommentNum(asqCommentMapper.selectAsqCommentList(asqComment).size());
        }
        return asqTopics;
    }

    /**
     * 新增话题
     *
     * @param asqTopic 话题
     * @return 结果
     */
    @Override
    public int insertAsqTopic(AsqTopic asqTopic)
    {
        asqTopic.setUserId(SecurityUtils.getUserId());
        asqTopic.setTopicCreatedate(new Date());
        return asqTopicMapper.insertAsqTopic(asqTopic);
    }

    /**
     * 修改话题
     *
     * @param asqTopic 话题
     * @return 结果
     */
    @Override
    public int updateAsqTopic(AsqTopic asqTopic)
    {
        return asqTopicMapper.updateAsqTopic(asqTopic);
    }

    /**
     * 批量删除话题
     *
     * @param topicIds 需要删除的话题主键
     * @return 结果
     */
    @Override
    public int deleteAsqTopicByTopicIds(Long[] topicIds)
    {
        return asqTopicMapper.deleteAsqTopicByTopicIds(topicIds);
    }

    /**
     * 删除话题信息
     *
     * @param topicId 话题主键
     * @return 结果
     */
    @Override
    public int deleteAsqTopicByTopicId(Long topicId)
    {
        return asqTopicMapper.deleteAsqTopicByTopicId(topicId);
    }
}
