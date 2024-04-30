import request from '@/utils/request'

// 查询最近阅读
export function listHistory() {
    return request({
        url: '/rankParm/rankParm/listHistory',
        method: 'get'
    })
}
// 查询最近联系
export function chatList() {
    return request({
        url: '/chat/chat/chatList',
        method: 'get'
    })
}
// 查询联系记录
export function chatRecords(id) {
    return request({
        url: '/chat/chat/chatRecords/'+id,
        method: 'get'
    })
}