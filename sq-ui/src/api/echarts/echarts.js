import request from '@/utils/request'

// 查询排名参数
export function bookRankAPI() {
  return request({
    url: '/echarts/bookrank',
    method: 'get'
  })
}
