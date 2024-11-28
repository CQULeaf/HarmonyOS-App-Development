import router from '@ohos.router'
import prompt from '@ohos.promptAction';
import CommonConstants from '../common/constants/CommonConstants';
import { userChangePw } from '../api/user'

interface ResponseUserChangePw {
  id: number;
  username: string;
  password: string;
  createdAt: string;
  updatedAt: string;
}

@Entry
@Component
export struct ChangePwPage {
  @StorageProp('CurrentUsername') username: string = ''
  private oldPassword: string = ''
  private newPassword1: string = ''
  private newPassword2: string = ''

  async userChangePw() {
    try {
      const res = await userChangePw<ResponseUserChangePw>(this.username, this.oldPassword, this.newPassword1, this.newPassword2)

      console.log('修改密码成功:', res)
      router.pushUrl({ url: 'pages/MainPage' })
    } catch (error) {
      // 处理不同类型的错误，给出不同的提示
      console.error('修改密码请求错误', error)

      // 根据错误类型定制弹窗提示
      if (error.message && error.message.includes('用户名或密码错误')) {
        // 用户名或密码错误
        AlertDialog.show({
          message: '用户名或密码错误，请重新输入'
        })
      } else {
        // 默认错误
        AlertDialog.show({
          message: '修改密码失败，请检查网络连接或稍后重试'
        })
      }
    }
  }

  build() {
    Column() {
      Text("修改密码")
        .fontSize(40)
        .fontColor('#9B0000')
        .margin({top:'60vp',bottom:'20vp'})

      TextInput({
        placeholder:"请输入您的旧密码",
      })
        .width('90%')
        .height(50)
        .margin(10)
        .borderRadius(25)
        .type(InputType.Normal)
        .onChange((value: string) => {
          this.oldPassword = value;
        }).backgroundColor(Color.White)

      TextInput({ placeholder:"请输入您的新密码"})
        .width('90%')
        .height(50)
        .margin(10)
        .borderRadius(25)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.newPassword1 = value;
        }).backgroundColor(Color.White)

      TextInput({ placeholder:"请确认您的新密码"})
        .width('90%')
        .height(50)
        .margin(10)
        .borderRadius(25)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.newPassword2 = value;
        }).backgroundColor(Color.White)

      Button('确认修改',{type:ButtonType.Capsule})
        .backgroundColor(Color.White)
        .fontColor(Color.Black)
        .width(200)
        .height(55)
        .fontSize(30)
        .margin(30)
        .borderRadius(30)
        .onClick(() => {
          this.userChangePw()
        })
    }.width('100%').height('100%').backgroundColor($r('app.color.themeColor'))
  }
}
