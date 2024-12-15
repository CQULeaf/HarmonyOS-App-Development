package com.yexuhang.note.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-12-09
 */
@Getter
@Setter
@Accessors(chain = true)
public class Notes implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "note_id", type = IdType.AUTO)
    private Integer noteId;

    private String username;

    private String title;

    private String content;

    private String category;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private Boolean isDeleted;

    private Boolean isTop;

    private Boolean isFavorite;
}
