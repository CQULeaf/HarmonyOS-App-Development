import request from '../utils/AxiosRequest'

export function recordAdd<T>(username: string, category: string, amount: number, description: string, date: string, type: number) {
  return request<T>({
    url: '/record/add',
    method: 'post',
    data: {
      username,
      category,
      amount,
      description,
      date,
      type
    }
  })
}

export function recordDelete<T>(id: number) {
  return request<T>({
    url: `/record/delete/${id}`,
    method: 'delete'
  })
}

export function recordList<T>(username: string) {
  return request<T>({
    url: `/record/list/${username}`,
    method: 'get'
  })
}