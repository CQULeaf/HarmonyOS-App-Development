import { imageModel } from '../Bean/ImageModel'
import { subImage } from '../Bean/SubImage'
import { CasualModeController } from '../Controller/CasualModeController'

@Component
struct ControlButtons {
  @Link start: boolean
  @Link stop: boolean
  textTimerController: TextTimerController = new TextTimerController()
  @Link imageModel: imageModel
  @Link subImages: subImage[]
  @Link row_col_num: number
  @Prop controller: CasualModeController

  build() {
    Row() {
      Column() {
        Button() {
          Text('开始').fontSize(25).fontWeight(FontWeight.Bold).fontColor('#05030a')
        }.height(50).width(110).backgroundColor('#fb9b69')
        .onClick(() => {
          if (this.start) {
            this.textTimerController.start()
            this.stop = false
          } else if (this.stop) {
            this.subImages = this.shuffleSubImages(this.subImages)
            this.start = true
            this.imageModel.steps = 0
            this.textTimerController.start()
          }
        })
      }

      Column() {
        Button() {
          Text('暂停').fontSize(25).fontWeight(FontWeight.Bold).fontColor('#05030a')
        }.height(50).width(110).backgroundColor('#fb9b69')
        .onClick(() => {
          this.textTimerController.pause()
          this.stop = true
        })
      }.margin({ left: 10 })

      Column() {
        Button() {
          Text('重置').fontSize(25).fontWeight(FontWeight.Bold).fontColor('#05030a')
        }.height(50).width(110).backgroundColor('#fb9b69')
        .onClick(() => {
          // 给出弹窗提示
          AlertDialog.show({
            message: '已重置，点击“开始”按钮重新开始游戏吧!'
          })
          this.textTimerController.reset()
          this.imageModel.steps = 0
          this.controller.aboutToAppear()
          this.start = false
          this.stop = true
        })
      }.margin({ left: 10 })
    }
    .id('buttonGroup')
    .alignRules({
      top: { anchor: 'timeCounter', align: VerticalAlign.Bottom },
      middle: { anchor: '__container__', align: HorizontalAlign.Center }
    })
    .margin({ top: 5 })
  }

  shuffleSubImages(subImages : subImage[]) : subImage[] {
    subImages = this.imageModel.shuffleArray(subImages)
    subImages.push(new subImage(this.row_col_num * this.row_col_num, this.row_col_num * this.row_col_num, null))
    return subImages
  }
}

export { ControlButtons }
