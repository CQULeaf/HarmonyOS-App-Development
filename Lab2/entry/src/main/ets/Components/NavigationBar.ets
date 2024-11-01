import { imageModel } from '../Bean/ImageModel'
import { router } from '@kit.ArkUI'
import { imageOrigin } from '../Bean/ImageOrigin'

/*
  顶部导航栏组件，包含了返回按钮、步数显示等功能
 */

@Component
struct NavigationBar {
  @Link imageList: imageOrigin[]
  @Link imageModel: imageModel
  @Link selected_img_index: number
  @Link customPopup: boolean

  build() {
    Row() {
      Image($r('app.media.ic_arrow_left'))
        .size({ width: 30, height: 30 })
        .margin({ left: 10 })
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          router.back()
        })
      Text('步数：' + this.imageModel.steps)
        .fontSize(25)
        .margin({ left: 100 })
      // Row().height(2).backgroundColor('#E6E6FA').width('100%')
      Image($r('app.media.ic_public_help_filled'))
        .width(30)
        .height(30)
        .margin({ left: 100 })
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          this.customPopup = !this.customPopup
        })
        .bindPopup(this.customPopup, {
          builder: this.popupBuilder,
          placement: Placement.Bottom,
          popupColor: Color.Pink
        })
      Row().height(2).backgroundColor('#E6E6FA').width('100%')
    }
    .width('100%')
    .height(40)
    .borderRadius(2)
    // .alignRules({
    //   top: { anchor: '__container__', align: VerticalAlign.Top },
    //   middle: { anchor: '__container__', align: HorizontalAlign.Center }
    // })
    // .id('tabGame')
  }
  @Builder
  popupBuilder() {
    Row({ space: 2 }) {
      Column() {
        Text('给您一点提示哈，再次点击图标可关闭')
          .fontSize(16)
          .fontWeight(900)
          .fontColor(Color.Black)
          .width('100%')
          .fontWeight(FontWeight.Bold)
          .margin({left: 10})
        Image(this.imageList[this.selected_img_index + 1].imgSource).width(300)
          .height(300).interpolation(ImageInterpolation.High)
      }
    }.width(320).height(360).padding(5)
  }
}

export { NavigationBar }