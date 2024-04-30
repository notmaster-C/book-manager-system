import request from '@/utils/request'

// 查询加入书架列表
export function listCollect(query) {
  return request({
    url: '/collect/collect/list',
    method: 'get',
    params: query
  })
}
export function listAndBookInfo(query) {
  return request({
    url: '/collect/collect/listAndBookInfo',
    method: 'get',
    params: query
  })
}

// 查询加入书架详细
export function getCollect(collectId) {
  return request({
    url: '/collect/collect/' + collectId,
    method: 'get'
  })
}

// 新增加入书架
export function addCollect(data) {
  return request({
    url: '/collect/collect',
    method: 'post',
    data: data
  })
}

// 修改加入书架
export function updateCollect(data) {
  return request({
    url: '/collect/collect',
    method: 'put',
    data: data
  })
}

// 删除加入书架
export function delCollect(collectId) {
  return request({
    url: '/collect/collect/' + collectId,
    method: 'delete'
  })
}

// 导出加入书架
export function exportCollect(query) {
  return request({
    url: '/collect/collect/export',
    method: 'get',
    params: query
  })
}
