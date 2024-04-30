import request from '@/utils/request'

// 查询前台首页幻灯片
export function indexPpt(query) {
    return request({
        url: '/public/ppt/ppt/list',
        method: 'get',
        params: query
    })
}
// 查询用户数
export function userNumber() {
    return request({
        url: '/public/user/number',
        method: 'get'
    })
}
// 查询前台首页拾柒书库
export function indexBooks(query) {
    return request({
        url: '/public/bookM/books/list',
        method: 'get',
        params: query
    })
}
// 查询前台首页拾柒书库阅读总榜
export function readAllRank() {
    return request({
        url: '/public/rank/readAllRank',
        method: 'get'
    })
}
// 查询前台首页猜你喜欢
export function GYWLike() {
    return request({
        url: '/public/rank/GYWLike',
        method: 'get'
    })
}
// 查询前台首页拾柒推荐
export function readRec() {
    return request({
        url: '/public/rankParm/rankParm/listByWeight',
        method: 'get'
    })
}
// 查询前台首页拾柒推荐
export function hotRank() {
    return request({
        url: '/public/rank/hotRank',
        method: 'get'
    })
}
