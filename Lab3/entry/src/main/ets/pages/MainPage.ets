import Comp_me from '../view/Comp_me';
import Comp_add from '../view/Comp_add'
import Comp_account from '../view/Comp_account'
import Comp_graph from '../view/Comp_graph';

@Entry
@Component
struct TabContentExample {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#3fa9d2'
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()

  @Builder TabBuilder0(index: number) {
    Column() {
      Image(this.currentIndex === index ? $rawfile('account_select.png') : $rawfile('account.png'))
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
        .objectFit(ImageFit.Contain)
      Text(`流水`)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.width('100%')
  }
  @Builder TabBuilder1(index: number) {
    Column() {
      Image(this.currentIndex === index ? $rawfile('add_select.png') : $rawfile('add.png'))
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
        .objectFit(ImageFit.Contain)
      Text(`记账`)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.width('100%')
  }
  @Builder TabBuilder2(index: number) {
    Column() {
      Image(this.currentIndex === index ? $rawfile('graph_select.png') : $rawfile('graph.png'))
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
        .objectFit(ImageFit.Contain)
      Text(`报表`)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.width('100%')
  }
  @Builder TabBuilder3(index: number) {
    Column() {
      Image(this.currentIndex === index ? $rawfile('me_select.png') : $rawfile('me.png'))
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
        .objectFit(ImageFit.Contain)
      Text(`我的`)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.width('100%')
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        TabContent() {
          Comp_account()
        }.tabBar(this.TabBuilder0(0))

        TabContent() {
          Comp_add()
        }.tabBar(this.TabBuilder1(1))

        TabContent() {
          Comp_graph()
        }.tabBar(this.TabBuilder2(2))

        TabContent() {
          Comp_me()
        }.tabBar(this.TabBuilder3(3))
      }
      .vertical(false)
      .barHeight(56)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }.width('100%')
  }
}