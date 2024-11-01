import { router } from '@kit.ArkUI'
import axios, { AxiosError, AxiosResponse } from '@ohos/axios'

interface UserInfo {
  username: string
  password: string
}

@Entry
@Component
struct LoginPage {
  private username: string = ''
  private password: string = ''

  // 实现登录请求
  userLogin(): Promise<void> {
    return new Promise((resolve, reject) => {
      axios.post<string, AxiosResponse<string>, UserInfo>('http://192.168.180.182:8080/user/login', {
        username: this.username,
        password: this.password
      }).then((response: AxiosResponse) => {
        if (response.data.code === 200) {
          console.log(response.data.msg)
          resolve()
          router.pushUrl({ url: 'pages/Index' })
        } else {
          console.log(response.data.msg)
          reject(new Error('登录失败'))
          AlertDialog.show({
            message: '用户名或密码错误，请重新尝试'
          })
        }
      }).catch((error: AxiosError) => {
        console.log('登录失败', error)
        reject(error)
        AlertDialog.show({
          message: '登录失败，请检查网络连接'
        })
      })
    })
  }

  build() {
    Column() {
      Image($r('app.media.POINT_CALCULATION'))
        .width('100%')
        .height('35%')
        .margin({ bottom: 20 })

      Column() {
        Text('欢迎体验游戏')
          .fontSize(20)
          .fontSize(25)
          .fontColor('#fff80000')
          .margin({ bottom: 30, top: 20 })
        TextInput({ placeholder: '请输入用户名' })
          .width(300)
          .height(48)
          .fontSize(16)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .margin({ bottom: 16 })
          .onChange((value: string) => {
            this.username = value
          })
        TextInput({ placeholder: '请输入密码' })
          .width(300)
          .height(48)
          .fontSize(16)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .margin({ bottom: 16 })
          .type(InputType.Password)
          .onChange((value: string) => {
            this.password = value
          })
        Button('登录')
          .width(300)
          .height(48)
          .backgroundColor('#ff45d7ea')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .margin({ bottom: 16 })
          .onClick(() => {
            console.log('登录')
            this.userLogin()
          })
        Button('注册')
          .width(300)
          .height(48)
          .backgroundColor('#ff17bc9b')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .margin({ bottom: 16 })
          .onClick(() => {
            console.log('注册')
            router.pushUrl({ url: 'pages/RegisterPage' })
          })
      }
      .width('90%')
      .height('50%')
      .padding({ left: 10, right: 10 })
      .borderRadius(10)
      .shadow({
        radius: 10,
        color: '#000000',
        offsetX: 4,
        offsetY: 8
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}
