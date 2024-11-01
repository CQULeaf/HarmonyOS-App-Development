import { CardItemBean } from '../ViewModel/CardItemBean'
import CardDataModel from '../ViewModel/CardDataModel'
import CardItemComp from '../View/CardItemComp'
import { Cal24Model } from '../ViewModel/Cal24Model'
import { router } from '@kit.ArkUI'

export class myParam {
  result: string[] = []
  static result: string[]
}

@Entry
@Component
struct Index {
  @State dataLoaded: boolean = false
  @State selectCards: Array<CardItemBean> = [] //选中的扑克牌
  private HeartCards: Array<CardItemBean> = [] //红心卡片
  private DiamondCards: Array<CardItemBean> = [] //方块卡片
  private ClubCards: Array<CardItemBean> = [] //梅花卡片
  private SpadeCards: Array<CardItemBean> = [] //黑桃卡片

  aboutToAppear(): void {
    if (!this.dataLoaded) {
      this.HeartCards = CardDataModel.getHeartData()
      this.DiamondCards = CardDataModel.getDiamondData()
      this.ClubCards = CardDataModel.getClubData()
      this.SpadeCards = CardDataModel.getSpadeData()
      // 避免热部署时重复加载数据
      this.dataLoaded = true
    }
  }

  pushCard(item: CardItemBean) {
    if (this.selectCards.length < 4) {
      this.selectCards.push(item)
    } else {
      AlertDialog.show({
        message: '已达到扑克牌选取上限'
      })
    }
  }

  //显示扑克牌
  @Builder
  buildOneStack(cards: Array<CardItemBean>) {
    Stack({ alignContent: Alignment.BottomStart }) {
      ForEach(cards, (item: CardItemBean, index) => {
        CardItemComp({ content: item })
          .onClick(() => {
            this.pushCard(item)
          })
          .margin({ left: index * 23 })
      })
    }
    .margin({ top: 5, bottom: 5 })
  }

  @Builder
  buildStackStyle() {
    Column() {
      this.buildOneStack(this.HeartCards)
      this.buildOneStack(this.DiamondCards)
      this.buildOneStack(this.ClubCards)
      this.buildOneStack(this.SpadeCards)
    }
  }

  beginCal() {
    console.log('开始计算')
    if (this.selectCards.length < 4) {
      console.log('没有足够的扑克牌')
      AlertDialog.show({
        message: '请选够四张扑克牌'
      })
      return
    }

    let nums: number[] = []
    for (let i = 0; i < 4; i++) {
      nums.push(this.selectCards[i].id)
    }
    let cal24Model = new Cal24Model()
    console.log('计算的数据:', nums)
    cal24Model.cal(nums)

    myParam.result = cal24Model.getResults()
    console.log('计算结果:', myParam.result)

    router.pushUrl({
      url: 'pages/ResultPage',
      params: {
        result: myParam.result
      }
    })
  }

  build() {
    //构建基本布局
    Scroll() {
      Column() {
        //标题
        Row() {
          Text('请在牌堆中任选四张牌').fontSize(30)
            .fontWeight(FontWeight.Bold)
        }

        // 选中的卡牌
        Row() {
          ForEach(this.selectCards, (item: CardItemBean) => {
            CardItemComp({ content: item })
          })
        }
        .height(120)
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ bottom: 5, top: 5, left: 10, right: 10 })
        .borderWidth(2)
        .borderRadius(10)
        .borderColor(Color.Brown)

        Divider().strokeWidth(5)

        //功能按钮
        Row() {
          Button('回退')
            .fontColor(Color.Black)
            .fontSize(25)
            .backgroundColor(Color.Pink)
            .padding({ top: 10, bottom: 10, left: 20, right: 20 })
            .margin({ right: 10 })
            .borderRadius(10)
            .onClick(() => {
              console.log('清除一张扑克牌')
              this.selectCards.pop()
            })
          Button('清空')
            .fontColor(Color.Black)
            .fontSize(25)
            .backgroundColor(Color.Pink)
            .padding({ top: 10, bottom: 10, left: 20, right: 20 })
            .margin({ right: 10 })
            .borderRadius(10)
            .onClick(() => {
              console.log('清空所有扑克牌')
              this.selectCards = []
            })
          Button('计算')
            .fontColor(Color.Black)
            .fontSize(25)
            .backgroundColor(Color.Pink)
            .padding({ top: 10, bottom: 10, left: 20, right: 20 })
            .borderRadius(10)
            .onClick(() => {
              console.log('计算24点')
              this.beginCal()
              this.selectCards = []
            })
        }
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ top: 10, bottom: 10 })

        Divider().strokeWidth(5)

        // 显示扑克牌
        this.buildStackStyle()

        // 规则说明，跳转到规则页面
        Button('规则说明')
          .fontColor(Color.Black)
          .fontSize(25)
          .backgroundColor(Color.Pink)
          .padding({ top: 10, bottom: 10, left: 20, right: 20 })
          .margin({ top: 10, bottom: 10 })
          .borderRadius(10)
          .onClick(() => {
            console.log('跳转到规则页面')
            router.pushUrl({
              url: 'pages/RulePage'
            })
          })
      }
    }
  }
}