@CustomDialog
export struct NewCategoryDialog {
  controller: CustomDialogController
  confirm?: (value: string) => void;
  category: string = '';

  build() {
    Column({ space: 20 }) {
      Text('新建一个分类')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextInput({ placeholder: '请输入分类名称', text: this.category })
        .onChange((value) => {
          this.category= value;
        })
        .fontSize(18)
        .padding({ left: 10, right: 10 })
        .margin({ top: 10, bottom: 10 })

      Row({ space: 50 }) {
        Button('确认')
          .onClick(() => {
            if (this.category.trim() && this.confirm) {
              this.confirm(this.category);
              this.controller.close();
            } else {
              console.log('分类名称不能为空');
            }
          })
          .backgroundColor('#73C088')
          .fontColor('#fff')

        Button('取消')
          .onClick(() => {
            this.controller.close();
          })
          .backgroundColor('#E4E4E4')
          .fontColor('#333')
      }
    }
    .padding(20)
    .width('80%')
    .height('auto')
  }
}