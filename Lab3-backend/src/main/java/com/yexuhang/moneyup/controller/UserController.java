package com.yexuhang.moneyup.controller;

import com.yexuhang.moneyup.DTO.ChangePwDTO;
import com.yexuhang.moneyup.DTO.RegisterDTO;
import com.yexuhang.moneyup.bean.User;
import com.yexuhang.moneyup.config.CommonResult;
import com.yexuhang.moneyup.service.UserService;
import javafx.util.converter.LocalDateStringConverter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-11-27
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

    // 修改密码接口
    @PostMapping("/changePassword")
    public CommonResult<?> changePassword(@RequestBody ChangePwDTO changePwDTO) {
        String username = changePwDTO.getUsername();
        String oldPassword = changePwDTO.getOldPassword();
        String newPassword1 = changePwDTO.getNewPassword1();
        String newPassword2 = changePwDTO.getNewPassword2();

        log.info("Change password attempt with username: {}", username);

        return userService.changePassword(username, oldPassword, newPassword1, newPassword2, LocalDateTime.now());
    }
}
