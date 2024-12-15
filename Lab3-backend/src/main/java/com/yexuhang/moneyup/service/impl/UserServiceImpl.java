package com.yexuhang.moneyup.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yexuhang.moneyup.bean.User;
import com.yexuhang.moneyup.config.CommonResult;
import com.yexuhang.moneyup.mapper.UserMapper;
import com.yexuhang.moneyup.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-11-27
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private UserMapper userMapper;

    // 实现登录查询
    @Override
    public User login(String username, String password) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username).eq("password", password);
        return userMapper.selectOne(queryWrapper);
    }

    // 实现注册并完成两次密码输入的校验
    @Override
    public CommonResult<?> register(String username, String password1, String password2) {
        // 检查用户名是否已经存在
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        User existingUser = userMapper.selectOne(queryWrapper);

        if (existingUser != null) {
            return CommonResult.error("用户名已存在, 请重新输入");
        }

        // 检查两次密码是否一致
        if (!password1.equals(password2)) {
            return CommonResult.error("两次密码输入不一致, 请重新输入");
        }

        // 创建新用户对象并保存到数据库
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password1);

        int result = userMapper.insert(newUser);
        if (result > 0) {
            return CommonResult.success("注册成功", newUser);
        } else {
            return CommonResult.error("注册失败, 请稍后再试");
        }
    }

    // 实现修改密码
    @Override
    public CommonResult<?> changePassword(String username, String oldPassword, String newPassword1, String newPassword2, LocalDateTime updateAt) {
        // 检查用户名和旧密码是否匹配
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username).eq("password", oldPassword);
        User existingUser = userMapper.selectOne(queryWrapper);

        if (existingUser == null) {
            return CommonResult.error("用户名或密码错误, 请重新输入");
        }

        // 检查两次新密码是否一致
        if (!newPassword1.equals(newPassword2)) {
            return CommonResult.error("两次新密码输入不一致, 请重新输入");
        }

        // 更新密码与更新时间
        existingUser.setPassword(newPassword1);
        existingUser.setUpdatedAt(updateAt);
        int result = userMapper.updateById(existingUser);
        if (result > 0) {
            return CommonResult.success("修改密码成功", existingUser);
        } else {
            return CommonResult.error("修改密码失败, 请稍后再试");
        }
    }
}
