import request from '@/utils/request'

// 查询图书管理列表
export function listBooks(query) {
  return request({
    url: '/bookM/books/list',
    method: 'get',
    params: query
  })
}

// 查询图书管理详细
export function getBooks(bookId) {
  return request({
    url: '/bookM/books/' + bookId,
    method: 'get'
  })
}

export function listHistory() {
  return request({
    url: '/rankParm/rankParm/listHistory',
    method: 'get'
  })
}

// 新增图书管理
export function addBooks(data) {
  return request({
    url: '/bookM/books',
    method: 'post',
    data: data
  })
}

// 修改图书管理
export function updateBooks(data) {
  return request({
    url: '/bookM/books',
    method: 'put',
    data: data
  })
}

// 删除图书管理
export function delBooks(bookId) {
  return request({
    url: '/bookM/books/' + bookId,
    method: 'delete'
  })
}

// 导出图书管理
export function exportBooks(query) {
  return request({
    url: '/bookM/books/export',
    method: 'get',
    params: query
  })
}
