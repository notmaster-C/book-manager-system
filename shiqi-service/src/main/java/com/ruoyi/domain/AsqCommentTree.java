package com.ruoyi.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.entity.SysUser;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 评论对象 asq_comment
 *
 * @author zjh
 * @date 2022-10-27
 */
public class AsqCommentTree extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * $column.columnComment
     */
    private Long commentId;

    /**
     * 父级id
     */
    @Excel(name = "父级id")
    private Long commentParentId;

    /**
     * 用户id
     */
    @Excel(name = "用户id")
    private Long userId;

    /**
     * 评论体
     */
    @Excel(name = "评论体")
    private Long comBodyId;

    /**
     * 评论内容
     */
    @Excel(name = "评论内容")
    private String commentText;

    /**
     * 评论主体类型，1书，2社区
     */
    @Excel(name = "评论主体类型，1书，2社区")
    private Integer comBodyType;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createDate;

    /**
     * 点赞数
     */
    @Excel(name = "点赞数")
    private Long likeNum;

    /**
     * 是否违规
     */
    @Excel(name = "是否违规")
    private Integer isVio;

    private SysUser sysUser;

    public SysUser getSysUser() {
        return sysUser;
    }

    public void setSysUser(SysUser sysUser) {
        this.sysUser = sysUser;
    }

    /**
     * 回复列表
     */
    private List<AsqCommentTree> children = new ArrayList<>();

    public List<AsqCommentTree> getChildren() {
        return children;
    }

    public void setChildren(List<AsqCommentTree> children) {
        this.children = children;
    }

    public void setCommentId(Long commentId) {
        this.commentId = commentId;
    }

    public Long getCommentId() {
        return commentId;
    }

    public void setCommentParentId(Long commentParentId) {
        this.commentParentId = commentParentId;
    }

    public Long getCommentParentId() {
        return commentParentId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setComBodyId(Long comBodyId) {
        this.comBodyId = comBodyId;
    }

    public Long getComBodyId() {
        return comBodyId;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setComBodyType(Integer comBodyType) {
        this.comBodyType = comBodyType;
    }

    public Integer getComBodyType() {
        return comBodyType;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public Long getLikeNum() {
        return likeNum;
    }

    public void setLikeNum(Long likeNum) {
        this.likeNum = likeNum;
    }

    public void setIsVio(Integer isVio) {
        this.isVio = isVio;
    }

    public Integer getIsVio() {
        return isVio;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("commentId", getCommentId())
                .append("commentParentId", getCommentParentId())
                .append("userId", getUserId())
                .append("comBodyId", getComBodyId())
                .append("commentText", getCommentText())
                .append("comBodyType", getComBodyType())
                .append("createDate", getCreateDate())
                .append("like", getLikeNum())
                .append("isVio", getIsVio())
                .toString();
    }
}
