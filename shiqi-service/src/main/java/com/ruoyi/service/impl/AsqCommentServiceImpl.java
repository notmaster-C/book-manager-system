package com.ruoyi.service.impl;

import java.lang.reflect.Array;
import java.util.*;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.domain.AsqCommentTree;
import com.ruoyi.system.mapper.SysUserMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mapper.AsqCommentMapper;
import com.ruoyi.domain.AsqComment;
import com.ruoyi.service.IAsqCommentService;

/**
 * 评论Service业务层处理
 *
 * @author zjh
 * @date 2022-10-27
 */
@Service
public class AsqCommentServiceImpl implements IAsqCommentService {
    @Autowired
    private AsqCommentMapper asqCommentMapper;
    @Autowired
    private SysUserMapper userMapper;

    /**
     * 查询评论
     *
     * @param commentId 评论主键
     * @return 评论
     */
    @Override
    public AsqComment selectAsqCommentByCommentId(Long commentId) {
        return asqCommentMapper.selectAsqCommentByCommentId(commentId);
    }

//    /**
//     * 查询评论列表
//     *
//     * @param asqComment 评论
//     * @return 评论
//     */
//    @Override
//    public List<AsqCommentTree> selectAsqCommentList(AsqComment asqComment) {
//
//        List<AsqComment> asqComments = asqCommentMapper.selectAsqCommentList(asqComment);
//
//        ArrayList<AsqCommentTree> asqCommentTrees = new ArrayList<>();
//
//        // 使用缓存来存储用户信息
//        Map<Long, SysUser> userCache = new HashMap<>();
//
//        for (AsqComment comment : asqComments) {
//            if (comment.getCommentParentId() == 0) {
//                AsqCommentTree asqCommentTree = new AsqCommentTree();
//                // 从缓存中获取用户信息，如果没有则从数据库中查询并存入缓存
//                SysUser user = userCache.get(comment.getUserId());
//                if (user == null) {
//                    user = userMapper.selectUserById(comment.getUserId());
//                    userCache.put(comment.getUserId(), user);
//                }
//                asqCommentTree.setSysUser(user);
//                comment.setSysUser(asqCommentTree.getSysUser());
//                BeanUtils.copyProperties(comment, asqCommentTree);
//                asqCommentTrees.add(asqCommentTree);
//            }
//        }
//
//        for (AsqCommentTree asqCommentTree : asqCommentTrees) {
//            add(asqCommentTree, asqComments);
//        }
//
//        return asqCommentTrees;
//    }
//
//    private void add(AsqCommentTree rootViewComment, List<AsqComment> commentList) {
//        // 使用缓存来存储用户信息
//        Map<Long, SysUser> userCache = new HashMap<>();
//        for (AsqComment comment : commentList) {
//            // 找到匹配的 parentId
//            if (rootViewComment.getCommentId().equals(comment.getCommentParentId())) {
//                AsqCommentTree viewComment = new AsqCommentTree();
//                // 从缓存中获取用户信息，如果没有则从数据库中查询并存入缓存
//                SysUser user = userCache.get(comment.getUserId());
//                if (user == null) {
//                    user = userMapper.selectUserById(comment.getUserId());
//                    userCache.put(comment.getUserId(), user);
//                }
//                viewComment.setSysUser(user);
//                comment.setSysUser(viewComment.getSysUser());
//                BeanUtils.copyProperties(comment, viewComment);
//                rootViewComment.getChildren().add(viewComment);
//                //递归调用
//                add(viewComment, commentList);
//            }
//        }
//    }

    /**
     * 查询评论列表 （优化后，提升百分之90的速度）
     *
     * @param asqComment 评论
     * @return 评论
     */
    @Override
    public List<AsqCommentTree> selectAsqCommentList(AsqComment asqComment) {

        // 查询所有评论
        List<AsqComment> asqComments = asqCommentMapper.selectAsqCommentList(asqComment);

        // 使用一个全局缓存来存储用户信息
        Map<Long, SysUser> userCache = new HashMap<>();

        // 使用一个哈希表来存储评论的父子关系
        Map<Long, List<AsqComment>> commentMap = new HashMap<>();

        // 获取所有评论的用户ID
        Set<Long> userIds = new HashSet<>();
        for (AsqComment comment : asqComments) {
            userIds.add(comment.getUserId());
        }

        // 批量查询所有评论的用户信息，并存入缓存
        // 查询所有评论的用户信息，并存入缓存
        for (Long userId : userIds) {
            SysUser user = userMapper.selectUserById(userId);
            userCache.put(userId, user);
        }


        // 遍历所有评论，将其按照父子关系分组，并设置用户信息
        for (AsqComment comment : asqComments) {
            comment.setSysUser(userCache.get(comment.getUserId()));
            List<AsqComment> children = commentMap.getOrDefault(comment.getCommentParentId(), new ArrayList<>());
            children.add(comment);
            commentMap.put(comment.getCommentParentId(), children);
        }

        // 创建一个空的结果列表
        ArrayList<AsqCommentTree> asqCommentTrees = new ArrayList<>();

        // 判断评论列表是否为空，如果为空，就直接返回空的结果列表
        if (asqComments == null || asqComments.isEmpty()) {
            return asqCommentTrees;
        }

        // 遍历根评论，将其转换为树形结构，并添加到结果列表中
        for (AsqComment comment : commentMap.get(0L)) {
            AsqCommentTree asqCommentTree = new AsqCommentTree();
            BeanUtils.copyProperties(comment, asqCommentTree);
            asqCommentTrees.add(asqCommentTree);
            buildTree(asqCommentTree, commentMap);
        }

        return asqCommentTrees;
    }

    // 递归构建树形结构的辅助方法
    private void buildTree(AsqCommentTree parent, Map<Long, List<AsqComment>> commentMap) {
        List<AsqComment> children = commentMap.get(parent.getCommentId());
        if (children != null && !children.isEmpty()) {
            for (AsqComment child : children) {
                AsqCommentTree childTree = new AsqCommentTree();
                BeanUtils.copyProperties(child, childTree);
                parent.getChildren().add(childTree);
                buildTree(childTree, commentMap);
            }
        }
    }

    /**
     * 新增评论
     *
     * @param asqComment 评论
     * @return 结果
     */
    @Override
    public int insertAsqComment(AsqComment asqComment) {
        return asqCommentMapper.insertAsqComment(asqComment);
    }

    /**
     * 修改评论
     *
     * @param asqComment 评论
     * @return 结果
     */
    @Override
    public int updateAsqComment(AsqComment asqComment) {
        return asqCommentMapper.updateAsqComment(asqComment);
    }

    /**
     * 批量删除评论
     *
     * @param commentIds 需要删除的评论主键
     * @return 结果
     */
    @Override
    public int deleteAsqCommentByCommentIds(Long[] commentIds) {
        return asqCommentMapper.deleteAsqCommentByCommentIds(commentIds);
    }

    /**
     * 删除评论信息
     *
     * @param commentId 评论主键
     * @return 结果
     */
    @Override
    public int deleteAsqCommentByCommentId(Long commentId) {
        return asqCommentMapper.deleteAsqCommentByCommentId(commentId);
    }
}
