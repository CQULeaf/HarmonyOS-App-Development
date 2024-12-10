import request from '../utils/AxiosRequest'

export function noteAdd<T>(username: string, title: string | null, content: string , category: string | null) {
  return request<T>({
    url: '/notes/add',
    method: 'post',
    data: {
      username,
      category,
      content,
      title
    }
  })
}

export function noteDelete<T>(id: number) {
  return request<T>({
    url: `/notes/delete/${id}`,
    method: 'delete'
  })
}

export function noteList<T>(username: string) {
  return request<T>({
    url: `/notes/list/${username}`,
    method: 'get'
  })
}

export function noteEdit<T>(id: number, title: string | null, content: string , category: string | null) {
  return request<T>({
    url: `/notes/edit/${id}`,
    method: 'put',
    data: {
      category,
      content,
      title
    }
  })
}