import prompt from '@ohos.promptAction';
import AccountData from '../viewmodel/AccountData';
import CommonConstants from '../common/constants/CommonConstants';
import { PayList, EarnList } from '../viewmodel/AccountList';
export default interface AccountItem {
  icon: Resource;
  iconSelected: Resource;
  accountType: number;
  typeText: string;
}


@CustomDialog
export struct DialogComponent {
  controller?: CustomDialogController;
  @Link isInsert: boolean;
  @Link newAccount: AccountData;
  confirm?: (isInsert: boolean, newAccount: AccountData) => void;
  private scroller: Scroller = new Scroller();
  private inputAmount = '';
  private inputAmount1 = '';
  private date = '';
  @State payList: Array<AccountItem> = PayList;
  @State earnList: Array<AccountItem> = EarnList;
  @State bgColor: string = '';
  @State curIndex: number = 0;
  @State curType: string = '';
  @State Date1: string = "请选择日期";
  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(index === 0 ? $r('app.string.pay_text') : $r('app.string.income_text'))
        .fontSize($r('app.float.font_size_M'))
        .fontColor(this.curIndex === index ? $r('app.color.main_color') : Color.Gray)
    }
    .width($r('app.float.component_size_MP'))
    //.padding({ top: $r('app.float.edge_size_LM'), bottom: $r('app.float.edge_size_S') })
    //.margin({ bottom: $r('app.float.edge_size_S') })
    .border(this.curIndex === index ? {
      width: { bottom: $r('app.float.border_size_M') },
      color: $r('app.color.main_color')
    } : { color: Color.White })
  }

  aboutToAppear() {
    this.inputAmount = this.newAccount.amount.toString();
    this.curIndex = this.newAccount.accountType;
    this.curType = this.newAccount.typeText;
    this.inputAmount1 = this.newAccount.remark;
  }

  selectAccount(item: AccountItem) {
    this.newAccount.accountType = item.accountType;
    this.newAccount.typeText = item.typeText;
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
            Row() {
              ForEach(this.payList.slice(0, 5), (item: AccountItem) => {
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
            Row() {
              ForEach(this.payList.slice(5, 10), (item: AccountItem) => {
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
            Row() {
              ForEach(this.payList.slice(10, 15), (item: AccountItem) => {
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
            Row() {
              ForEach(this.payList.slice(15, 20), (item: AccountItem) => {
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
            Row() {
              ForEach(this.payList.slice(25, 30), (item: AccountItem) => {
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
          }
        }
        .tabBar(this.TabBuilder(0))
        //.margin({ bottom: $r('app.float.edge_size_LP') })

        TabContent() {
          Column() {
            Row() {
              ForEach(this.earnList.slice(0, 4), (item: AccountItem) => {
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
            Row() {
              ForEach(this.earnList.slice(4, 8), (item: AccountItem) => {
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
          }
        }
        .tabBar(this.TabBuilder(1))
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.TABS_HEIGHT)
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
            text: this.newAccount.amount === 0 ? this.inputAmount : this.newAccount.amount.toString()
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
            text: this.newAccount.remark === '' ? this.inputAmount1 : this.newAccount.remark
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

        Row({space:4}) {
          Text('日期:')
            .width('20%')
            .fontSize($r('app.float.font_size_MP'))
            .fontColor(Color.Black)
          Row(){
            Text(`   ${this.Date1}`)
              .margin({left:'5vp'})
            Image($rawfile('half.png'))
              .width('20vp')
          }
          .width('70%')
          .height('40vp')
          .borderWidth({ bottom: CommonConstants.FULL_SIZE })
          .borderColor($r('app.color.border_color'))
          .backgroundColor(Color.White)
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2000-1-1"),
              end: new Date("2100-12-31"),
              onAccept: (value: DatePickerResult | undefined) => {
                if (value && value.month !== undefined && value.day !== undefined) {
                  this.Date1 = `${value.year}-${value.month + 1}-${value.day}`;
                  this.date = `${value.year}-${value.month + 1}-${value.day}`;
                } else {
                  console.error("DatePickerResult is undefined or invalid");
                }
              }
            });
          });

        }

      }
      .width(CommonConstants.FULL_WIDTH)
      .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })

      Column() {

      }

      Column() {
        Button() {
          Text($r('app.string.confirm_text'))
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.White)
        }
        .backgroundColor($r('app.color.themeColor'))
        .width(CommonConstants.FULL_WIDTH)
        .height($r('app.float.component_size_M'))
        .onClick(() => {
          if (this.newAccount.typeText === '' || this.curIndex !== this.newAccount.accountType) {
            prompt.showToast({ message: CommonConstants.TOAST_TEXT_1, bottom: CommonConstants.PROMPT_BOTTOM });
          } else {
            let regex: RegExp = new RegExp('[1-9][0-9]*');
            let matchValue: Array<string> | null = this.inputAmount.match(regex);
            if (matchValue !== null && matchValue[0] === this.inputAmount) {
              if(this.date !== ''){
                this.newAccount.amount = Number(this.inputAmount);
                this.newAccount.remark = this.inputAmount1;
                this.newAccount.Date = this.date;
                this.confirm && this.confirm(this.isInsert, this.newAccount);
                this.controller?.close();
              }else{
                prompt.showToast({ message: CommonConstants.TOAST_TEXT_3, bottom: CommonConstants.PROMPT_BOTTOM });
              }
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
  }
}