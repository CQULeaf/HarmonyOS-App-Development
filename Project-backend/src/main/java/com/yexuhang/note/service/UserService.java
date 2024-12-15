package com.yexuhang.note.service;

import com.yexuhang.note.bean.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yexuhang.note.config.CommonResult;

import java.time.LocalDateTime;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-12-09
 */
public interface UserService extends IService<User> {
    User login(String username, String password);

    CommonResult<?> register(String username, String password1, String password2);

    CommonResult<?> changePassword(String username, String oldPassword, String newPassword1, String newPassword2, LocalDateTime updateAt);
}
