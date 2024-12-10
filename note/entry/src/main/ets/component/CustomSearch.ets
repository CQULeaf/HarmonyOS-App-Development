@Component
export default struct CustomSearch{
  @Link keywords:string

  build(){
    Row(){
      Row(){
        Image($r('app.media.search'))
          .width(16)
          .margin({left:10})
        TextInput({
          placeholder:'快速搜索关键词',
          text:this.keywords
        })
          .onChange((value:string)=>{
            this.keywords = value
          })
        .backgroundColor('#FFFFFF')
        if (this.keywords){
          Image($r('app.media.cancel'))
            .width(16)
            .margin({right:10})
            .onClick(()=>{
            })
        }
      }
      .padding({right:52})
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
    }
    .padding({left:20,right:20})
    .margin({top:12})
  }
}

@Preview
@Component
struct CustomSearchPreview{

  @State keywords :string = '1'

  build(){
    CustomSearch({keywords:$keywords})
  }
}