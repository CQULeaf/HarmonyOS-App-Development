import { CustomDialogDemo } from '../Components/CustomDialogDemo'
import { NavigationBar } from '../Components/NavigationBar'
import { GameGrid } from '../Components/GameGrid'
import { TimerComponent } from '../Components/TimerComponent'
import { ControlButtons } from '../Components/ControlButtons'
import { DifficultySelector } from '../Components/DifficultySelector'
import { ImageList } from '../Components/ImageList'
import { ModeSelector } from '../Components/ModeSelector'
import { imageModel } from '../Bean/ImageModel'
import { imageOrigin } from '../Bean/ImageOrigin'
import { subImage } from '../Bean/SubImage'
import CasualModeController from '../Controller/CasualModeController'
import image from '@ohos.multimedia.image'

@Entry
@Component
struct CasualMode {
  dialogControllerStart: CustomDialogController = new CustomDialogController({
    builder: CustomDialogDemo({
      messageDialog: '        您目前选择的模式为“娱乐模式”！在该模式下，您可以随意选择游戏级别，同时您也不必关于关注步数与用时等。' +
        '您可以随意选择图片，然后开始游戏，您也可以随时暂停、重置或者继续游戏！对于“难度选择”，当您选择了困难，则图片上没有数字标识，反之则有。' +
        '当您在困难模式下没有头绪时，可以点击右上方图标，会为您展示原始图片情况。祝您游戏愉快！',
      messageTitle: '娱乐模式玩法介绍',
      imgRes: $r('app.media.CasualMode'),
      cancel: () => { this.dialogControllerStart.close() },
      confirm: () => { this.dialogControllerStart.close() }
    })
  })

  @State imageList: imageOrigin[] = []
  @State imageModel: imageModel = new imageModel()
  @State customPopup: boolean = false

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
        NavigationBar({
          imageList: this.imageList,
          imageModel: this.imageModel,
          selected_img_index: this.selected_img_index,
          customPopup: this.customPopup
        })
        GameGrid({
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
        ModeSelector({
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