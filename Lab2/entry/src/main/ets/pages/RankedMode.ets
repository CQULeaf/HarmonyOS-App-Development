import { CustomDialogDemo } from '../Components/CustomDialogDemo'
import { RankedNavigationBar } from '../Components/RankedNavigationBar'
import { RankedGameGrid } from '../Components/RankedGameGrid'
import { TimerComponent } from '../Components/TimerComponent'
import { ControlButtons } from '../Components/ControlButtons'
import { DifficultySelector } from '../Components/DifficultySelector'
import { ImageList } from '../Components/ImageList'
import { RankedModeSelector } from '../Components/RankedModeSelector'
import { imageModel } from '../Bean/ImageModel'
import { imageOrigin } from '../Bean/ImageOrigin'
import { subImage } from '../Bean/SubImage'
import CasualModeController from '../Controller/CasualModeController'
import image from '@ohos.multimedia.image'

@Entry
@Component
struct RankedMode {
  dialogControllerStart: CustomDialogController = new CustomDialogController({
    builder: CustomDialogDemo({
      messageDialog: '        您目前选择的模式为“天梯模式”！在该模式下，您需要尽快复原图片，同时您需要关注自己所用步数。' +
        '我们提供了积分制与天梯榜，对于不同级别下的不同时长与步数，我们有阶梯制积分规则。当您达到制定积分时可以获得荣誉称号，才可以选择相应的级别' +
        '天梯模式下没有提示，右上方图片为排行榜，可以查阅实时积分排名。祝您上分顺利！\n' +
        '       青铜：10 + 5（时长＜1min） + 5 (步数＜100步） + 5（困难模式）\n' +
        '       白银（达到50分解锁）：20 + 10（时长＜4min） + 10 （步数＜300步） + 10（困难模式）\n' +
        '       星耀（达到150分解锁）：40 + 20（时长＜10min） + 20 （步数＜600步） + 20（困难模式）\n' +
        '       王者（达到300分解锁）：70 + 35（时长＜15min） + 35 （步数＜1000步） + 35（困难模式）\n',
      messageTitle: '天梯模式玩法介绍',
      imgRes: $r('app.media.RankedMode'),
      cancel: () => { this.dialogControllerStart.close() },
      confirm: () => { this.dialogControllerStart.close() }
    })
  })

  @StorageLink('CurrentScore') currentScore: number = 0

  @State imageList: imageOrigin[] = []
  @State imageModel: imageModel = new imageModel()

  textTimerController: TextTimerController = new TextTimerController()
  @State format: string = 'mm:ss'
  @State useTime: number = 0

  @State start: boolean = false
  @State stop: boolean = true
  @State subImages: subImage[] = []
  @State row_col_num: number = 3

  @State isHard: boolean = true

  @State selected_img: string = 'CQ1.jpg'
  @State selected_img_index: number = 0

  private scroller: Scroller = new Scroller()
  private controller = CasualModeController;

  async aboutToAppear(){
    console.log('触发了 aboutToAppear 方法')
    console.log('Initial selected_img:', this.selected_img)
    this.controller.aboutToAppear = this.aboutToAppear.bind(this);
    const context = getContext(this)
    const resourceMgr = context.resourceManager
    const fileData = await resourceMgr.getRawFileContent(this.selected_img)
    const buffer = fileData.buffer
    console.log('Selected Image Path:', this.selected_img)
    const imgSource = image.createImageSource(buffer)
    this.subImages = []
    const tmp = await this.imageModel
      .splitPicByImageSource(imgSource, this.row_col_num)
    tmp.pop()
    this.subImages = tmp
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        RankedNavigationBar({
          imageList: this.imageList,
          imageModel: this.imageModel
        })
        // 显示用户当前积分
        Text('当前您的积分：' + this.currentScore)
          .fontSize(20)
          .fontColor('#182431')
          .margin({ top: 10, left: 10, right: 30 })
        RankedGameGrid({
          subImages: this.subImages,
          row_col_num: this.row_col_num,
          imageModel: this.imageModel,
          start: this.start,
          textTimerController: this.textTimerController,
          isHard: this.isHard,
          useTime: this.useTime
        })
        TimerComponent({
          textTimerController: this.textTimerController,
          format: this.format,
          useTime: this.useTime
        })
        ControlButtons({
          start: this.start,
          stop: this.stop,
          textTimerController: this.textTimerController,
          imageModel: this.imageModel,
          subImages: this.subImages,
          row_col_num: this.row_col_num,
          controller: this.controller
        })
        DifficultySelector({ isHard: this.isHard })
        RankedModeSelector({
          row_col_num: this.row_col_num,
          start: this.start,
          stop: this.stop,
          textTimerController: this.textTimerController,
          imageModel: this.imageModel,
          controller: this.controller
        })
        ImageList({
          imageList: this.imageList,
          selected_img: this.selected_img,
          selected_img_index: this.selected_img_index,
          stop: this.stop,
          textTimerController: this.textTimerController,
          imageModel: this.imageModel,
          controller: this.controller
        })
      }
    }
  }
  onPageShow(): void {
    for(let i = 1; i <= 16; i++){
      this.imageList.push(new imageOrigin(i, $r(`app.media.CQ${i}`)))
    }
    this.aboutToAppear()
    this.dialogControllerStart.open()
  }
}