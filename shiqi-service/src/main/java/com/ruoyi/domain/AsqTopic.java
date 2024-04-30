package com.ruoyi.domain;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.entity.SysUser;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 话题对象 asq_topic
 *
 * @author zjh
 * @date 2022-10-29
 */
public class AsqTopic extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long topicId;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long userId;

    /** 话题 */
    @Excel(name = "话题")
    private String topicName;

    /** 文章 */
    @Excel(name = "文章")
    private String topicContent;

    /** 封面 */
    @Excel(name = "封面")
    private String topicCover;

    /** 发布时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "发布时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date topicCreatedate;

    private SysUser sysUser;

    private int commentNum;

    private List<AsqCommentTree> asqComment;

    public List<AsqCommentTree> getAsqComment() {
        return asqComment;
    }

    public void setAsqComment(List<AsqCommentTree> asqComment) {
        this.asqComment = asqComment;
    }

    public int getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(int commentNum) {
        this.commentNum = commentNum;
    }

    public SysUser getSysUser() {
        return sysUser;
    }

    public void setSysUser(SysUser sysUser) {
        this.sysUser = sysUser;
    }

    public void setTopicId(Long topicId)
    {
        this.topicId = topicId;
    }

    public Long getTopicId()
    {
        return topicId;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setTopicName(String topicName)
    {
        this.topicName = topicName;
    }

    public String getTopicName()
    {
        return topicName;
    }
    public void setTopicContent(String topicContent)
    {
        this.topicContent = topicContent;
    }

    public String getTopicContent()
    {
        return topicContent;
    }
    public void setTopicCover(String topicCover)
    {
        this.topicCover = topicCover;
    }

    public String getTopicCover()
    {
        return topicCover;
    }
    public void setTopicCreatedate(Date topicCreatedate)
    {
        this.topicCreatedate = topicCreatedate;
    }

    public Date getTopicCreatedate()
    {
        return topicCreatedate;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("topicId", getTopicId())
            .append("userId", getUserId())
            .append("topicName", getTopicName())
            .append("topicContent", getTopicContent())
            .append("topicCover", getTopicCover())
            .append("topicCreatedate", getTopicCreatedate())
            .toString();
    }
}
