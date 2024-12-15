package com.yexuhang.moneyup.service;

import com.yexuhang.moneyup.bean.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yexuhang.moneyup.config.CommonResult;

import java.time.LocalDateTime;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-11-27
 */
public interface UserService extends IService<User> {
    // 实现登录查询
    User login(String username, String password);

    // 实现注册并完成两次密码输入的校验
    CommonResult<?> register(String username, String password1, String password2);

    // 实现修改密码
    CommonResult<?> changePassword(String username, String oldPassword, String newPassword1, String newPassword2, LocalDateTime updateAt);
}
