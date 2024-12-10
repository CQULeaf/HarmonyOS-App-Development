interface TimeFormat {
  range: string
  formatDate: string
  formatTime: string
}

function getFormatTime(timeStamp: number): TimeFormat {
  const today = new Date();
  const date = new Date(timeStamp);

  // 计算日期差值
  const diffTime = today.getTime() - date.getTime();
  // 向下取整
  const diffDays = Math.floor(diffTime / (24 * 60 * 60 * 1000));

  let range: string = ''

  if (diffDays === 0) {
    range = '今天'
  } else if (diffDays === 1) {
    range = '昨天'
  } else if (diffDays === 2) {
    range = '前天'
  } else {
    range = '三天前'
  }

  const month: string = (date.getMonth() + 1).toString().padStart(2, '0')
  const day: string = date.getDate().toString().padStart(2, '0')
  const hours: string = date.getHours().toString().padStart(2, '0')
  const minute: string = date.getMinutes().toString().padStart(2, '0')

  const formatDate: string = `${month}月${day}日`
  const formatTime: string = `${hours}:${minute}`

  return { range, formatDate, formatTime }

}

@Component
export default struct MemoItem {

  build() {
    Row() {
      Stack() {
        Row() {
          // 左侧
          Column() {

          }
          .width(26)
          .height(90)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#F5F5ED', 0.5], ['#EEE4DB', 1]]
          })
          .borderRadius({ topLeft: 4, bottomLeft: 4 })

          // 纵向分割线
          Divider()
            .vertical(true)
            .height(90)
            .color('#EEE4DB')

          // 右侧
          Column() {
            // Row({ space: 10 }) {
            //   Text(getFormatTime(this.memo.updateTime).range)
            //     .fontSize(12).fontColor('#BFA290')
            //   Text(getFormatTime(this.memo.updateTime).formatDate)
            //     .fontSize(12).fontColor('#BFA290')
            //   Text(getFormatTime(this.memo.updateTime).formatTime)
            //     .fontSize(12).fontColor('#BFA290')
            // }
            // .margin({ left: 10 })
            // .height(25)

            Divider()
              .color('#EEE4DB')

            // Column() {
            //   Text(this.memo.content)
            //     .fontColor('#604637')
            //     .maxLines(2)
            //     .margin({ right: 10 })
            // }
            // .margin({ left: 10 })
            // .justifyContent(FlexAlign.Center)
            // .height(64)
          }
          .alignItems(HorizontalAlign.Start)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#FBFDF7', 0.5], ['#F1EDE2', 1]]
          })
          .height(90)
          .borderRadius({ topRight: 4, bottomRight: 4 })
          .margin({ right: 27 })

        }
        .shadow({
          radius:10,
          color:"rgba(0,0,0,0.1)",
          offsetY:4
        })

        Image($r('app.media.clip'))
          .height(30)
          .offset({x:-33})

      }
      .width('100%')
      .alignContent(Alignment.Start)
      .onClick(()=>{
      })

    }
    .margin({top:12})
    .padding({left:20,right:20})
  }
}
