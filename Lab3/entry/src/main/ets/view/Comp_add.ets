import CommonConstants from '../common/constants/CommonConstants';
import { AccountItem, PayList, EarnList } from '../viewmodel/AccountList';
import { recordAdd } from '../api/record';
import { router } from '@kit.ArkUI';
import { PermissionManager } from '../utils/PermissionMananger'
import { Permissions } from '@kit.AbilityKit'
import SpeechRecognizerManager from '../utils/SpeechRecognizerManager'


interface ResponseRecordAdd {
  id: number;
  username: string;
  category: string;
  amount: number;
  description: string;
  date: Date;
  type: number;
  createdAt: string;
}

@Component
export default struct Comp_add {
  private amount: number = 0;
  private description: string = '';
  private type: number = 0;
  private category: string = '';
  @StorageProp('CurrentUsername') username: string = '';

  private date: string = '';
  @State payList: Array<AccountItem> = PayList;
  @State earnList: Array<AccountItem> = EarnList;
  @State bgColor: string = '';
  @State Date1: string = "请选择日期";
  @State curIndex: number = 0;
  @State curType: string = '';

  async recordAdd() {
    try {
      const res = await recordAdd<ResponseRecordAdd>(this.username, this.category, this.amount, this.description, this.date, this.type)
      console.log('添加成功:', res)
    } catch (error) {
      console.error('添加请求错误', error)
      AlertDialog.show({
        message: '添加失败，请检查网络连接或稍后重试'
      })
    }
  }

  SelectTab(index: number) {
    this.curIndex = index;
  }

  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(index === 0 ? $r('app.string.pay_text') : $r('app.string.income_text'))
        .fontSize($r('app.float.font_size_M'))
        .fontColor(this.curIndex === index ? $r('app.color.main_color') : Color.Gray)
    }
    .width($r('app.float.component_size_MP'))
    .border(this.curIndex === index ? {
      width: { bottom: $r('app.float.border_size_M') },
      color: $r('app.color.main_color')
    } : { color: Color.White })
    .onClick(() => {
      this.SelectTab(index);
    })
  }

  selectAccount(item: AccountItem) {
    this.type = item.accountType;
    this.category = item.typeText;
    this.curType = item.typeText;
  }

  @State text: string = '语音识别测试';
  // 1 申请权限
  fn1 = async () => {
    // 准备好需要申请的权限 麦克风权限
    const permissions: Permissions[] = ["ohos.permission.MICROPHONE"]
    // 检查是否拥有权限
    const isPermission = await PermissionManager.checkPermission(permissions)
    console.log("是否有权限", isPermission)
    if (!isPermission) {
      //   如果没权限，就主动申请
      PermissionManager.requestPermission(permissions)
    }
  }
  // 2 实时语音识别
  fn2 = () => {
    console.log("实时语音识别")
    SpeechRecognizerManager.init(res => {
      console.log("实时语音识别", JSON.stringify(res))
      this.text = res.result
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start, index: this.curIndex }) {
        TabContent() {
          Column() {
            Row() {
              ForEach(this.payList.slice(0, 4), (item: AccountItem) => {
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
              ForEach(this.payList.slice(4, 8), (item: AccountItem) => {
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
              ForEach(this.payList.slice(8, 12), (item: AccountItem) => {
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
              ForEach(this.payList.slice(12, 16), (item: AccountItem) => {
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
        this.type = index;
      })

      Column() {
        Row({space:4}){
          Text('金额:')
            .width('20%')
            .fontSize($r('app.float.font_size_MP'))
            .fontColor(Color.Black)

          TextInput({
            placeholder: '请输入金额'
          })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .height('40vp')
            .width('70%')
            .borderWidth({ bottom: CommonConstants.FULL_SIZE })
            .borderColor($r('app.color.border_color'))
            .backgroundColor(Color.White)
            .type(InputType.Number)
            .onChange((value: string) => {
              this.amount = Number(value);
            })
        }

        Row({space:4}){
          Text('备注:')
            .width('20%')
            .fontSize($r('app.float.font_size_MP'))
            .fontColor(Color.Black)

          TextInput({
            placeholder: '请输入备注',
          })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .height('40vp')
            .width('70%')
            .borderWidth({ bottom: CommonConstants.FULL_SIZE })
            .borderColor($r('app.color.border_color'))
            .backgroundColor(Color.White)
            .type(InputType.Normal)
            .onChange((value: string) => {
              this.description = value;
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
        Button() {
          Text($r('app.string.confirm_text'))
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.White)
        }
        .backgroundColor('#739353')
        .width(CommonConstants.FULL_WIDTH)
        .height($r('app.float.component_size_M'))
        .onClick(() => {
          this.recordAdd();
          router.pushUrl({ url: 'pages/MainPage' })
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