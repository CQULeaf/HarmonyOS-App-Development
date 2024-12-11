import { router } from '@kit.ArkUI'
import { userLogin } from '../api/user'
import CommonConstants from '../common/CommonConstants'
import UserModel from '../bean/UserModel'

@Entry
@Component
struct LoginPage {
  private username: string = ''
  private password: string = ''

  async userLogin() {
    try {
      const res = await userLogin<UserModel>(this.username, this.password)

      console.log('登录成功:', res)
      AppStorage.setOrCreate('CurrentUsername', res.username)

      router.pushUrl({ url: 'pages/Index' })
    } catch (error) {
      // 处理不同类型的错误，给出不同的提示
      console.error('登录请求错误', error)

      // 根据错误类型定制弹窗提示
      if (error.message && error.message.includes('用户名或密码错误')) {
        // 用户名或密码错误
        AlertDialog.show({
          message: '用户名或密码错误，请重新输入'
        })
      } else {
        // 默认错误
        AlertDialog.show({
          message: '登录失败，请检查网络连接或稍后重试'
        })
      }
    }
  }

  build() {
    Column() {
      Image($r('app.media.app_icon'))
        .width('100%')
        .height('35%')
        .margin({ bottom: 20 })

      Column() {
        Text('欢迎使用便捷记')
          .fontSize(20)
          .fontSize(25)
          .fontColor(CommonConstants.app_color)
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
          .backgroundColor('#275A3B')
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
          .backgroundColor('#6E9C55')
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
