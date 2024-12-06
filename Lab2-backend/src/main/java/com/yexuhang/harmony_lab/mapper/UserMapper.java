package com.yexuhang.harmony_lab.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yexuhang.harmony_lab.bean.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 用户 Mapper 接口
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-10-18
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {
}
