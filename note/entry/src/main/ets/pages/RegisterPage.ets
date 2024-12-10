import { router } from '@kit.ArkUI'
import { userRegister } from '../api/user'
import CommonConstants from '../common/CommonConstants'

interface ResponseUserRegister {
  id: number;
  username: string;
  password: string;
  createdAt: string;
  updatedAt: string;
}

@Entry
@Component
struct RegisterPage {
  private username: string = ''
  private password1: string = ''
  private password2: string = ''

  // 实现注册请求
  async userRegister() {
    try {
      const res = await userRegister<ResponseUserRegister>(this.username, this.password1, this.password2)

      console.log('注册成功:', res)
      AlertDialog.show({
        message: '注册成功，请登录'
      })
      router.pushUrl({ url: 'pages/LoginPage' })
    } catch (error) {
      console.error('注册请求错误', error)

      if (error.message && error.message.includes('用户名已存在')) {
        AlertDialog.show({
          message: '用户名已存在, 请重新输入'
        })
      } else if (error.message && error.message.includes('两次密码输入不一致')) {
        AlertDialog.show({
          message: '两次密码输入不一致，请重新输入'
        })
      } else {
        AlertDialog.show({
          message: '登录失败，请检查网络连接或稍后重试'
        })
      }
    }
  }

  build() {
    Column() {
      Text('注册您的专属账号')
        .fontSize(28)
        .margin({ bottom: 25 })
        .fontColor(CommonConstants.app_color)
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
      TextInput({ placeholder:'请确认密码'})
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
        Text('登录').fontSize(16).fontColor('#6E9C55').onClick(() => {
          router.pushUrl({ url: 'pages/LoginPage' })
        })
      }
      Button('确认注册')
        .width(300)
        .height(48)
        .backgroundColor(CommonConstants.app_color)
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
