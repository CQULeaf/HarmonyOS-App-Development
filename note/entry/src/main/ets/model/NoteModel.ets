@Observed
class NoteModel {
  noteId: number = 0
  username: string = ''
  title?: string
  content: string = ''
  category: string = ''
  createdAt: number = 0
  updatedAt: number = 0
  is_deleted: boolean = false
}

export default NoteModel