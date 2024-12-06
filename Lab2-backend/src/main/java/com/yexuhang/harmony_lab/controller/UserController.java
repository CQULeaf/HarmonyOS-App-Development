package com.yexuhang.harmony_lab.controller;

import com.yexuhang.harmony_lab.DTO.RegisterDTO;
import com.yexuhang.harmony_lab.bean.User;
import com.yexuhang.harmony_lab.config.CommonResult;
import com.yexuhang.harmony_lab.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 用户 前端控制器
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-10-18
 */
@RestController
@Slf4j
@RequestMapping("/user")
@CrossOrigin(origins = "*")
public class UserController {
    @Autowired
    private UserService userService;

    // 登录接口
    @PostMapping("/login")
    public CommonResult<?> login(@RequestBody User loginRequest) {
        String username = loginRequest.getUsername();
        String password = loginRequest.getPassword();

        log.info("Login attempt with username: {}", username);

        User result = userService.login(username, password);
        if (result != null) {
            log.info("User logged in successfully: {}", username);
            return CommonResult.success(result);
        } else {
            log.warn("Login failed for username: {}", username);
            return CommonResult.error("用户名或密码错误");
        }
    }


    // 注册接口
    @PostMapping("/register")
    public CommonResult<?> register(@RequestBody RegisterDTO registerDTO) {
        String username = registerDTO.getUsername();
        String password1 = registerDTO.getPassword1();
        String password2 = registerDTO.getPassword2();

        log.info("Register attempt with username: {}", username);

        return userService.register(username, password1, password2);
    }

    // 排名接口
    @GetMapping("/rank")
    public CommonResult<?> rank(@RequestParam String username) {
        log.info("Rank request for username: {}", username);

        return userService.rank(username);
    }

    // 更新分数接口
    @PostMapping("/updateScore")
    public CommonResult<?> updateScore(@RequestBody User user) {
        String username = user.getUsername();
        int score = user.getScore();

        log.info("Update score request for username: {}", username);

        return userService.updateScore(username, score);
    }
}
