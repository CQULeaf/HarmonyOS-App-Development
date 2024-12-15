export default interface NoteModel {
  noteId: number
  username: string
  title: string
  content: string
  category: string
  createdAt: number
  updatedAt: number
  isDeleted: boolean
  isTop: boolean
  isFavorite: boolean
}