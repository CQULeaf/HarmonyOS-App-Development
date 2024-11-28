import router from '@ohos.router'
import prompt from '@ohos.promptAction';
import CommonConstants from '../common/constants/CommonConstants';
import UserTable from '../common/database/tables/UserTable';
import UserData from '../viewmodel/UserData';
@Entry
@Component
export struct Froget {
  private inputusername ='';
  private inputpassword='';
  private inputpassword1='';
  @State show : number = 0;
  @State user: Array<UserData> = [];
  @State newUser: UserData = {
    id: 0,
    username: '',
    password: '',
    realname: ''
  };
  private UserTable = new UserTable(() => {});
  accept(newUser: UserData): void {
    this.UserTable.updatePassword(newUser, (result:number|boolean) => {
      if (result === -1) {
        prompt.showToast({ message: '用户名未注册', bottom: CommonConstants.PROMPT_BOTTOM });
      } else if (result === false) {
        prompt.showToast({ message: '密码修改成功', bottom: CommonConstants.PROMPT_BOTTOM });
        router.back();
      } else if (result === true) {
        prompt.showToast({ message: '新旧密码相同', bottom: CommonConstants.PROMPT_BOTTOM });
      }
    });
  }
  ifquel(): void {
    if(this.inputpassword !== this.inputpassword1){
      this.show = 1;
    }else if(this.inputpassword === this.inputpassword1){
      this.show = 0;
    }
  }
  build() {
    Column() {
      Image($rawfile('user.png'))
        .height(150)
        .width(150)
        .margin({top:80,bottom:40})
      Text("修改密码")
        .fontSize(20)
        .fontColor(Color.White)

      TextInput({
        placeholder:"请输入你的账号",
      })
        .width('90%')
        .height(50)
        .margin(10)
        .borderRadius(25)
        .type(InputType.Normal)
        .onChange((value: string) => {
          this.inputusername = value;
        }).backgroundColor(Color.White)

      TextInput({ placeholder:"请输入你的新密码"})
        .width('90%')
        .height(50)
        .margin(10)
        .borderRadius(25)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.inputpassword = value;
        }).backgroundColor(Color.White)

      TextInput({ placeholder:"请确认你的新密码"})
        .width('90%')
        .height(50)
        .margin(10)
        .borderRadius(25)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.inputpassword1 = value;
          this.ifquel();
        }).backgroundColor(Color.White)


      if(this.show === 1){
        Text("两次输入的密码不一致！")
          .fontSize(18)
          .fontColor(Color.Red)
      }


      Text('修改完成？去登录')
        .margin({top:'5vp'})
        .fontSize(18)
        .fontColor(Color.White)
        .decoration({ type: TextDecorationType.Underline, color:(Color.White) })
        .textAlign(TextAlign.Start)
        .onClick(() => {
          router.back();
        })

      Button('确认修改',{type:ButtonType.Capsule})
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
            if(this.inputpassword === this.inputpassword1){
              this.newUser.username = this.inputusername;
              this.newUser.password = this.inputpassword;
              this.accept(this.newUser);
            }else{
              prompt.showToast({ message: '两次输入的密码不一致！', bottom: CommonConstants.PROMPT_BOTTOM });
            }

          }
        })

    }.width('100%').height('100%').backgroundColor($r('app.color.themeColor'))
  }
}
