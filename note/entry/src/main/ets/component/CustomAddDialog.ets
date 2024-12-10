@Component
export default struct CustomAddDialog {
  @Link addContent: string

  build() {
    Stack() {
      // 蒙层
      Rect()
        .height('100%')
        .width('100%')
        .fill('rgba(0,0,0,0.4)')
        .onClick(() => {
          this.onClose()
        })

      // 编辑卡片
      Column() {

        // 文本输入

        TextArea({
          placeholder: '请输入笔记',
          text: this.addContent
        })
          .onChange((value: string) => {
            this.addContent = value
          })
          .height('70%')
          .margin(20)


        // 按钮
        Row() {
          // 返回
          Column() {
            Image($r('app.media.back'))
              .width(24)
          }
          .backgroundColor('#BFA290')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.onClose()
          })


          // 保存
          Column() {
            Image($r('app.media.save'))
              .width(24)
          }
          .backgroundColor('#9E7F6B')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.onCreate()
          })

        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .width('100%')
      .height('50%')
      .borderRadius({ topLeft: 16, topRight: 16 })
      .backgroundColor('#F0D9B8')

    }
    .height('100%')
    .width('100%')
    .alignContent(Alignment.Bottom)

  }

  onCreate() {
  }

  onClose() {
  }
}

@Preview
@Component
struct CustomEditDialogPreView {
  @State addContent: string = ''

  build() {
    CustomAddDialog({ addContent: $addContent })
  }
}