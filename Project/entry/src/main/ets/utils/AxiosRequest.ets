import axios, {AxiosInstance, AxiosRequestConfig, AxiosResponse} from '@ohos/axios'

const instance: AxiosInstance = axios.create({
  baseURL: 'http://192.168.237.182:8080',
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json'
  }
})

// 通用响应结构
interface ApiResponse<T> {
  code: number
  msg: string
  data: T
}

export default async function request<T>(config: AxiosRequestConfig): Promise<T> {
  try {
    const res: AxiosResponse<ApiResponse<T>> = await instance(config)
    if (res.data.code === 200) {
      return res.data.data
    } else {
      throw new Error(res.data.msg)
    }
  } catch (error) {
    throw new Error(error)
  }
}