import CommonConstants from '../common/constants/CommonConstants';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ShuiwuPage {
  @State incometype: string = "工资(月薪)";
  @State money: number = 0;

  @State jiao_shui: number = 0;
  @State tui_shui: number = 0;

  @State shou_ru: string = '';
  @State gong_ji: string = '';
  @State zhuan_xiang: string = '';
  @State selecttype: number = 0;

  @State selectyeartype: number = 0;
  @State year: string = "小于一个月";
  private yeartype: string[] = ['小于1个月','1个月到1年','大于1年'];
  private type: string[] = ['工资(月薪)', '年终奖(全年)', '劳务报酬', '稿酬所得', '偶然所得','利息、股息所得'];
  private select: number = 0;
  private select1: number = 1;
  caculate(): void {
    if(this.selecttype === 0){
      this.jiao_shui = 0;
      this.money = Number(this.shou_ru)- 5000 - Number(this.gong_ji) - Number(this.zhuan_xiang);
      if(this.money <= 0 ){
        this.money = 0;
      }else if(this.money > 0 && this.money <= 3000){
        this.jiao_shui = this.money * 0.03;
      }else if(this.money > 3000 && this.money <= 12000){
        this.jiao_shui = this.money * 0.10 - 210;
      }else if(this.money > 12000 && this.money <= 25000){
        this.jiao_shui = this.money * 0.20 - 1410;
      }else if(this.money > 25000 && this.money <= 35000){
        this.jiao_shui = this.money * 0.25 - 2660;
      }else if(this.money > 35000 && this.money <= 55000){
        this.jiao_shui = this.money * 0.30 - 4410;
      }else if(this.money > 55000 && this.money <= 80000){
        this.jiao_shui = this.money * 0.35 - 7160;
      }else if(this.money > 80000){
        this.jiao_shui = this.money * 0.45 - 15160;
      }
    }
    else if(this.selecttype === 1){
      this.jiao_shui = 0;
      this.money = Number(this.shou_ru);
      if(this.money > 0 && this.money <= 36000){
        this.jiao_shui = this.money * 0.03;
      }else if(this.money > 36000 && this.money <= 144000){
        this.jiao_shui = this.money * 0.10 - 2520;
      }else if(this.money > 144000 && this.money <= 300000){
        this.jiao_shui = this.money * 0.20 - 16920;
      }else if(this.money > 300000 && this.money <= 420000){
        this.jiao_shui = this.money * 0.25 - 31920;
      }else if(this.money > 420000 && this.money <= 660000){
        this.jiao_shui = this.money * 0.30 - 52920;
      }else if(this.money > 660000 && this.money <= 960000){
        this.jiao_shui = this.money * 0.35 - 85920;
      }else if(this.money > 960000){
        this.jiao_shui = this.money * 0.45 - 181920;
      }
    }
    else if(this.selecttype === 2){
      this.jiao_shui = 0;
      this.money = Number(this.shou_ru);
      if(this.money <= 4000){
        this.money = this.money - 800;
        if(this.money > 0 && this.money <=20000 ){
          this.jiao_shui = this.money * 0.2
        }else if(this.money > 20000 && this.money <=50000 ){
          this.jiao_shui = this.money * 0.3
        }else if(this.money > 50000){
          this.jiao_shui = this.money * 0.4
        }
      }else if(this.money > 4000){
        this.money = this.money * 0.8;
        if(this.money > 0 && this.money <=20000 ){
          this.jiao_shui = this.money * 0.2
        }else if(this.money > 20000 && this.money <=50000 ){
          this.jiao_shui = this.money * 0.3 - 2000
        }else if(this.money > 50000){
          this.jiao_shui = this.money * 0.4 - 7000
        }
      }
    }
    else if(this.selecttype === 3){
      this.jiao_shui = 0;
      this.money = Number(this.shou_ru);
      if(this.money <= 4000) {
        this.money = (this.money - 800) * 0.2 * 0.7;
      }else{
        this.money = (this.money) * 0.8 * 0.2 * 0.7;
      }
      if(this.money > 0 && this.money <= 36000){
        this.jiao_shui = this.money * 0.03;
      }else if(this.money > 36000 && this.money <= 144000){
        this.jiao_shui = this.money * 0.10 - 2520;
      }else if(this.money > 144000 && this.money <= 300000){
        this.jiao_shui = this.money * 0.20 - 16920;
      }else if(this.money > 300000 && this.money <= 420000){
        this.jiao_shui = this.money * 0.25 - 31920;
      }else if(this.money > 420000 && this.money <= 660000){
        this.jiao_shui = this.money * 0.30 - 52920;
      }else if(this.money > 660000 && this.money <= 960000){
        this.jiao_shui = this.money * 0.35 - 85920;
      }else if(this.money > 960000){
        this.jiao_shui = this.money * 0.45 - 181920;
      }
    }
    else if(this.selecttype === 4){
      this.jiao_shui = 0;
      this.money = Number(this.shou_ru);
      if(this.money <= 10000){
        this.money =0;
      }else{
        this.jiao_shui = this.money * 0.2;
      }
    }
    else if(this.selecttype === 5) {
      this.jiao_shui = 0;
      this.money = Number(this.shou_ru);
      if(this.selectyeartype === 0){

        this.jiao_shui = this.money * 0.2;
      }else if(this.selectyeartype === 1) {
        this.money = this.money * 0.5;
        this.jiao_shui = this.money * 0.2;
      }else if(this.selectyeartype === 2) {
        this.money = this.money * 0;
        this.jiao_shui = this.money * 0.2;
      }
    }
  }
  build() {
    Column() {

      Image($rawfile('111.png'))
        .width(200)

      Text('个税计算器').fontSize(20).margin({ top: 10, bottom: 10 })

      Column({space:5}){
        Row(){
          Text('收入类型:')
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.Black)
            .margin({right:'20vp'})
          Row(){
            Text(`${this.incometype}`)
              .margin({left:'5vp'})
            Image($rawfile('half.png'))
              .width('20vp')
          }.width('35%')
          .height('35vp')
          .borderColor(Color.Black)
          .borderWidth(1)
          .onClick(() => {
            TextPickerDialog.show({
              range: this.type,
              selected: this.select,
              onAccept: (value: TextPickerResult) => {
                if (typeof  value.index == "number"){
                  this.incometype = this.type[value.index];
                  this.selecttype = value.index;
                }
              }
            })
          })
        }
        Row(){
          Text('收入数额:')
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.Black)
            .margin({right:'20vp'})
          TextInput({
            placeholder: $r('app.string.input_text'),
          })
            .width('35%')
            .height('35vp')
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .backgroundColor(Color.White)
            .borderWidth(1)
            .borderColor(Color.Black)
            .type(InputType.Number)
            .onChange((value: string) => {
              this.shou_ru = value;
            })
        }
        if (this.selecttype === 0){
          Row(){
            Text('社保、公积金:')
              .fontSize($r('app.float.font_size_M'))
              .fontColor(Color.Black)
              .margin({right:'20vp'})
            TextInput({
              placeholder: $r('app.string.input_text'),
            })
              .width('35%')
              .height('35vp')
              .borderRadius(CommonConstants.MINIMUM_SIZE)
              .backgroundColor(Color.White)
              .borderWidth(1)
              .borderColor(Color.Black)
              .type(InputType.Number)
              .onChange((value: string) => {
                this.gong_ji = value;
              })
          }

          Row(){
            Text('专项附加扣除:')
              .fontSize($r('app.float.font_size_M'))
              .fontColor(Color.Black)
              .margin({right:'20vp'})
            TextInput({
              placeholder: $r('app.string.input_text'),
            })
              .width('35%')
              .height('35vp')
              .borderRadius(CommonConstants.MINIMUM_SIZE)
              .backgroundColor(Color.White)
              .borderWidth(1)
              .borderColor(Color.Black)
              .type(InputType.Number)
              .onChange((value: string) => {
                this.zhuan_xiang = value;
              })
          }
        }

        if (this.selecttype === 5){
          Row(){
            Text('持股时间:')
              .fontSize($r('app.float.font_size_M'))
              .fontColor(Color.Black)
              .margin({right:'20vp'})
            Row(){
              Text(`${this.year}`)
                .margin({left:'5vp'})
              Image($rawfile('half.png'))
                .width('20vp')
            }.width('35%')
            .height('35vp')
            .borderColor(Color.Black)
            .borderWidth(1)
            .onClick(() => {
              TextPickerDialog.show({
                range: this.yeartype,
                selected: this.select1,
                onAccept: (value: TextPickerResult) => {
                  if (typeof value.index == "number") {
                    this.year = this.yeartype[value.index];
                    this.selectyeartype = value.index;
                  }
                }
              })
            })
          }
        }

        Row(){
          Text('计税税额:')
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.Black)
            .margin({right:'20vp'})
          Text(`${(this.money).toFixed(1)}`)
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.Black)
            .width('35%')
            .height('35vp')
        }

        Row(){
          Text('应缴税额:')
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.Black)
            .margin({right:'20vp'})
          Text(`${(this.jiao_shui).toFixed(1)}`)
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.Black)
            .width('35%')
            .height('35vp')
        }
      }.alignItems(HorizontalAlign.End)

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('退出')
          .width("40%")
          .onClick(() => {
            router.back()
          }).backgroundColor($r('app.color.main_color')).fontColor(Color.White)
        Button('计算')
          .width("40%")
          .onClick(() => {
            this.caculate();
          }).backgroundColor($r('app.color.main_color')).fontColor(Color.White)
      }.margin({ bottom: 10 })
      Image($r('app.media.swdb'))
        .width(250)
        // .height(200)
    }.backgroundColor($r('app.color.themeColor'))
    .width('100%')
    .height('100%')
  }
}