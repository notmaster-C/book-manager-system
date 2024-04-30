import request from '@/utils/request'

// 查询评论列表
export function listComment(query) {
  return request({
    url: '/comment/comment/list',
    method: 'get',
    params: query
  })
}
// 查询未读评论
export function unreadComment() {
  return request({
    url: '/comment/comment/unreadComment',
    method: 'get'
  })
}

// 查询评论详细
export function getComment(commentId) {
  return request({
    url: '/comment/comment/' + commentId,
    method: 'get'
  })
}
// 去除未读评论
export function readComment(commentId) {
  return request({
    url: '/comment/comment/readComment/' + commentId,
    method: 'get'
  })
}

// 新增评论
export function addComment(data) {
  return request({
    url: '/comment/comment',
    method: 'post',
    data: data
  })
}

// 修改评论
export function updateComment(data) {
  return request({
    url: '/comment/comment',
    method: 'put',
    data: data
  })
}

// 删除评论
export function delComment(commentId) {
  return request({
    url: '/comment/comment/' + commentId,
    method: 'delete'
  })
}

// 导出评论
export function exportComment(query) {
  return request({
    url: '/comment/comment/export',
    method: 'get',
    params: query
  })
}
