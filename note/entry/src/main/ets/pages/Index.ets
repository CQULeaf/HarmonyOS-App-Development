import CustomAddDialog from '../component/CustomAddDialog'
import CustomEditDialog from '../component/CustomEditDialog'
import CustomSearch from '../component/CustomSearch'
import CustomTitle from '../component/CustomTitle'
import MemoItem from '../component/MemoItem'
import NoteModel from '../model/NoteModel'
import { noteList, noteAdd, noteDelete, noteEdit } from '../api/notes'

interface ResponseNoteList extends Array<NoteModel> {}

@Entry
@Component
struct Index {
  @StorageProp('CurrentUsername') username: string = '';

  @State noteList: NoteModel[] = []
  @State isAddDialogShow: boolean = false
  @State isEditDialogShow: boolean = false

  // 新建暂存内容
  @State addContent: string = ''
  // 编辑弹窗文本输入的暂存内容
  @State editContent: string = ''

  // 当前编辑的memo索引
  editingMemoIndex: number = -1

  async getNoteList() {
    try {
      const response = await noteList<ResponseNoteList>(this.username);
      this.noteList = response;
      console.log('查询成功:', response);
    } catch (error) {
      console.log(error);
    }
  }

  // 点击笔记时的方法
  clickNote = (note: NoteModel) => {
    this.editingMemoIndex = this.noteList.indexOf(note)
    this.editContent = note.content
    this.isEditDialogShow = true
  }

  // 新增笔记的方法

  // 删除笔记的方法

  // 修改笔记的方法

  // 关闭弹窗的方法
  closeDialog = () => {
    this.isAddDialogShow = false
    this.addContent = ''
    this.isEditDialogShow = false
    this.editContent = ''
    this.editingMemoIndex = -1
  }

  // 页面初始化前向页面加载数据
  aboutToAppear() {
    this.getNoteList()
  }

  // 排序状态
  @State @Watch('refreshByOrder') order: boolean = true

  // 排序状态变化事件监听函数
  refreshByOrder() {
    let orderList: MemoModel[] = this.memoList
    const length = orderList.length
    for (let i = 0; i < length - 1; i++) {
      for (let j = 0; j < length - i - 1; j++) {
        const timeA = orderList[j].updateTime
        const timeB = orderList[j+1].updateTime

        if ((timeA > timeB && this.order) || (timeA < timeB && !this.order)) {
          const temp = orderList[j]
          orderList[j] = orderList[j+1]
          orderList[j+1] = temp
        }
      }
    }
    this.memoList = orderList
  }

  // 搜索关键词
  @State @Watch('onKeywordsChange') keywords: string = ''

  // 清空搜索关键词的方法
  cleanKeywords = () => {
    this.keywords = ''
  }

  // 监听搜索关键词的过滤方法
  onKeywordsChange() {
    if (this.keywords.length === 0) {
      this.memoList = this.originMemoList
      this.refreshByOrder()
    } else {
      let resultList: MemoModel[] = []

      for (const memoItem of this.originMemoList) {
        if (memoItem.content.includes(this.keywords)) {
          resultList.push(memoItem)
        }
      }
      this.memoList = resultList
    }
  }

  build() {
    Stack() {
      // 背景图片
      Image($r('app.media.bg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      // 主体页面
      Column() {
        // 标题栏
        CustomTitle({
          order: $order,
          isAddDialogShow: $isAddDialogShow
        })

        Divider()
          .color('#604637')

        // 搜索框
        CustomSearch({ keywords: $keywords, cleanKeywords: this.cleanKeywords })

        // 笔记列表
        Scroll() {
          Column() {
            ForEach(
              this.memoList,
              (memo: MemoModel, index: number) => {
                // 笔记点击方法
                MemoItem({ memo: this.memoList[index], onMemoClick: this.clickMemo })
              },
              (memo: MemoModel) => {
                return memo.content
              }
            )
          }
        }
      }
      .width('100%')
      .height('100%')

      // 新建弹窗新增笔记方法
      if (this.isAddDialogShow) {
        CustomAddDialog({
          addContent: $addContent,
          onClose: this.closeDialog,
          onCreate: this.createMemo
        })
      }

      // 编辑弹窗
      if (this.isEditDialogShow) {
        CustomEditDialog({
          editContent: $editContent,
          onClose: this.closeDialog,
          onDelete: this.deleteMemo,
          onSave: this.saveMemo
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}