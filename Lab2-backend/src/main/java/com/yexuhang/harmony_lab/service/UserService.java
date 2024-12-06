package com.yexuhang.harmony_lab.service;

import com.yexuhang.harmony_lab.bean.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yexuhang.harmony_lab.config.CommonResult;

/**
 * <p>
 * 用户 服务类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-10-18
 */
public interface UserService extends IService<User> {

    // 实现登录查询
    User login(String username, String password);

    // 实现注册并完成两次密码输入的校验
    CommonResult<?> register(String username, String password1, String password2);

    // 实现排名查询
    CommonResult<?> rank(String username);

    // 实现更新分数
    CommonResult<?> updateScore(String username, int score);
}
