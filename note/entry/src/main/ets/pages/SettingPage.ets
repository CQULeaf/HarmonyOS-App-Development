import router from '@ohos.router';

@Entry
@Component
struct SettingPage {
  @StorageProp('CurrentUsername') username: string = ''

  build() {
    Column() {
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .margin({ left: 15 })
          .onClick(() => {
            router.back()
          })

        Text('设置')
          .fontSize(25)
          .fontColor('#9B0000')
          .margin({ left: 130 })

        Blank()
          .layoutWeight(1)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
      .width('100%')

      // 用户信息显示部分
      Column() {
        Row() {
          // 头像
          Image($r('app.media.avatar'))// 默认头像图片
            .width(80)
            .height(80)
            .borderRadius(40)
            .margin({ top: 20, bottom: 10, right: 50 })
            .objectFit(ImageFit.Cover)

          // 用户名
          Text(this.username)
            .fontSize(40)
            .fontColor('#147D42')
            .margin({ top: 20, bottom: 10, left: 50 })
        }

        // 修改密码
        Row() {
          Image($r('app.media.password'))
            .width(40)
            .height(40)
            .margin(10)

          Text('修改密码')
            .fontSize(15)
            .onClick(() => {
              router.pushUrl({ url: 'pages/ChangePasswordPage' })
            })

          Blank()
            .layoutWeight(1)

          Image($r('app.media.enter'))
            .width(30)
            .height(30)
        }

        // 退出登录
        Row() {
          Image($r('app.media.logout'))
            .width(40)
            .height(40)
            .margin(10)

          Text('退出登录')
            .fontSize(15)
            .onClick(() => {
              router.pushUrl({ url: 'pages/LoginPage' })
            })

          Blank()
            .layoutWeight(1)

          Image($r('app.media.enter'))
            .width(30)
            .height(30)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
  }
}