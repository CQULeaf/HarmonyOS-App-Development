import prompt from '@ohos.promptAction';
import MoneyData from '../viewmodel/MoneyData';
import CommonConstants from '../common/constants/CommonConstants';
import { PayList, EarnList,YusuanList } from '../viewmodel/MoneyList';
export default interface MoneyItem {
  icon: Resource;
  iconSelected: Resource;
  accountType: number;
  typeText: string;
}


@CustomDialog
export struct DialogMoney {
  controller?: CustomDialogController;
  @Link isInsert: boolean;
  @Link newMoney: MoneyData;
  confirm?: (isInsert: boolean, newMoney: MoneyData) => void;
  private inputAmount = '';
  private inputAmount1 = '';
  @State payList: Array<MoneyItem> = PayList;
  @State earnList: Array<MoneyItem> = EarnList;
  @State YusuanList: Array<MoneyItem> = YusuanList;
  @State bgColor: string = '';
  @State curIndex: number = 0;
  @State curType: string = '';
  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(
          index === 0 ? `债务` :
            index === 1 ? `资产` :
          $r('app.string.yusuan')
      )
        .fontSize($r('app.float.font_size_M'))
        .fontColor(this.curIndex === index ? $r('app.color.main_color') : Color.Gray)
    }
    .width($r('app.float.component_size_MP'))
    .padding({ top: $r('app.float.edge_size_LM'), bottom: $r('app.float.edge_size_S') })
    .margin({ bottom: $r('app.float.edge_size_S') })
    .border(this.curIndex === index ? {
                                        width: { bottom: $r('app.float.border_size_M') },
                                        color: $r('app.color.main_color')
                                      } : { color: Color.White })
  }


  aboutToAppear() {
    this.inputAmount = this.newMoney.amount.toString();
    this.curIndex = this.newMoney.accountType;
    this.curType = this.newMoney.typeText;
  }

  selectAccount(item: MoneyItem) {
    this.newMoney.accountType = item.accountType;
    this.newMoney.typeText = item.typeText;
    this.curType = item.typeText;
  }

  build() {
    Column() {
      Image($rawfile('half.png'))
        .width($r('app.float.component_size_L'))
        .height($r('app.float.component_size_S'))
        .onClick(() => {
          this.controller?.close();
        })

      Tabs({ barPosition: BarPosition.Start, index: this.curIndex }) {
        TabContent() {
          Column() {
            Row(){
              Text('常用')
                .fontSize($r('app.float.font_size_S'))
            }
            Row(){
              ForEach(this.payList.slice(0, 5), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }
            Row(){
              Text('信用卡')
                .fontSize($r('app.float.font_size_S'))
            }.margin({top:'12vp'})
            Row(){
              ForEach(this.payList.slice(5, 10), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }
            Row(){
              ForEach(this.payList.slice(10, 15), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }.margin({top:'12vp'})
            Row(){
              ForEach(this.payList.slice(15, 20), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }.margin({top:'12vp'})
          }.alignItems(HorizontalAlign.Start)
        }
        .tabBar(this.TabBuilder(0))
        .margin({ bottom: $r('app.float.edge_size_LP') })

        TabContent() {
          Column() {
            Row(){
              Text('常用')
                .fontSize($r('app.float.font_size_S'))
            }
            Row(){
              ForEach(this.earnList.slice(0, 4), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }
            Row(){
              Text('储蓄卡')
                .fontSize($r('app.float.font_size_S'))
                .margin({ top: '12vp' })
            }
            Row(){
              ForEach(this.earnList.slice(4, 9), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }
            Row(){
              ForEach(this.earnList.slice(9, 14), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }.margin({top:'12vp'})
            Row(){
              ForEach(this.earnList.slice(14, 19), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }.margin({top:'12vp'})

            Row(){
              Text('投资/债权')
                .fontSize($r('app.float.font_size_S'))
                .margin({ top: '12vp' })
            }
            Row(){
              ForEach(this.earnList.slice(19, 22), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }
          }.alignItems(HorizontalAlign.Start)
        }
        .tabBar(this.TabBuilder(1))
        .margin({ bottom: $r('app.float.edge_size_LP') })

        TabContent() {
          Column() {
            Row(){
              ForEach(this.YusuanList.slice(0, 2), (item: MoneyItem) => {
                Column() {
                  Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                    .width($r('app.float.image_size'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                  Text(item.typeText)
                    .fontSize('10vp')
                    .fontColor( $r('app.color.main_color'))
                }
                .width('66vp')
                .height('66vp')
                .aspectRatio(CommonConstants.FULL_SIZE)
                .padding({ top:'4vp' })
                .margin({ left: $r('app.float.edge_size_M') })
                .align(Alignment.TopStart)
                .backgroundColor( $r('app.color.background_color'))
                .borderWidth('2')
                .borderColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
                .borderRadius($r('app.float.radius_size_S'))
                .onClick(() => {
                  this.selectAccount(item);
                })
              })
            }
          }
        }
        .tabBar(this.TabBuilder(2))
        .margin({ bottom: $r('app.float.edge_size_LP') })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.TABS_HEIGHT)
      .vertical(false)
      .barMode(BarMode.Fixed)
      .onChange((index) => {
        this.curIndex = index;
      })

      Column() {
        Row({space:4}){
          Text('金额:')
            .width('20%')
            .fontSize($r('app.float.font_size_MP'))
            .fontColor(Color.Black)

          TextInput({
            placeholder: '请输入金额',
            text: this.newMoney.amount === 0 ? this.inputAmount : this.newMoney.amount.toString()
          })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .height('40vp')
            .width('70%')
            .borderWidth({ bottom: CommonConstants.FULL_SIZE })
            .borderColor($r('app.color.border_color'))
            .backgroundColor(Color.White)
            .type(InputType.Number)
            .onChange((value: string) => {
              this.inputAmount = value;
            })
        }

        Row({space:4}){
          Text('备注:')
            .width('20%')
            .fontSize($r('app.float.font_size_MP'))
            .fontColor(Color.Black)

          TextInput({
            placeholder: '请输入备注',
            text: this.newMoney.remark === '' ? this.inputAmount1 : this.newMoney.remark
          })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .height('40vp')
            .width('70%')
            .borderWidth({ bottom: CommonConstants.FULL_SIZE })
            .borderColor($r('app.color.border_color'))
            .backgroundColor(Color.White)
            .type(InputType.Normal)
            .onChange((value: string) => {
              this.inputAmount1 = value;
            })
        }
      }
      .width(CommonConstants.FULL_WIDTH)
      .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })

      Column() {
        Button() {
          Text($r('app.string.confirm_text'))
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.White)
        }
        .backgroundColor(Color.Orange)
        .width(CommonConstants.FULL_WIDTH)
        .height($r('app.float.component_size_M'))
        .onClick(() => {
          if (this.newMoney.typeText === '' || this.curIndex !== this.newMoney.accountType) {
            prompt.showToast({ message: CommonConstants.TOAST_TEXT_1, bottom: CommonConstants.PROMPT_BOTTOM });
          } else {
            let regex: RegExp = new RegExp('[1-9][0-9]*');
            let matchValue: Array<string> | null = this.inputAmount.match(regex);
            if (matchValue !== null && matchValue[0] === this.inputAmount) {
              this.newMoney.amount = Number(this.inputAmount);
              this.newMoney.remark = this.inputAmount1;
              this.confirm && this.confirm(this.isInsert, this.newMoney);
              this.controller?.close();
            } else {
              prompt.showToast({ message: CommonConstants.TOAST_TEXT_2, bottom: CommonConstants.PROMPT_BOTTOM });
            }
          }
        })
      }
      .layoutWeight(CommonConstants.FULL_SIZE)
      .padding({
        bottom: $r('app.float.font_size_L'),
        left: $r('app.float.font_size_L'),
        right: $r('app.float.font_size_L')
      })
      .justifyContent(FlexAlign.End)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.DIALOG_HEIGHT)
    .borderRadius({ topLeft: $r('app.float.font_size_L'), topRight: $r('app.float.font_size_L') })
    .backgroundColor(Color.White)
    .align(Alignment.BottomEnd)
  }
}