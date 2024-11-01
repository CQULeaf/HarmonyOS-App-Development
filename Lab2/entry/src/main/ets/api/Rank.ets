import request from '../Utils/AxiosRequest'

export function getRankList<T>(username: string) {
  return request<T>({
    url: '/user/rank',
    method: 'get',
    params: {
      username
    }
  })
}

export function updateScore<T>(username: string, score: number) {
  return request<T>({
    url: '/user/updateScore',
    method: 'post',
    data: {
      username,
      score
    }
  })
}