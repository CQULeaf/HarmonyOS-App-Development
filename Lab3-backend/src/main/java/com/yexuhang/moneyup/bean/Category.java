package com.yexuhang.moneyup.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 收支分类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-11-27
 */
@Getter
@Setter
@Accessors(chain = true)
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long userId;

    /**
     * 分类名称
     */
    private String name;

    /**
     * 分类类型
     */
    private Byte type;

    /**
     * 分类创建时间
     */
    private LocalDateTime createdAt;
}
