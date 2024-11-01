export class CardItemBean {
  public id: number = 0
  public pic: Resource

  constructor(id : number, pic : Resource) {
    this.id = id
    this.pic = pic
  }
}