import AccountTable from '../common/database/tables/AccountTable';
import AccountData from '../viewmodel/AccountData';
import CommonConstants from '../common/constants/CommonConstants';
import { DialogComponent } from '../view/DialogComponent';
import { ImageList } from '../viewmodel/AccountList';
import Logger from '../common/utils/Logger';

@Component
export default struct Comp_account {

  @State accounts: Array<AccountData> = [];
  @State searchText: string = '';
  @State searchcheck: number= 3;
  @State isInsert: boolean = false;
  @State newAccount: AccountData = { id: 0, accountType: 0, typeText: '', amount: 0 ,Date:'',remark:''};
  @State index: number = -1;
  @State totalint: number = 0;
  @State totalout: number = 0;
  private AccountTable = new AccountTable(() => {});
  private deleteList: Array<AccountData> = [];

  controller: TextClockController = new TextClockController();
  searchController: SearchController = new SearchController();
  private scrollerForList: Scroller = new Scroller()
  dialogController: CustomDialogController = new CustomDialogController({
    builder: DialogComponent({
      isInsert: $isInsert,
      newAccount: $newAccount,
      confirm: (isInsert: boolean, newAccount: AccountData) => this.accept(isInsert, newAccount)
    }),
    customStyle: true,
    alignment: DialogAlignment.Bottom,
  });
  accept(isInsert: boolean, newAccount: AccountData): void {
    if (isInsert) {
      Logger.info(`${CommonConstants.INDEX_TAG}`, `The account inserted is:  ${JSON.stringify(newAccount)}`);
      this.AccountTable.insertData(newAccount, (id: number) => {
        newAccount.id =id;
        this.accounts.push(newAccount);
      });
    } else {
      this.AccountTable.updateData(newAccount, () => {
      });
      let list = this.accounts;
      this.accounts = [];
      list[this.index] = newAccount;
      this.accounts = list;
      this.index = -1;


    }
  }
  aboutToAppear() {
    this.AccountTable.getRdbStore(() => {
      this.AccountTable.query(0, (result: AccountData[]) => {
        this.accounts = result;
      }, true);
    });
  }
  selectListItem(item: AccountData) {
    this.isInsert = false;
    this.index = this.accounts.indexOf(item);
    this.newAccount = {
      id: item.id,
      accountType: item.accountType,
      typeText: item.typeText,
      amount: item.amount,
      Date:item.Date,
      remark:item.remark,
    };
  }
  deleteListItem() {
    for (let i = 0; i < this.deleteList.length; i++) {
      let index = this.accounts.indexOf(this.deleteList[i]);
      this.accounts.splice(index, 1);
      if(this.deleteList[i].accountType === 1){
        this.totalint = this.totalint - this.deleteList[i].amount;
      }else {
        this.totalout = this.totalout - this.deleteList[i].amount;
      }
      this.AccountTable.deleteData(this.deleteList[i], () => {
      });
    }
    this.deleteList = [];
  }
  @Builder itemEnd(index: number,item:AccountData) {
    // 侧滑后尾端出现的组件
    Button({ type: ButtonType.Circle }) {
      Image($rawfile('delete.png'))
    }
    .width($r('app.float.component_size_MP'))
    .height($r('app.float.component_size_MP'))
    .backgroundColor($r('app.color.background_color'))
    .onClick(() => {
      this.deleteList.push(item);
      this.deleteListItem();
    })
  }
  build() {
    Stack() {
      Column() {
        Row(){
          Text(`Money Up`)
            .height(`30vp`)
            .fontSize(25)
            .fontColor('#9B0000')
            .margin({top:'10vp', left:140})
        }.width('100%')

        Row() {
          Search({
            value: this.searchText,
            placeholder: CommonConstants.SEARCH_TEXT,
            controller: this.searchController
          })
            .width(CommonConstants.FULL_WIDTH)
            .borderRadius($r('app.float.radius_size_M'))
            .borderWidth($r('app.float.border_size_S'))
            .borderColor($r('app.color.border_color'))
            .placeholderFont({ size: $r('app.float.font_size_M') })
            .textFont({ size: $r('app.float.font_size_M') })
            .backgroundColor(Color.White)
            .onChange((searchValue: string) => {
              this.searchText = searchValue;
            })
        }
        .width(CommonConstants.FULL_WIDTH)
        .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
        .margin({ top: ('0vp'), bottom: ('2vp') })

        Row() {
          // 以12小时制显示东八区的系统时间，精确到秒。
          Column() {
            TextClock({ timeZoneOffset: -8, controller: this.controller })
              .format('yyyy')
              .fontSize(20)
              .height($r('app.float.component_size_SP'))
            TextClock({ timeZoneOffset: -8, controller: this.controller })
              .format('MM')
              .fontSize(20)
              .height($r('app.float.component_size_SP'))
          }.margin({ left: ('12vp') })

          Column() {
            Text(`收入`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
            Text(`${this.totalint}`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor(Color.White)
          }.margin({ right: ('8vp') })
          Column() {
            Text(`支出`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
            Text(`${this.totalout}`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor(Color.White )
          }.margin({ right: ('12vp') })
        }
        .width(CommonConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ top:('5vp'), bottom: ('0vp') })

        Row() {
          List({ space: CommonConstants.FULL_SIZE, scroller: this.scrollerForList }) {
            ForEach(this.accounts, (item: AccountData) => {
              ListItem() {
                Row() {
                  Image(ImageList[item.typeText])
                    .width($r('app.float.component_size_M'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                    .margin({ right: $r('app.float.edge_size_MP') })

                  Column() {
                    Row({space:8}){
                      Text(item.typeText)
                        .height($r('app.float.component_size_SM'))
                        .fontSize($r('app.float.font_size_M'))
                      if(item.remark === ''){
                        Text(`备注:无`)
                          .height($r('app.float.component_size_SM'))
                          .fontSize($r('app.float.font_size_M'))
                      }else{
                        Text(`备注:${item.remark}`)
                          .height($r('app.float.component_size_SM'))
                          .fontSize($r('app.float.font_size_M'))
                      }
                    }
                    Text(item.Date)
                      .height($r('app.float.component_size_SM'))
                      .fontSize($r('app.float.font_size_M'))
                  }.alignItems(HorizontalAlign.Start)

                  Blank()
                    .layoutWeight(1)

                  Text(item.accountType === 0 ? '-' + item.amount.toString() : '+' + item.amount.toString())
                    .fontSize($r('app.float.font_size_M'))
                    .fontColor(item.accountType === 0 ? $r('app.color.pay_color') : $r('app.color.main_color'))
                    .align(Alignment.End)
                    .flexGrow(CommonConstants.FULL_SIZE)
                    .onAppear(() => {
                      if(item.accountType === 1){
                        this.totalint = this.totalint + item.amount;
                      }else {
                        this.totalout = this.totalout + item.amount;
                      }
                    })
                }
                .width(CommonConstants.FULL_WIDTH)
                .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
              }.swipeAction({ end: () => {
                this.itemEnd(this.index, item)
              } }) // 设置侧滑属性.
              .width(CommonConstants.FULL_WIDTH)
              .height($r('app.float.component_size_LM'))
              .onClick(() => {
                this.selectListItem(item);
                this.dialogController.open();
              })
            })
          }
          .height("71%")
          .width(CommonConstants.FULL_WIDTH)
          .borderRadius($r('app.float.radius_size_M'))
          .backgroundColor(Color.White)
          .divider({
            strokeWidth: 1,
            startMargin: 60,
            endMargin: 10,
            color: '#ffe9f0f0'
          })
        }
        .width(CommonConstants.FULL_WIDTH)
        .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
        .margin({ top:'2vp' })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.FULL_HEIGHT)

      Button() {
        Image($rawfile('add.svg'))
      }
      .width($r('app.float.component_size_MP'))
      .height($r('app.float.component_size_MP'))
      .position({ x: CommonConstants.EDIT_POSITION_X, y: CommonConstants.EDIT_POSITION_Y })
      .onClick(() => {
        this.isInsert = true;
        this.newAccount = { id: 0, accountType: 0, typeText: '', amount: 0 ,Date:'',remark:''};
        this.dialogController.open();
      })
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor($r('app.color.themeColor'))
  }
}