import request from '../utils/AxiosRequest'

export function userLogin<T>(username: string, password: string) {
  return request<T>({
    url: '/user/login',
    method: 'post',
    data: {
      username,
      password
    }
  })
}

export function userRegister<T>(username: string, password1: string, password2: string) {
  return request<T>({
    url: '/user/register',
    method: 'post',
    data: {
      username,
      password1,
      password2
    }
  })
}

export function userChangePw<T>(username: string, oldPassword: string, newPassword1: string, newPassword2: string) {
  return request<T>({
    url: '/user/changePassword',
    method: 'post',
    data: {
      username,
      oldPassword,
      newPassword1,
      newPassword2
    }
  })
}