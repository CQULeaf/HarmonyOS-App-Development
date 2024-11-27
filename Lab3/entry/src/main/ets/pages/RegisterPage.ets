import router from '@ohos.router'
import prompt from '@ohos.promptAction';
import CommonConstants from '../common/constants/CommonConstants';
import UserTable from '../common/database/tables/UserTable';
import UserData from '../viewmodel/UserData';
@Entry
@Component
export struct Register {
  private inputusername ='';
  private inputpassword='';
  @State user: Array<UserData> = [];
  @State newUser: UserData = {
    id: 0,
    username: '',
    password: '',
    realname: ''
  };
  private UserTable = new UserTable(() => {});
  accept(newUser: UserData): void {
       this.UserTable.insertData(newUser, () => {});
  }

  build() {
    Column() {
      Image($rawfile('user.png'))
        .height(150)
        .width(150)
        .margin({top:80,bottom:40})
      Text("欢迎注册")
        .fontSize(20)
        .fontColor(Color.White)

      TextInput({
        placeholder:"请输入你的账号",
      })
        .width('90%')
        .height(50)
        .margin(20)
        .borderRadius(0)
        .type(InputType.Normal)
        .onChange((value: string) => {
          this.inputusername = value;
        }).backgroundColor(Color.White)
        .borderRadius(25)

      TextInput({ placeholder:"请输入你的密码"})
        .width('90%')
        .height(50)
        .margin(20)
        .borderRadius(0)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.inputpassword = value;
        }).backgroundColor(Color.White)
        .borderRadius(25)

      Text('已有账号？去登录')
        .fontSize(18)
        .fontColor(Color.White)
        .decoration({ type: TextDecorationType.Underline, color:(Color.White) })
        .textAlign(TextAlign.Start)
        .onClick(() => {
          router.back();
        })
      Button('注册',{type:ButtonType.Capsule})
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
            this.newUser.username = this.inputusername;
            this.newUser.password = this.inputpassword;
            this.accept(this.newUser);
            prompt.showToast({ message: CommonConstants.TOAST_TEXT_5, bottom: CommonConstants.PROMPT_BOTTOM });
            router.back();
          }
        })

    }.width('100%').height('100%').backgroundColor('#3ea8d1')

  }

}
