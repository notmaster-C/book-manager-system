import request from '@/utils/request'

// 查询话题列表
export function listTopic(query) {
  return request({
    url: '/topic/topic/list',
    method: 'get',
    params: query
  })
}
// 查询话题列表
export function listMine(query) {
  return request({
    url: '/public/topic/topic/listMine',
    method: 'get',
    params: query
  })
}

// 查询话题详细
export function getMineTopic(topicId) {
  return request({
    url: '/public/topic/topic/' + topicId,
    method: 'get'
  })
}
// 查询话题详细
export function getTopic(topicId) {
  return request({
    url: '/topic/topic/' + topicId,
    method: 'get'
  })
}

// 新增话题
export function addTopic(data) {
  return request({
    url: '/topic/topic',
    method: 'post',
    data: data
  })
}
// 新增话题
export function addMineTopic(data) {
  return request({
    url: '/public/topic/topic',
    method: 'post',
    data: data
  })
}

// 修改话题
export function updateTopic(data) {
  return request({
    url: '/topic/topic',
    method: 'put',
    data: data
  })
}

// 修改话题
export function updateMineTopic(data) {
  return request({
    url: '/public/topic/topic',
    method: 'put',
    data: data
  })
}

// 删除话题
export function delTopic(topicId) {
  return request({
    url: '/public/topic/topic/' + topicId,
    method: 'delete'
  })
}
// 删除话题
export function delMineTopic(topicId) {
  return request({
    url: '/topic/topic/' + topicId,
    method: 'delete'
  })
}

// 导出话题
export function exportTopic(query) {
  return request({
    url: '/topic/topic/export',
    method: 'get',
    params: query
  })
}
