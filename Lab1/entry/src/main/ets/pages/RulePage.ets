import { router } from '@kit.ArkUI'

const rules = [
  '1. 请在牌堆中任选四张牌，不能多选也不能少选',
  '2. 扑克牌A-K分别代表数字1-13',
  '3. 通过加减乘除与括号运算，使这四张牌的数字计算结果为24',
  '4. 请注意每张牌只能使用一次',
  '5. 巧妙运用运算符的优先级，它会极大增加表达式的数量'
];

@Entry
@Component
struct RulePage {
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
        Text('游戏规则')
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

      // 游戏规则
      Column() {
        ForEach(rules, (rule: string) => {
          Text(rule)
            .fontSize(20)
            .fontSize(25)
            .fontColor('#fff80000')
            .margin({ bottom: 30, top: 20 })
        })
      }.width('90%').height('50%')
    }
  }
}
