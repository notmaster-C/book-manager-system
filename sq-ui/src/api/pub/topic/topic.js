import request from '@/utils/request'

// 查询话题列表
export function listTopic(query) {
  return request({
    url: '/public/topic/topic/list',
    method: 'get',
    params: query
  })
}

// 查询话题详细
export function getTopic(topicId) {
  return request({
    url: '/topic/topic/' + topicId,
    method: 'get'
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

