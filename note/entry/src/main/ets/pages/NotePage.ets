import NoteModel from '../bean/NoteModel'
import { noteAdd } from '../api/notes'
import { router } from '@kit.ArkUI'
import CommonConstants from '../common/CommonConstants'

@Entry
@Component
struct AddNotePage {
  @StorageProp('CurrentUsername') username: string = '';
  @StorageProp('categoryList') categoryList: string[] = [];
  @State addTitle: string = ''
  @State addContent: string = ''
  @State selectedCategory: string = ''

  // 操作历史
  undoStack: string[] = []
  redoStack: string[] = []

  // 保存当前状态到撤销栈
  saveStateBeforeChange(newContent: string) {
    // 如果有新的内容，保存当前内容到撤销栈
    if (newContent !== this.addContent) {
      this.undoStack.push(this.addContent)
      this.addContent = newContent
      // 清空前撤栈
      this.redoStack = []
    }
  }

  get canUndo() {
    return this.undoStack.length > 0;
  }

  get canRedo() {
    return this.redoStack.length > 0;
  }

  // 后撤操作
  undo() {
    if (this.canUndo) {
      // 从操作栈中取出最后一个操作，恢复内容
      const lastState = this.undoStack.pop()
      if (lastState !== undefined) {
        this.redoStack.push(this.addContent)
        this.addContent = lastState
      }
    } else {
      console.log('没有更多操作可以后撤')
    }
  }

  // 前撤操作
  redo() {
    if (this.canRedo) {
      // 从撤销栈中取出最后一个撤销的操作，恢复内容
      const redoState = this.redoStack.pop()
      if (redoState !== undefined) {
        this.undoStack.push(this.addContent)
        this.addContent = redoState
      }
    } else {
      console.log('没有更多操作可以前撤')
    }
  }

  // 添加笔记
  async noteAdd() {
    try {
      const res = await noteAdd<NoteModel>(this.username, this.addTitle, this.addContent, this.selectedCategory)
      console.log('添加成功:', res)
      AlertDialog.show({
        message: '笔记添加成功！'
      })
      router.pushUrl({ url: 'pages/Index' })
    } catch (error) {
      if (this.addContent.trim() === '') {
        AlertDialog.show({
          message: '内容不能为空~'
        })
      } else {
        AlertDialog.show({
          message: '添加失败，请检查网络连接或稍后重试'
        })
      }
    }
  }

  build() {
    // 编辑卡片
    Column() {
      // 四个按钮
      Row() {
        // 返回按钮
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .margin({ left: 26 })
          .onClick(() => {
            router.back()
          })

        // 后撤按钮
        Image(this.canUndo ? $r('app.media.undo') : $r('app.media.undo_disabled'))
          .width(24)
          .height(24)
          .margin({ left: 100 })
          .onClick(() => {
            if (this.canUndo) {
              this.undo();
            }
          })
          .opacity(this.canUndo ? 1 : 0.5)
          .enabled(this.canUndo)

        // 前撤按钮
        Image(this.canRedo ? $r('app.media.redo') : $r('app.media.redo_disabled'))
          .width(24)
          .height(24)
          .margin({ right: 100 })
          .onClick(() => {
            if (this.canRedo) {
              this.redo();
            }
          })
          .opacity(this.canRedo ? 1 : 0.5)
          .enabled(this.canRedo)

        // 保存按钮
        Image($r('app.media.save'))
          .width(24)
          .height(24)
          .margin({ right: 26 })
          .onClick(() => {
            this.noteAdd()
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
      .width('100%')

      // 标题输入部分：可供输入的空行
      TextInput({
        placeholder: '请输入标题',
        text: this.addTitle
      })
        .onChange((value: string) => {
          this.addTitle = value
        })
        .height(40)
        .margin({ left: 20, right: 20, top: 10 })
        .backgroundColor('#fff')
        .padding(10)

      // 显示记录时间部分
      Row() {
        // 时间显示
        Text(new Date().toLocaleString())
          .fontSize(16)
          .fontColor('#397D54')
          .margin({ left: 20 })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
      .width('100%')

      // 文本输入部分
      TextArea({
        placeholder: '请输入笔记',
        text: this.addContent
      })
        .onChange((value: string) => {
          this.addContent = value
        })
        .height('70%')
        .margin(20)
        .backgroundColor('#fff')
        .padding(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#73C088')
  }
}