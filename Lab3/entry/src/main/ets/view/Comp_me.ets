
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
  build() {
    Column(){
      Row() {
        Image($rawfile('user.png'))
          .width('60vp')
          .height('60vp')
          .margin({ right:'30vp' })

        Text('小竞快跑')
          .height('60vp')
          .fontSize('20vp')
          .fontColor(Color.White)
          .margin({ right:'30vp' })

        if (!this.flag) {
          Row(){
            Column(){
              Image($r('app.media.daka'))
                .width(30)
                .height(30)
                .backgroundColor(Color.White)
                .fillColor($r('app.color.themeColor'))
            }
            Column(){
              Text("每日打卡")
                .fontSize(20)
                .height(30)
                .backgroundColor('#a2e1f2')
            }
          }
          .borderRadius(10)
          .onClick(() => {
            this.flag = true;
            this.punching_day  = this.punching_day + 1;
            this.showPunchingDay = this.punching_day
            AppStorage.setOrCreate('PunchingDay', this.punching_day)
          })
        } else {
          Row(){
            Text('已打卡')
              .backgroundColor(Color.White)
              .height(20)
              .borderRadius(10)
          }
          .onClick(()=>{
            AlertDialog.show({
              message:'今天已经打卡了哦~'
            })
          })
        }

      }.margin({ left:'0vp',top:'30vp',bottom:'10vp' })


      Row(){
        Column(){
          Text(this.showPunchingDay.toString())
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
          Text('连续打卡天数')
            .fontSize(15)
            .fontWeight(FontWeight.Normal)
        }
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
        ListItem() {
          Row() {
            Image($rawfile('geren.png'))
              .width(40)
              .height(40)
              .margin(10)

            Text('个人信息')
              .fontSize(15)

            Blank()
              .layoutWeight(1)

            Image($rawfile('enter.png'))
              .width(30)
              .height(30)
              .margin(10)
          }
        }.onClick(() => {
          this.clickNext1()
          router.pushUrl({ url: 'pages/BillPage' })
        })

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
  clickNext1() {
    router.pushUrl({
      url: 'pages/TestPage',
      params: {
        data1: 'message',
        data2: {
          data3: [123, 456, 789]
        },
      },
    });
  }
}