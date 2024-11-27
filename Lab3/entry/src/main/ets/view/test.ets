import AccountTable from '../common/database/tables/AccountTable';
import AccountData from '../viewmodel/AccountData';
import CommonConstants from '../common/constants/CommonConstants';
import { DialogComponent } from '../view/DialogComponent';
import { ImageList } from '../viewmodel/AccountList';
import Logger from '../common/utils/Logger';
import promptAction from '@ohos.promptAction';

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
          Image($rawfile('user.png'))
            .height(`30vp`)
            .margin({left:20})
          Text(`汤姆记账`)
            .height(`30vp`)
            .fontSize(25)
            .fontColor(Color.White)
            .margin({top:'10vp', left:100})
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
            .onSubmit((searchValue: string) => {
              if (searchValue === '') {
                this.AccountTable.query(0, (result: AccountData[]) => {
                  this.accounts = result;
                }, true);
              } else if(this.searchcheck === 1){
                if(isNaN(Number(searchValue)) === false){
                  this.AccountTable.query(Number(searchValue), (result: AccountData[]) => {
                    this.accounts = result;
                  }, false);
                }else{
                  promptAction.showToast({ message: '请输入数字！' })
                }

              }else if(this.searchcheck === 2){
                this.AccountTable.queryDate(searchValue, (result: AccountData[]) => {
                  this.accounts = result;
                }, false);
              }else if(this.searchcheck === 3){
                this.AccountTable.queryremark(searchValue, (result: AccountData[]) => {
                  this.accounts = result;
                }, false);
              }else if(this.searchcheck === 4){
                if(searchValue === 'cy'){
                  searchValue = '餐饮';
                }else if(searchValue === 'gw'){
                  searchValue = '购物';
                }else if(searchValue === 'ry'){
                  searchValue = '日用';
                }else if(searchValue === 'jt'){
                  searchValue = '交通';
                }else if(searchValue === 'sc'){
                  searchValue = '蔬菜';
                }else if(searchValue === 'sg'){
                  searchValue = '水果';
                }else if(searchValue === 'ls'){
                  searchValue = '零食';
                }else if(searchValue === 'yd'){
                  searchValue = '运动';
                }else if(searchValue === 'yl'){
                  searchValue = '娱乐';
                }else if(searchValue === 'tx'){
                  searchValue = '通讯';
                }else if(searchValue === 'fs'){
                  searchValue = '服饰';
                }else if(searchValue === 'mr'){
                  searchValue = '美容';
                }else if(searchValue === 'zf'){
                  searchValue = '住房';
                }else if(searchValue === 'jtyj'){
                  searchValue = '家庭用具';
                }else if(searchValue === 'hz'){
                  searchValue = '孩子';
                }else if(searchValue === 'zb'){
                  searchValue = '长辈';
                }else if(searchValue === 'sj'){
                  searchValue = '社交';
                }else if(searchValue === 'lx'){
                  searchValue = '旅行';
                }else if(searchValue === 'yj'){
                  searchValue = '烟酒';
                }else if(searchValue === 'sm'){
                  searchValue = '数码';
                }else if(searchValue === 'qc'){
                  searchValue = '汽车';
                }else if(searchValue === 'yy'){
                  searchValue = '医院';
                }else if(searchValue === 'ts'){
                  searchValue = '图书';
                }else if(searchValue === 'xx'){
                  searchValue = '学习';
                }else if(searchValue === 'cw'){
                  searchValue = '宠物';
                }else if(searchValue === 'lj'){
                  searchValue = '礼金';
                }else if(searchValue === 'lw'){
                  searchValue = '礼物';
                }else if(searchValue === 'bg'){
                  searchValue = '办公';
                }else if(searchValue === 'wx'){
                  searchValue = '维修';
                }else if(searchValue === 'gy'){
                  searchValue = '公益';
                }else if(searchValue === 'cy'){
                  searchValue = '彩票';
                }else if(searchValue === 'qy'){
                  searchValue = '亲友';
                }else if(searchValue === 'kd'){
                  searchValue = '快递';
                }else if(searchValue === 'wm'){
                  searchValue = '外卖';
                }else if(searchValue === 'qtzc'){
                  searchValue = '其他支出';
                }else if(searchValue === 'gz'){
                  searchValue = '工资';
                }else if(searchValue === 'jz'){
                  searchValue = '兼职';
                }else if(searchValue === 'lc'){
                  searchValue = '理财';
                }else if(searchValue === 'jj'){
                  searchValue = '奖金';
                }else if(searchValue === 'fh'){
                  searchValue = '分红';
                }else if(searchValue === 'jxj'){
                  searchValue = '奖学金';
                }else if(searchValue === 'yysr'){
                  searchValue = '营业收入';
                }else if(searchValue === 'qtsr'){
                  searchValue = '其他收入';
                } else{
                  promptAction.showToast({ message: '请输入正确的检字组合！' })
                }
                this.AccountTable.queryType(searchValue, (result: AccountData[]) => {
                  this.accounts = result;
                }, false);
              }
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