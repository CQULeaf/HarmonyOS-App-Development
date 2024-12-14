import request from '../utils/AxiosRequest'

export function noteAdd<T>(username: string, title: string, content: string , category: string) {
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

export function noteEdit<T>(id: number, title: string, content: string , category: string) {
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

export function getNoteById<T>(id: number) {
  return request<T>({
    url: `/notes/get/${id}`,
    method: 'get'
  })
}

export function noteTop<T>(id: number, isTop: boolean) {
  return request<T>({
    url: `/notes/top/${id}`,
    method: 'put',
    params: {
      isTop
    }
  })
}

export function noteFavorite<T>(id: number, isFavorite: boolean) {
  return request<T>({
    url: `/notes/favorite/${id}`,
    method: 'put',
    params: {
      isFavorite
    }
  })
}