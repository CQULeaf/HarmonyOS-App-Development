@Entry
@Component
struct AppPage {
  @State rating: number = 0
  build() {
    Column(){
      Column(){
        Image($rawfile('user.png'))
          .width('120vp')
          .height('120vp')
          .margin({ top:'30vp' })
        Column({space: 5}) {

          Row({space: 5}) {
            Text('软件名:')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('20%')
              .margin({left:'10vp'})
            Text('橙子记账')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor(Color.Black)
          }.margin({top:'40vp'})

          Row({space: 5}) {
            Text('版本号:')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('20%')
              .margin({left:'10vp'})
            Text('3.0.1')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor(Color.Black)
          }

          Row({space: 5}) {
            Text('开发者:')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('20%')
              .margin({left:'10vp'})
            Text('copy rigt @祝志恒')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor(Color.Black)
          }

          Row({space: 5}) {
            Text('QQ:')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('20%')
              .margin({left:'10vp'})
            Text('1441866374')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor(Color.Black)
          }

          Row({space: 5}) {
            Text('电话:')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('20%')
              .margin({left:'10vp'})
            Text('18184760749')
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor(Color.Black)
          }

          Column() {
            Text('开发者微信')
              .fontSize(16)
              .fontColor(Color.Black)

            Image($rawfile('zzh.jpg'))
              .width('120vp')
              .height('120vp')
              .margin({ top:'10vp' })
          }.width(360).height(113).backgroundColor('#FFFFFF').margin({ top: 68 })

          Column() {
            Rating({ rating: this.rating, indicator: false })
              .stars(5)
              .stepSize(0.5)
              .margin({ top: 24 })
              .onChange((value: number) => {
                this.rating = value
              })
            Text('您的打分是' + this.rating)
              .fontSize(16)
              .fontColor('rgba(24,36,49,0.60)')
              .margin({ top: 16 })
          }.width(360).height(93).backgroundColor('#FFFFFF').margin({ top: 68 })
        }
        .alignItems(HorizontalAlign.Start)
      }.width('94%')
      .height('90%')
      .borderRadius('20vp')
      .backgroundColor(Color.White)
      .margin({ top: ('20vp') })
      .alignItems(HorizontalAlign.Center)
    }.width('100%')
    .height('100%')
    .backgroundColor(Color.Orange)
  }
}