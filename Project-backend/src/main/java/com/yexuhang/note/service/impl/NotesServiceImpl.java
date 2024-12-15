package com.yexuhang.note.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yexuhang.note.bean.Notes;
import com.yexuhang.note.config.CommonResult;
import com.yexuhang.note.mapper.NotesMapper;
import com.yexuhang.note.service.NotesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-12-09
 */
@Service
public class NotesServiceImpl extends ServiceImpl<NotesMapper, Notes> implements NotesService {
    @Autowired
    private NotesMapper notesMapper;

    // 添加笔记
    @Override
    public CommonResult<?> addNotes(Notes notes) {
        int result = notesMapper.insert(notes);
        if (result > 0) {
            return CommonResult.success("添加成功", notes);
        } else {
            return CommonResult.error("添加失败, 请稍后再试");
        }
    }

    // 删除笔记
    @Override
    public CommonResult<?> deleteNotes(Integer id) {
        // 查询笔记是否存在
        Notes note = notesMapper.selectById(id);
        if (note == null) {
            return CommonResult.error("笔记不存在");
        }

        // 逻辑删除（设置 is_deleted 为 TRUE）
        note.setIsDeleted(true);
        int result = notesMapper.updateById(note);

        if (result > 0) {
            return CommonResult.success("删除成功", id);
        } else {
            return CommonResult.error("删除失败, 请稍后再试");
        }
    }

    // 查询用户笔记
    @Override
    public CommonResult<?> getNotesList(String username) {
        QueryWrapper<Notes> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        queryWrapper.eq("is_deleted", false);
        List<Notes> notesList = notesMapper.selectList(queryWrapper);

        return CommonResult.success("查询成功", notesList);
    }

    // 查询用户已删除的笔记
    @Override
    public CommonResult<?> getDeletedNotesList(String username) {
        QueryWrapper<Notes> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        queryWrapper.eq("is_deleted", true);
        List<Notes> notesList = notesMapper.selectList(queryWrapper);

        return CommonResult.success("查询成功", notesList);
    }


    // 通过 ID 查询笔记
    @Override
    public CommonResult<?> getNotesById(Integer id) {
        Notes note = notesMapper.selectById(id);
        if (note == null || note.getIsDeleted()) {
            return CommonResult.error("笔记不存在或已删除");
        }

        return CommonResult.success("查询成功", note);
    }

    // 编辑笔记内容
    @Override
    public CommonResult<?> editNotes(Integer id, String title, String category, String content) {
        // 查询笔记是否存在并且未被删除
        Notes note = notesMapper.selectById(id);
        if (note == null || note.getIsDeleted()) {
            return CommonResult.error("笔记不存在或已删除");
        }

        // 更新字段
        boolean isUpdated = false;
        if (title != null) {
            note.setTitle(title);
            isUpdated = true;
        }
        if (category != null) {
            note.setCategory(category);
            isUpdated = true;
        }
        if (content != null) {
            note.setContent(content);
            isUpdated = true;
        }

        // 如果有更新，修改更新时间
        if (isUpdated) {
            note.setUpdatedAt(LocalDateTime.now());
            int result = notesMapper.updateById(note);
            if (result > 0) {
                return CommonResult.success("编辑成功", note);
            } else {
                return CommonResult.error("编辑失败, 请稍后再试");
            }
        }

        return CommonResult.success("无需更新, 编辑内容未改变", note);
    }

    // 更新置顶状态
    @Override
    public CommonResult<?> updateTop(Integer id, Boolean isTop) {
        // 查询笔记是否存在并且未被删除
        Notes note = notesMapper.selectById(id);
        if (note == null || note.getIsDeleted()) {
            return CommonResult.error("笔记不存在或已删除");
        }

        note.setIsTop(isTop);
        int result = notesMapper.updateById(note);
        if (result > 0) {
            return CommonResult.success("更新成功", note);
        } else {
            return CommonResult.error("更新失败, 请稍后再试");
        }
    }

    // 更新收藏状态
    @Override
    public CommonResult<?> updateFavorite(Integer id, Boolean isFavorite) {
        // 查询笔记是否存在并且未被删除
        Notes note = notesMapper.selectById(id);
        if (note == null || note.getIsDeleted()) {
            return CommonResult.error("笔记不存在或已删除");
        }

        note.setIsFavorite(isFavorite);
        int result = notesMapper.updateById(note);
        if (result > 0) {
            return CommonResult.success("更新成功", note);
        } else {
            return CommonResult.error("更新失败, 请稍后再试");
        }
    }

    // 修改分类
    @Override
    public CommonResult<?> updateCategory(Integer id, String category) {
        // 查询笔记是否存在并且未被删除
        Notes note = notesMapper.selectById(id);
        if (note == null || note.getIsDeleted()) {
            return CommonResult.error("笔记不存在或已删除");
        }

        note.setCategory(category);
        int result = notesMapper.updateById(note);
        if (result > 0) {
            return CommonResult.success("更新成功", note);
        } else {
            return CommonResult.error("更新失败, 请稍后再试");
        }
    }

    // 恢复笔记
    @Override
    public CommonResult<?> recoverNotes(Integer id) {
        // 查询笔记是否存在
        Notes note = notesMapper.selectById(id);
        if (note == null) {
            return CommonResult.error("笔记不存在");
        }

        // 恢复笔记（设置 is_deleted 为 FALSE）
        note.setIsDeleted(false);
        int result = notesMapper.updateById(note);

        if (result > 0) {
            return CommonResult.success("恢复成功", id);
        } else {
            return CommonResult.error("恢复失败, 请稍后再试");
        }
    }

    // 彻底删除笔记
    @Override
    public CommonResult<?> deleteNotesPermanently(Integer id) {
        // 查询笔记是否存在
        Notes note = notesMapper.selectById(id);
        if (note == null) {
            return CommonResult.error("笔记不存在");
        }

        // 彻底删除笔记
        int result = notesMapper.deleteById(id);

        if (result > 0) {
            return CommonResult.success("删除成功", id);
        } else {
            return CommonResult.error("删除失败, 请稍后再试");
        }
    }
}
