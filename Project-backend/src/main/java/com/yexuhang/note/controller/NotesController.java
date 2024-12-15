package com.yexuhang.note.controller;

import com.yexuhang.note.bean.Notes;
import com.yexuhang.note.config.CommonResult;
import com.yexuhang.note.service.NotesService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-12-09
 */
@RestController
@Slf4j
@RequestMapping("/notes")
@CrossOrigin(origins = "*")
public class NotesController {
    @Autowired
    private NotesService notesService;

    // 添加笔记
    @PostMapping("/add")
    public CommonResult<?> addNotes(@RequestBody Notes notes) {
        log.info("Add notes: {}", notes);
        return notesService.addNotes(notes);
    }

    // 删除笔记
    @DeleteMapping("/delete/{id}")
    public CommonResult<?> deleteNotes(@PathVariable Integer id) {
        log.info("Delete notes with id: {}", id);
        return notesService.deleteNotes(id);
    }

    // 查询用户笔记
    @GetMapping("/list/{username}")
    public CommonResult<?> getNotesList(@PathVariable String username) {
        log.info("Get notes list of user: {}", username);
        return notesService.getNotesList(username);
    }

    // 查询用户已删除的笔记
    @GetMapping("/deleted/{username}")
    public CommonResult<?> getDeletedNotesList(@PathVariable String username) {
        log.info("Get deleted notes list of user: {}", username);
        return notesService.getDeletedNotesList(username);
    }

    // 通过 id 查询笔记
    @GetMapping("/get/{id}")
    public CommonResult<?> getNotesById(@PathVariable Integer id) {
        log.info("Get notes by id: {}", id);
        return notesService.getNotesById(id);
    }

    // 编辑笔记内容
    @PutMapping("/edit/{id}")
    public CommonResult<?> editNotes(
            @PathVariable Integer id,
            @RequestBody Notes note) {
        log.info("Edit note with id: {}", id);

        return notesService.editNotes(id, note.getTitle(), note.getCategory(), note.getContent());
    }

    // 更新置顶状态
    @PutMapping("/top/{id}")
    public CommonResult<?> updateTop(
            @PathVariable Integer id,
            @RequestParam Boolean isTop) {
        log.info("Update top status of note with id: {}", id);

        return notesService.updateTop(id, isTop);
    }

    // 更新收藏状态
    @PutMapping("/favorite/{id}")
    public CommonResult<?> updateFavorite(
            @PathVariable Integer id,
            @RequestParam Boolean isFavorite) {
        log.info("Update favorite status of note with id: {}", id);

        return notesService.updateFavorite(id, isFavorite);
    }

    // 修改分类
    @PutMapping("/category/{id}")
    public CommonResult<?> updateCategory(
            @PathVariable Integer id,
            @RequestParam String category) {
        log.info("Update category of note with id: {}", id);

        return notesService.updateCategory(id, category);
    }

    // 恢复笔记
    @PutMapping("/recover/{id}")
    public CommonResult<?> recoverNotes(@PathVariable Integer id) {
        log.info("Recover note with id: {}", id);
        return notesService.recoverNotes(id);
    }

    // 彻底删除笔记
    @DeleteMapping("/deletePermanently/{id}")
    public CommonResult<?> deleteNotesPermanently(@PathVariable Integer id) {
        log.info("Delete note permanently with id: {}", id);
        return notesService.deleteNotesPermanently(id);
    }
}
