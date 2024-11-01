import { CardItemBean } from '../ViewModel/CardItemBean'

export class CardDataModel {
  dataHeart:CardItemBean[] = [] //红心
  dataClub:CardItemBean[] = [] //梅花
  dataDiamond:CardItemBean[] = [] //方块
  dataSpade:CardItemBean[] = [] //黑桃

  //装载红心数据
  getHeartData():Array<CardItemBean>{
    for (let i = 1; i <= 13; i++) {
      this.dataHeart.push(new CardItemBean(i, $r(`app.media.Heart${i}`)))
    }
    return this.dataHeart
  }

  //装载梅花数据
  getClubData():Array<CardItemBean>{
    for (let i = 1; i <= 13; i++) {
      this.dataClub.push(new CardItemBean(i, $r(`app.media.Club${i}`)))
    }
    return this.dataClub
  }

  //装载方块数据
  getDiamondData():Array<CardItemBean>{
    for (let i = 1; i <= 13; i++) {
      this.dataDiamond.push(new CardItemBean(i, $r(`app.media.Diamond${i}`)))
    }
    return this.dataDiamond
  }

  //装载黑桃数据
  getSpadeData():Array<CardItemBean>{
    for (let i = 1; i <= 13; i++) {
      this.dataSpade.push(new CardItemBean(i, $r(`app.media.Spade${i}`)))
    }
    return this.dataSpade
  }
}

//导出类的示例，就不需要再实例化了
export default new CardDataModel()