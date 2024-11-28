import axios, { AxiosError, AxiosInstance, AxiosRequestConfig,
  AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'

const instance: AxiosInstance = axios.create({
  baseURL: 'http://192.168.114.182:8080',
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

// export default <T>(config:AxiosRequestConfig): Promise<ApiResponse<T>> => {
//   // 添加请求拦截器
//   instance.interceptors.request.use((config:InternalAxiosRequestConfig) => {
//     // 在发送请求之前做些什么
//     return config
//   }, (error:AxiosError) => {
//     // 对请求错误做些什么
//     return Promise.reject(error)
//   })
//
//   // 添加响应拦截器
//   instance.interceptors.response.use((response:AxiosResponse) => {
//     if(response.data.code === 200) {
//       console.log(response.data.msg)
//     }
//     // 对响应数据做点什么
//     return response.data;
//   }, (error:AxiosError) => {
//     // 对响应错误做点什么
//     console.log("AxiosError",JSON.stringify(error.response))
//     return Promise.reject(error)
//   })
//   return instance(config)
// }