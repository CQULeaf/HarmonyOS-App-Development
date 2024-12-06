package com.yexuhang.harmony_lab.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yexuhang.harmony_lab.bean.User;
import com.yexuhang.harmony_lab.config.CommonResult;
import com.yexuhang.harmony_lab.mapper.UserMapper;
import com.yexuhang.harmony_lab.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>
 * 用户 服务实现类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-10-18
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
            return CommonResult.error("用户名已存在");
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
            return CommonResult.success("注册成功");
        } else {
            return CommonResult.error("注册失败, 请稍后再试");
        }
    }

    // 实现查询排名与积分
    @Override
    public CommonResult<?> rank(String username) {
        // 查询全局排名前15名用户
        QueryWrapper<User> globalRankWrapper = new QueryWrapper<>();
        globalRankWrapper.orderByDesc("score").last("LIMIT 15");
        var globalRanking = userMapper.selectList(globalRankWrapper);

        // 查询当前用户的得分
        QueryWrapper<User> userScoreWrapper = new QueryWrapper<>();
        userScoreWrapper.eq("username", username);
        User user = userMapper.selectOne(userScoreWrapper);

        if (user == null) {
            return CommonResult.error("用户不存在");
        }

        int userScore = user.getScore();

        // 计算当前用户的排名
        QueryWrapper<User> rankWrapper = new QueryWrapper<>();
        rankWrapper.gt("score", userScore);
        int rank = (int) (userMapper.selectCount(rankWrapper) + 1);

        // 构建返回的数据
        Map<String, Object> result = new HashMap<>();
        result.put("user", user);
        result.put("rank", rank);
        result.put("globalRanking", globalRanking);

        // 返回数据
        return CommonResult.success(result);
    }

    // 实现分数更新
    @Override
    public CommonResult<?> updateScore(String username, int score) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        User user = userMapper.selectOne(queryWrapper);

        if (user == null) {
            return CommonResult.error("用户不存在");
        }

        user.setScore(score);
        int result = userMapper.updateById(user);

        if (result > 0) {
            return CommonResult.success("分数更新成功");
        } else {
            return CommonResult.error("分数更新失败");
        }
    }
}
