import { router } from '@kit.ArkUI'
import {myParam} from '../pages/Index'
@Entry
@Component
struct ResultPage {
  @State results: Array<string> = []

  aboutToAppear(): void {
    let myParam = router.getParams() as myParam;
    console.log('传递的参数:', myParam); // 打印查看传递过来的参数

    if (myParam) {
      this.results = myParam.result; // 正确地访问data1并赋值给results
    } else {
      console.log('没有获取到正确的参数');
    }
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.back_arrow'))
          .width(24)
          .height(24)
          .margin({ left: 26 })
          .objectFit(ImageFit.Contain)
          .onClick(() => {
            router.back()
          })
        Text('计算结果')
          .fontSize(30)
          .textAlign(TextAlign.Center)
          .margin({ top: 10 })
          .fontWeight(FontWeight.Bold)
        //添加占位符填充剩余空间
        Text('')
          .width(24)
          .height(24)
          .margin({ right: 26 })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      Text(`共有${this.results.length}种解法`).margin({ top: 10, bottom: 10 }).fontSize(20)

      if (this.results.length === 0) {
        Text('您目前选择的四张牌无法计算出24点，请重新选择！').margin({ top: 10 }).fontSize(30)
      } else {
        List() {
          //显示计算结果
          ForEach(this.results, (item: string, index) => {
            ListItem() {
              Row() {
                Text((index + 1).toString()).fontSize(30).width(40).textAlign(TextAlign.End)
                Text(item).fontSize(30).textAlign(TextAlign.Start)
              }
              .justifyContent(FlexAlign.SpaceEvenly).width('100%').margin({ top: 10 })
            }.width('100%')
          })
        }.margin(10).divider({ strokeWidth: 3 })
      }
    }
      .height('100%')
      .width('100%')
      .margin({ bottom: 5 })
  }
}