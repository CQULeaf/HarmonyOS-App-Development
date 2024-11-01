@Component
struct DifficultySelector {
  @Link isHard: boolean

  build() {
    Row() {
      Text('难度选择：简单或者困难').fontSize(25).fontColor(Color.Black)
        .margin({ left: 10 }).fontWeight(FontWeight.Bold)
      Flex({ alignItems: ItemAlign.Start }) {
        Toggle({ type: ToggleType.Switch, isOn: this.isHard })
          .selectedColor('#FF4040')
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.isHard = isOn
          })
          .size({ width: 60, height: 40 })
          .margin({ left: 5 })
      }.width('100%').margin({ left: 12 })
    }
    .id('switch')
    .width('97%')
    .height(60)
    .margin({ top: 10 })
    .backgroundColor(Color.White)
    .alignRules({
      top: { anchor: 'buttonGroup', align: VerticalAlign.Bottom },
      middle: { anchor: '__container__', align: HorizontalAlign.Center }
    })
    .justifyContent(FlexAlign.Start)
    .borderColor(Color.White)
    .borderWidth(5)
    .borderRadius(10)
  }
}

export { DifficultySelector }