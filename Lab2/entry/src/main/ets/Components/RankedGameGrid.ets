import { subImage } from '../Bean/SubImage'
import { imageModel } from '../Bean/ImageModel'
import { updateScore } from '../api/Rank'

interface ResponseUpdateScore {
  msg: string
}

@Component
struct RankedGameGrid {
  @Link subImages: subImage[]
  @Link row_col_num: number
  @Link imageModel: imageModel
  @Link start: boolean
  textTimerController: TextTimerController = new TextTimerController()
  @Link isHard: boolean
  @Link useTime: number
  @StorageLink('CurrentScore') currentScore: number = 0
  @StorageProp('CurrentUsername') username: string = ''

  async updateScore() {
    const res = await updateScore<ResponseUpdateScore>(this.username, this.currentScore)
    console.log('updateScore:', res)
  }

build() {
  Row() {
    GridRow({ columns: this.row_col_num, gutter: { x: 1, y: 1 } }) {
      ForEach(this.subImages, (item: subImage) => {
        GridCol() {
          Stack() {
            Image(item.pixelMap).width('100%').height('100%')
              .interpolation(ImageInterpolation.Low)
            Text(this.isHard ? "" : item.truePosition.toString())
              .fontSize(30).fontColor('#c8c6b6')
          }.height(`${100 / this.row_col_num}%`).width('100%')
        }.onClick(() => {
          if (this.start) {
            console.log('游戏行列数', this.row_col_num)
            this.subImages = this.imageModel.exchangePic(item.truePosition, this.subImages, this.row_col_num)
            if (this.imageModel.isSuccess(this.subImages) && this.start) {
              this.start = false
              this.textTimerController.pause()
              // 每次通关加20分
              this.currentScore += 20
              this.updateScore()
              AlertDialog.show({
                message: '恭喜通关！！！\n' + '本次用时：' + Math.floor((this.useTime / 1000000)) + 'min' +
                  `${this.useTime}s\n` + '本次步数：' + `${this.imageModel.steps}步\n` + '您的本局得分：20\n' +
                  '您的当前积分：' + this.currentScore
              })
              this.imageModel.steps = 0
              this.textTimerController.reset()
            }
          } else {
            AlertDialog.show({
              message: '请先点击“开始”按钮开始游戏'
            })
          }
        })
      })
    }.width('100%').height('100%')
  }
  .backgroundColor(Color.White)
  .alignRules({
    top: { anchor: 'tabGame', align: VerticalAlign.Bottom },
    middle: { anchor: '__container__', align: HorizontalAlign.Center }
  })
  .width(310)
  .height(250)
  .margin({ top: 15 })
  .borderWidth(5)
  .borderRadius(10)
  .borderColor(Color.Pink)
  .id('imgGrid_layout')
}
}

export { RankedGameGrid }