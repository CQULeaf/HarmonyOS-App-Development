@CustomDialog
export struct CustomDialogDemo {
  messageDialog: string = '';
  imgRes: Resource = $r('app.media.GAME_LOGO');
  messageTitle: string = '';
  controller: CustomDialogController;
  cancel?: () => void;
  confirm?: () => void;

  build() {
    Column() {
      Row() {
        Image(this.imgRes)
          .size({ width: 25, height: 25 })
          .interpolation(ImageInterpolation.High)
          .borderRadius(5)
          .margin({ left: 20 });
        Text(this.messageTitle)
          .fontColor('#E60000')
          .fontSize(25)
          .margin({ left: 10 });
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .height(40);

      Row().height(2).backgroundColor('#F4F4F4').width('100%');

      Row() {
        Text(this.messageDialog)
          .fontSize(20)
          .margin({ top: 10, bottom: 10 });
      }
      .justifyContent(FlexAlign.Center);

      Row().height(2).backgroundColor('#F4F4F4').width('100%').margin({ bottom: 1 });

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close();
          }).backgroundColor(0xffffff).fontColor(Color.Black);
        Button('确定')
          .onClick(() => {
            this.controller.close();
          }).backgroundColor(0xffffff).fontColor(Color.Red);
      }.margin({ bottom: 10 });
    }
  }
}