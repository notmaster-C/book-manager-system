import request from '@/utils/request'


// 获取首页轮播图
export function getPpt(query) {
	return request({
		'url': '/public/ppt/ppt/list',
		'method': 'get',
		params: query
	})
}

// 获取用户人数
export function getUserNum(query) {
	return request({
		'url': '/public/user/number',
		'method': 'get',
		params: query
	})
}

// 获取拾柒推荐
export function hotRank() {
    return request({
        url: '/public/rank/hotRank',
        method: 'get'
    })
}

// 查询拾柒书库
export function BooksList(query) {
    return request({
        url: '/public/bookM/books/list',
        method: 'get',
        params: query
    })
}
// 猜你喜欢
export function GYWLike() {
    return request({
        url: '/public/rank/GYWLike',
        method: 'get'
    })
}

// 查询话题列表
export function listTopic(query) {
  return request({
    url: '/public/topic/topic/list',
    method: 'get',
    params: query
  })
}
// 查询评论列表
export function listComment(query) {
  return request({
    url: '/public/comment/comment/list',
    method: 'get',
    params: query
  })
}

// 查询图书详情
export function bookInfo(id) {
  return request({
    url: '/public/bookM/books/'+id,
    method: 'get'
  })
}

// 新增图书排名
export function rankParm(rankParm) {
  return request({
    url: '/public/rankParm/rankParm',
    method: 'post',
	'data': rankParm
  })
}
// 发表评论
export function comment(comment) {
  return request({
    url: '/comment/comment',
    method: 'post',
	'data': comment
  })
}
