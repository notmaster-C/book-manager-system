package com.ruoyi.mapper;

import java.util.List;
import com.ruoyi.domain.AsqComment;

/**
 * 评论Mapper接口
 * 
 * @author zjh
 * @date 2022-10-27
 */
public interface AsqCommentMapper 
{
    /**
     * 查询评论
     * 
     * @param commentId 评论主键
     * @return 评论
     */
    public AsqComment selectAsqCommentByCommentId(Long commentId);

    /**
     * 查询评论列表
     * 
     * @param asqComment 评论
     * @return 评论集合
     */
    public List<AsqComment> selectAsqCommentList(AsqComment asqComment);

    /**
     * 新增评论
     * 
     * @param asqComment 评论
     * @return 结果
     */
    public int insertAsqComment(AsqComment asqComment);

    /**
     * 修改评论
     * 
     * @param asqComment 评论
     * @return 结果
     */
    public int updateAsqComment(AsqComment asqComment);

    /**
     * 删除评论
     * 
     * @param commentId 评论主键
     * @return 结果
     */
    public int deleteAsqCommentByCommentId(Long commentId);

    /**
     * 批量删除评论
     * 
     * @param commentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAsqCommentByCommentIds(Long[] commentIds);
}
