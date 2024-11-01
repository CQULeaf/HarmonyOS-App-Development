import { imageModel } from '../Bean/ImageModel'
import { CasualModeController } from '../Controller/CasualModeController'

@Component
struct ModeSelector {
  @Link row_col_num: number
  @Link start: boolean
  @Link stop: boolean
  @Link imageModel: imageModel
  textTimerController: TextTimerController = new TextTimerController()
  @Prop controller: CasualModeController

  build() {
    Row() {
      Column() {
        Select([
          { value: '入门：3 x 3', icon: $r('app.media.CasualMode') },
          { value: '初级：4 x 4', icon: $r('app.media.CasualMode') },
          { value: '中级：5 x 5', icon: $r('app.media.CasualMode') },
          { value: '高级：6 x 6', icon: $r('app.media.CasualMode') }
        ])
          .alignSelf(ItemAlign.Center)
          .margin({ left: 10, right: 10 })
          .value('级别：' + this.row_col_num.toString() + ' x ' + this.row_col_num.toString())
          .font({ size: 25, weight: FontWeight.Bold })
          .fontColor('#182431')
          .selectedOptionFont({ size: 25, weight: 400 })
          .optionFont({ size: 25, weight: 400 })
          .margin({ left: 10 })
          .onSelect((index: number) => {
            if (this.start) {
              AlertDialog.show({
                message: '已为您自动暂停游戏并切换模式'
              })
              this.start = false
              this.stop = true
            }
            this.textTimerController.reset()
            this.imageModel.steps = 0
            this.row_col_num = index + 3
            this.controller.aboutToAppear()
            console.log('row_col_num:', this.row_col_num)
          })
      }.width('100%')
    }
    .id('select')
    .width('97%')
    .height(40)
    .margin({ bottom: 20 })
    .alignRules({
      top: { anchor: 'switch', align: VerticalAlign.Bottom },
      middle: { anchor: '__container__', align: HorizontalAlign.Center }
    })
    .justifyContent(FlexAlign.Start)
    .borderColor(Color.White)
    .borderWidth(5)
    .borderRadius(10)
  }
}

export { ModeSelector }