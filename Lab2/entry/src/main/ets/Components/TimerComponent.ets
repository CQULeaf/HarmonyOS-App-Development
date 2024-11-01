@Component
struct TimerComponent {
  textTimerController: TextTimerController = new TextTimerController()
  @Link format: string
  @Link useTime: number

  build() {
    Row() {
      TextTimer({ isCountDown: false, count: 0, controller: this.textTimerController })
        .format(this.format)
        .fontColor(Color.Black)
        .fontSize(50)
        .onTimer((utc: number, elapsedTime: number) => {
          console.info('经过的时间：' + elapsedTime + 'ms')
          this.useTime = elapsedTime
        })
        .backgroundColor(Color.White)
    }
    .borderWidth(5).borderRadius(10).borderColor(Color.Pink)
    .width('100%')
    .height('10%')
    .margin({ top: 5 })
    .alignRules({
      top: { anchor: 'imgGrid_layout', align: VerticalAlign.Bottom },
      middle: { anchor: '__container__', align: HorizontalAlign.Center }
    })
    .id('timeCounter')
    .justifyContent(FlexAlign.Center)
  }
}

export { TimerComponent }