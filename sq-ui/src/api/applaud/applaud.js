import request from '@/utils/request'

// 查询用户喜欢列表
export function listApplaud(query) {
  return request({
    url: '/applaud/applaud/list',
    method: 'get',
    params: query
  })
}
// 查询用户喜欢列表
export function listApplaudAndBookInfo(query) {
  return request({
    url: '/applaud/applaud/listAndBookInfo',
    method: 'get',
    params: query
  })
}

// 查询用户喜欢详细
export function getApplaud(applaudId) {
  return request({
    url: '/applaud/applaud/' + applaudId,
    method: 'get'
  })
}

// 新增用户喜欢
export function addApplaud(data) {
  return request({
    url: '/applaud/applaud',
    method: 'post',
    data: data
  })
}

// 修改用户喜欢
export function updateApplaud(data) {
  return request({
    url: '/applaud/applaud',
    method: 'put',
    data: data
  })
}

// 删除用户喜欢
export function delApplaud(applaudId) {
  return request({
    url: '/applaud/applaud/' + applaudId,
    method: 'delete'
  })
}

// 导出用户喜欢
export function exportApplaud(query) {
  return request({
    url: '/applaud/applaud/export',
    method: 'get',
    params: query
  })
}
