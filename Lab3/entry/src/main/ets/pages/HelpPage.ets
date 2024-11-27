@Entry
@Component
struct HelpPage {
  build() {
    Column(){
      Column(){
        Column() {
          Text("使用指南")
            .height($r('app.float.component_size_SP'))
            .fontSize(35)
            .height('15%')
        }.alignItems(HorizontalAlign.Center)
        Column({space: 5}) {
          Column() {
            Text("    “橙子记账”是一款高效易用的记账软件，旨在帮助用户更好地管理自己的财务。本软件功能如下：")
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('80%')
              .height('10%')
            Text("简单易用：界面简洁，操作便捷，无需复杂的步骤，即可轻松上手。")
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('80%')
              .height('10%')
            Text("快速记账：支持多种账目类型，如收入、支出、转账等，方便用户快速记录各种账目。")
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('80%')
              .height('10%')
            Text("数据分析：通过对用户账目的分析，软件能够生成财务图表，帮助用户更好地了解自己的财务状况。")
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('80%')
              .height('10%')
            Text("数据安全：采用鸿蒙基础数据库，保证用户数据的安全性。")
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('80%')
              .height('10%')
            Text("资产管家：用户可以在这里管理自己的所有资产，软件会分析存储用户的资产状况。")
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('80%')
              .height('10%')
            Text("税务计算：用户可以在这里计算自己的应纳税额，软件会计算出用户对应的应税额度和应纳税额。")
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .width('80%')
              .height('10%')
          }

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