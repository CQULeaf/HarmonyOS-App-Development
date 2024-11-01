import { router } from '@kit.ArkUI'
import axios, { AxiosError, AxiosResponse } from '@ohos/axios'
import Constants from '../common/Constants'

interface UserRegister {
  username: string
  password1: string
  password2: string
}

@Entry
@Component
struct Register {
  private username: string = ''
  private password1: string = ''
  private password2: string = ''

  // 实现注册请求
  userRegister(): Promise<void> {
    return new Promise((resolve, reject) => {
      axios.post<string, AxiosResponse<string>, UserRegister>(`${Constants.BASE_URL}/user/register`, {
        username: this.username,
        password1: this.password1,
        password2: this.password2
      }).then((response: AxiosResponse) => {
        if (response.data.code === 200) {
          console.log(response.data.msg)
          resolve()
          router.pushUrl({ url: 'pages/Login' })
        } else if (response.data.data === '用户名已存在') {
          console.log(response.data.msg)
          reject(new Error('注册失败'))
          AlertDialog.show({
            message: '用户名已存在，请换一个用户名'
          })
        } else if (response.data.data === '两次密码输入不一致, 请重新输入'){
          console.log(response.data.msg)
          reject(new Error('注册失败'))
          AlertDialog.show({
            message: '两次密码输入不一致，请重新输入'
          })
        } else {
          console.log(response.data.msg)
          reject(new Error('注册失败'))
          AlertDialog.show({
            message: '注册失败，请重新尝试'
          })
        }
      }).catch((error: AxiosError) => {
        console.log('注册失败', error)
        reject(error)
        AlertDialog.show({
          message: '注册失败，请检查网络连接'
        })
      })
    })
  }

  build() {
    Column() {
      Text('注册专属游戏帐号').fontSize(28).margin({ bottom: 25 })
      TextInput({ placeholder:'请输入用户名'})
        .type(InputType.Normal)
        .height(48)
        .width(300)
        .fontSize(16)
        .margin({ top: 16 })
        .onChange((value: string) => {
          this.username = value
        })
      TextInput({ placeholder:'请输入密码'})
        .type(InputType.Password)
        .height(48)
        .width(300)
        .fontSize(16)
        .margin({ top: 16 })
        .onChange((value: string) => {
          this.password1 = value
        })
      TextInput({ placeholder:'请再次输入密码'})
        .type(InputType.Password)
        .height(48)
        .width(300)
        .fontSize(16)
        .margin({ top: 16, bottom: 25 })
        .onChange((value: string) => {
          this.password2 = value
        })
      // 已有账号，去登录
      Row() {
        Text('已有账号，去').fontSize(16)
        Text('登录').fontSize(16).fontColor('#ff45d7ea').onClick(() => {
          router.pushUrl({ url: 'pages/Login' })
        })
      }
      Button('确认注册')
        .width(300)
        .height(48)
        .backgroundColor('#ff17bc9b')
        .fontSize(16)
        .fontColor('#FFFFFF')
        .margin({ bottom: 16, top: 16 })
        .onClick(() => {
          this.userRegister()
        })
    }
    .width('100%')
    .padding(30)
  }
}
