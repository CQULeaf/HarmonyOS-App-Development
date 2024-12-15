package com.yexuhang.note.service;

import com.yexuhang.note.bean.Notes;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yexuhang.note.config.CommonResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-12-09
 */
public interface NotesService extends IService<Notes> {
        // 添加笔记
        CommonResult<?> addNotes(Notes notes);

        // 删除笔记
        CommonResult<?> deleteNotes(Integer id);

        // 查询用户笔记
        CommonResult<?> getNotesList(String username);

        // 查询用户已删除的笔记
        CommonResult<?> getDeletedNotesList(String username);

        // 通过 id 查询笔记
        CommonResult<?> getNotesById(Integer id);

        // 编辑笔记
        CommonResult<?> editNotes(Integer id, String title, String category, String content);

        // 更新置顶状态
        CommonResult<?> updateTop(Integer id, Boolean isTop);

        // 更新收藏状态
        CommonResult<?> updateFavorite(Integer id, Boolean isFavorite);

        // 修改分类
        CommonResult<?> updateCategory(Integer id, String category);

        // 恢复笔记
        CommonResult<?> recoverNotes(Integer id);

        // 彻底删除笔记
        CommonResult<?> deleteNotesPermanently(Integer id);
}
