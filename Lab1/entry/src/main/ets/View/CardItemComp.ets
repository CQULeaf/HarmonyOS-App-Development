import CommonConstants  from '../Common/CommonConstants';
import { CardItemBean } from '../ViewModel/CardItemBean'

@Component
export default struct CardItemComp {
  private content:CardItemBean = new CardItemBean(1, $r('app.media.Spade13'))
  @State isSelected:boolean = false
  @Builder labelIcon(icon:Resource) {
    Image(icon)
      .objectFit(ImageFit.Contain)
      .width(80)
      .height(100)
      .margin(2)
  }
  build() {
    Column(){
      this.labelIcon(this.content.pic)
    }
    .borderRadius(CommonConstants.BORDER_RADIUS)
    .margin({left:3,right:3})
  }
}
