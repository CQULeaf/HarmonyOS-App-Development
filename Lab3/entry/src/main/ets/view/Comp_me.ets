import router from '@ohos.router'
@Component
export default struct Comp_me {
  private swiperController: SwiperController = new SwiperController()

  @State start: boolean = true
  private fromStart: boolean = true
  private step: number = 50
  private loop: number = Infinity
  @State flag:boolean = false
  @StorageProp('PunchingDay') punching_day:number = 0
  @State showPunchingDay:number = this.punching_day
  private src: string = "橙子记账3.2.0将在四天之后发布，将会新增生成个人报表的功能，开发者联系方式:18184760749"
  @StorageProp('CurrentUsername') username: string = ''
  build() {
    Column(){
      Row() {
        Image($rawfile('avatar.jpg'))
          .width('60vp')
          .height('60vp')
          .margin({ right:'50vp'})

        Text(this.username)
          .height('60vp')
          .fontSize('40vp')
          .fontColor('#9B0000')
          .margin({ right:'30vp' })
      }.margin({ left:'0vp',top:'30vp',bottom:'10vp' })


      Row(){
        Column(){
          Text('3')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
          Text('记账笔数')
            .fontSize(15)
            .fontWeight(FontWeight.Normal)
        }
        Column(){
          Text('5')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
          Text('记账天数')
            .fontSize(15)
            .fontWeight(FontWeight.Normal)
        }
      }.width('100%').justifyContent(FlexAlign.SpaceAround)

      List({ space: 1 }) {
      //   ListItem() {
      //     Row() {
      //       Image($rawfile('geren.png'))
      //         .width(40)
      //         .height(40)
      //         .margin(10)
      //
      //       Text('个人信息')
      //         .fontSize(15)
      //
      //       Blank()
      //         .layoutWeight(1)
      //
      //       Image($rawfile('enter.png'))
      //         .width(30)
      //         .height(30)
      //         .margin(10)
      //     }
      //   }.onClick(() => {
      //     router.pushUrl({ url: 'pages/BillPage' })
      //   })
        ListItem() {
          Row() {
            Image($rawfile('mima.png'))
              .width(40)
              .height(40)
              .margin(10)

            Text('修改密码')
              .fontSize(15)

            Blank()
              .layoutWeight(1)

            Image($rawfile('enter.png'))
              .width(30)
              .height(30)
              .margin(10)
          }.onClick(() => {
            router.pushUrl({ url: 'pages/FrogetPage' })
          })
        }

        ListItem() {
          Row() {
            Image($rawfile('hl.png'))
              .width(40)
              .height(40)
              .margin(10)

            Text('汇率计算')
              .fontSize(15)

            Blank()
              .layoutWeight(1)

            Image($rawfile('enter.png'))
              .width(30)
              .height(30)
              .margin(10)
          }
        }.onClick(() => {
          router.pushUrl({ url: 'pages/HelpPage' })
        })

        ListItem() {
          Row() {
            Image($rawfile('tuichu.png'))
              .width(40)
              .height(40)
              .margin(10)

            Text('退出登录')
              .fontSize(15)

            Blank()
              .layoutWeight(1)

            Image($rawfile('enter.png'))
              .width(30)
              .height(30)
              .margin(10)
          }.onClick(() => {
            router.pushUrl({ url: 'pages/LoginPage' })
          })
        }
      }.divider({
        strokeWidth: 1,
        startMargin: 90,
        endMargin: 10,
        color: '#000000'
      })
      .width('94%')
      .borderRadius($r('app.float.radius_size_L'))
      .backgroundColor('#a2e1f2')
      .margin({top : 30})
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.themeColor'))
  }
}