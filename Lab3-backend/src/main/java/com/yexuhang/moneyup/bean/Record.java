package com.yexuhang.moneyup.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.OptBoolean;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 账单表
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-11-29
 */
@Getter
@Setter
@Accessors(chain = true)
public class Record implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 账单id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 账单创建用户
     */
    private String username;

    /**
     * 账单分类名称
     */
    private String category;

    /**
     * 账单金额
     */
    private BigDecimal amount;

    /**
     * 备注
     */
    private String description;

    /**
     * 记录创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 流水对应日期
     */
    @JsonFormat(pattern = "yyyy-M-d", lenient = OptBoolean.TRUE)
    private Date date;

    /**
     * 0表支出，1表收入
     */
    private Integer type;
}
