import { router } from '@kit.ArkUI'
import { CustomDialogDemo } from '../Components/CustomDialogDemo'

@Entry
@Component
struct Index {
  dialogControllerRule : CustomDialogController = new CustomDialogController({
    builder: CustomDialogDemo({
      messageDialog:'       历史背景：华容道游戏取自著名的三国故事，曹操在赤壁之战中被刘备和孙权的“苦肉计”“铁索连舟”打败，被迫退逃到华容道，' +
        '又遇上诸葛亮的伏兵，关羽为了报答曹操对他的恩情，明逼实让，终于帮助曹操逃出了华容道。' +
        '游戏就是依照“曹瞒兵败走华容，正与关公狭路逢。只为当初恩义重，放开金锁走蛟龙”这一故事情节。' +
        '\n' +
        '       模式选择：本游戏提供了两种游玩模式：“娱乐模式”与“天梯模式”。' +
        '“娱乐模式”允许您随意畅玩，您不必担心“用时”与“步数”等要素，同时还提供了“提示”功能；' +
        '“天梯模式”则拥有排行榜系统，其有游戏积分规则，需要您拥有一定的熟练度方可游戏。\n' +
        '       游戏规则：起始将您选中的图片完全打乱，然后每次移动一个子图，' +
        '目标是完整复原原图。',
      messageTitle: '游戏介绍',
      imgRes:$r('app.media.GameIntro'),
      cancel:() => {this.onCancel()},
      confirm: () => {this.onAccept()}
    })
  })
  dialogControllerAuthor : CustomDialogController = new CustomDialogController({
    builder:CustomDialogDemo({
      messageDialog:"名字：叶旭航\n地址：重庆大学\n邮箱:   cquleaf@yexuhang.com\n主页：https://yexuhang.com",
      messageTitle:'作者介绍',
      imgRes:$r('app.media.Avatar'),
      cancel:() => {this.onCancel()},
      confirm:() => {this.onAccept()}
    })
  })

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  build() {
    Column(){
      Text(){
        Span(' 拼 图 ')
          .fontSize(40)
          .decoration({type:TextDecorationType.Underline, color:Color.White})
          .fontColor('#ECD452')
        Span('华 容 道')
          .fontSize(50)
          .fontStyle(FontStyle.Italic)
          .fontColor('#2E59A7')
      }
      .margin({top:150})


      Button({type:ButtonType.Capsule, stateEffect:true}){
        Row(){
          Image($r('app.media.CasualMode')).width(25).height(25).margin({left:20})
            .interpolation(ImageInterpolation.High)
          Text('娱乐模式')
            .fontSize(25).fontColor('#002FA7')
            .margin({left:30, right:30})
        }
      }
      .width('60%')
      .height(50)
      .alignSelf(ItemAlign.Center)
      .margin({top:100}).borderRadius(10)
      .backgroundColor('#A0D3FF')
      .onClick(() => {
        router.pushUrl({ url: 'pages/CasualMode' })
      })


      Button({type:ButtonType.Capsule, stateEffect:true}){
        Row(){
          Image($r('app.media.RankedMode')).width(25).height(25).margin({left:20})
            .interpolation(ImageInterpolation.High)
          Text('天梯模式')
            .fontSize(25).fontColor('#F9DC24')
            .margin({left:30, right:30})
        }
      }
      .width('60%')
      .height(50)
      .alignSelf(ItemAlign.Center)
      .margin({top:20}).borderRadius(10)
      .backgroundColor('#B05923')
      .onClick(() => {
        router.pushUrl({ url: 'pages/RankedMode' })
      })

      Button({type:ButtonType.Capsule, stateEffect:true}){
        Row(){
          Image($r('app.media.GameIntro')).width(25).height(25).margin({left:20})
            .interpolation(ImageInterpolation.High)
          Text('游戏介绍')
            .fontSize(25).fontColor('#81D8D0')
            .margin({left:30, right:30})
        }
      }
      .width('60%')
      .height(50)
      .alignSelf(ItemAlign.Center)
      .borderRadius(10)
      .backgroundColor('#FF8AD0')
      .margin({top:20})
      .onClick(() => {
        this.dialogControllerRule.open()
      })

      Button(){
        Row(){
          Image($r('app.media.AuthorInfo'))
            .width(25)
            .height(25)
            .margin({left:20})
          Text('作者信息')
            .fontSize(25)
            .fontColor('#8F4B28')
            .margin({left:30, right:30})
        }
      }
      .margin({top:20})
      .borderRadius(10)
      .backgroundColor('#A886F6')
      .width('60%')
      .height(50)
      .alignSelf(ItemAlign.Center)
      .onClick(() => {
        this.dialogControllerAuthor.open()
      })

      // Button(){
      //   Row(){
      //     Image($r('app.media.Logout'))
      //       .width(25)
      //       .height(25)
      //       .margin({left:20})
      //     Text('退出登录')
      //       .fontSize(25)
      //       .fontColor('#fb9b69')
      //       .margin({left:30, right:30})
      //   }
      // }
      // .margin({top:20})
      // .borderRadius(10)
      // .backgroundColor('#05030a')
      // .width('60%')
      // .height(50)
      // .alignSelf(ItemAlign.Center)
      // .onClick(() => {
      //   router.pushUrl({ url: 'pages/Login' })
      //   AppStorage.clear()
      // })

    }.backgroundImage($r('app.media.CQ6'))
    .width('100%')
    .height('100%')
    .backgroundImageSize(ImageSize.Cover)
  }
  pageTransition() {
    // 定义页面进入时的效果，从左侧滑入，时长为1000ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ duration: 200 })
      .slide(SlideEffect.Left)
      .opacity(1)
    // 定义页面退出时的效果，相对于正常页面位置x方向平移100vp，y方向平移100vp，透明度变为0，时长为1200ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionExit({ duration: 200 })
      .translate({ x: 100.0, y: 100.0 })
      .opacity(0)
  }
}