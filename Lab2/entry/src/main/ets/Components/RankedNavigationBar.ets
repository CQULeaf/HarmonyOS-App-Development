import { imageModel } from '../Bean/ImageModel'
import { router } from '@kit.ArkUI'
import { imageOrigin } from '../Bean/ImageOrigin'

/*
  顶部导航栏组件，包含了返回按钮、步数显示等功能
 */

@Component
struct RankedNavigationBar {
  @Link imageList: imageOrigin[]
  @Link imageModel: imageModel

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
      // 一个按钮，点击进入排行榜页面
      Image($r('app.media.RankedIcon'))
        .onClick(() => {
          router.pushUrl({ url: 'pages/Rank' })
        })
        .width(30)
        .height(30)
        .margin({ left: 100 })
        .interpolation(ImageInterpolation.High)
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
}

export { RankedNavigationBar }