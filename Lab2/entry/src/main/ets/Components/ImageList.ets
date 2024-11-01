import { imageOrigin } from '../Bean/ImageOrigin'
import { imageModel } from '../Bean/ImageModel'
import { CasualModeController } from '../Controller/CasualModeController'

@Component
struct ImageList {
  @Link imageList: imageOrigin[]
  @Link selected_img: string
  @Link selected_img_index: number
  @Link stop: boolean
  textTimerController: TextTimerController = new TextTimerController()
  @Link imageModel: imageModel
  @Prop controller: CasualModeController

  build() {
    Row() {
      List() {
        ForEach(this.imageList, (item: imageOrigin, index) => {
          ListItem() {
            Column() {
              Image(item.imgSource)
                .width('100%')
                .height('80%')
                .padding(8)
                .interpolation(ImageInterpolation.High)
                .onClick(() => {
                  if (this.stop) {
                    this.textTimerController.reset()
                    this.imageModel.steps = 0
                    this.selected_img = 'CQ' + item.imgId.toString() + '.jpg'
                    this.selected_img_index = index - 1
                    this.controller.aboutToAppear()
                  } else {
                    AlertDialog.show({
                      message: '请先暂停游戏再切换图片'
                    })
                  }
                })
            }
            .width('30%')
          }
          .backgroundColor('rgb(250, 250, 250)')
        })
      }
      .width('100%')
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Auto)
    }
    .height(130)
    .backgroundColor('rgb(242,242,242)')
    .borderRadius(5)
    .alignRules({
      bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
      middle: { anchor: '__container__', align: HorizontalAlign.Center }
    })
    .id('list')
    .margin({ bottom: 2 })
  }
}

export { ImageList }
