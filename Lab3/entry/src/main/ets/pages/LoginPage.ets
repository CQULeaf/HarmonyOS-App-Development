import router from '@ohos.router'
import prompt from '@ohos.promptAction';
import CommonConstants from '../common/constants/CommonConstants';
import UserTable from '../common/database/tables/UserTable';
import UserData from '../viewmodel/UserData';
@Entry
@Component
struct Login {
  @State myWidth: number = 650;
  @State myHeight: number = 650;
  @State top: number = -80;
  // 标志位，true和false分别对应一组myWidth、myHeight值
  @State flag: boolean = false;
  private inputusername ='';
  private inputpassword='';
  @State isAccept:boolean = false
  @State user: Array<UserData> = [];
  @State newUser: UserData = { id: 0, username:'', password:'',realname:''};
  private UserTable = new UserTable(() => {});
  accept(newUser: UserData): void {
    this.UserTable.query(newUser, (result:number|boolean) => {
      if (result === -1) {
        prompt.showToast({ message: '用户名未注册', bottom: CommonConstants.PROMPT_BOTTOM });
      } else if (result === true) {
        prompt.showToast({ message: '登录成功', bottom: CommonConstants.PROMPT_BOTTOM });
        router.pushUrl({ url: 'pages/MainPage' });
      } else if (result === false) {
        prompt.showToast({ message: '用户名与密码不匹配', bottom: CommonConstants.PROMPT_BOTTOM });
      } else {
        prompt.showToast({ message: '?', bottom: CommonConstants.PROMPT_BOTTOM });
      }
    });
  }
  build() {
    Column() {
      Text('汤姆记账')
        .fontWeight(60)
        .fontSize(60)
        .fontColor(Color.White)
        .margin({top:30})
      Image($rawfile('user.png'))
        .width(150)
        .height(150)
        .margin({top:40,bottom:20})
      TextInput({ placeholder:"账号"})
        .width('90%')
        .height(50)
        .margin(20)
        .type(InputType.Normal)
        .onChange((value: string) => {
          this.inputusername = value;
        }).backgroundColor(Color.White)
        .borderRadius(25)

      TextInput({ placeholder:"密码"})
        .width('90%')
        .height(50)
        .margin(20)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.inputpassword = value;
        }).backgroundColor(Color.White)
        .borderRadius(25)


      Row() {
        Text('还没有账号？去注册')
          .fontSize(15)
          .fontColor(Color.White)
          .decoration({ type: TextDecorationType.Underline, color:(Color.White) })
          .textAlign(TextAlign.Start)
          .onClick(() => {
            router.pushUrl({ url: 'pages/RegisterPage' })
          })
        Blank(120);
        Text('忘记密码')
          .fontSize(15)
          .fontColor(Color.White)
          .decoration({ type: TextDecorationType.Underline, color:(Color.White) })
          .textAlign(TextAlign.Start)
          .onClick(() => {
            router.pushUrl({ url: 'pages/FrogetPage' })
          })
      }



      Row(){
        Checkbox()
          .width(10)
          // .margin({top:})
          .animation({duration:1000, curve:Curve.EaseInOut})
          .onChange((value) => {
            this.isAccept = value
          })
        //一段文本中，有文本样式需要单独定制，text包裹span
        Text(){
          Span('我已阅读并同意').fontColor(Color.White)
          Span('《XX隐私政策》').fontColor('#3274f6')
          Span('《XX用户服务协议》').fontColor('#3274f6')
          Span('未注册的手机号将自动创建账号').fontColor(Color.White)
        }
        .fontSize(12)
        .fontColor('#666')
        .lineHeight(20)
      }
      .alignItems(VerticalAlign.Top)
      .margin({top : 3})










      Button('登录',{type:ButtonType.Capsule})
        .backgroundColor(Color.White)
        .fontColor(Color.Black)
        .width(200)
        .height(55)
        .fontSize(30)
        .margin(30)
        .borderRadius(30)
        .onClick(() => {
          if (this.inputpassword === ''||this.inputusername === '') {
            prompt.showToast({ message: CommonConstants.TOAST_TEXT_4, bottom: CommonConstants.PROMPT_BOTTOM });
          } else {
            this.newUser.username=this.inputusername;
            this.newUser.password=this.inputpassword;
            this.accept(this.newUser);
            prompt.showToast({ message: CommonConstants.TOAST_TEXT_5, bottom: CommonConstants.PROMPT_BOTTOM });
          }
        })

      //底部居底blank()
      Blank()
      //底部，其他登录方式
      Column(){
        Text('其他登录方式')
          .fontSize(14)
          .height(22)
          .margin({bottom:28})
          .fontColor(Color.White)
        Row(){
          Image($r('app.media.jd_huawei')).width(34)
          Image($r('app.media.we_chat')).width(34).fillColor('#69ab4a')
          Image($r('app.media.weibo')).width(34).fillColor('#ca5a42')
          Image($r('app.media.QQ')).width(34).fillColor('#68a8df')
        }
        .justifyContent(FlexAlign.SpaceAround)
        .margin({bottom:30})
        .width('100%')
      }
      .width('100%')
    }.width('100%').height('100%').backgroundColor('#3ea8d1').padding(10)
  }

}
