package com.yexuhang.moneyup.DTO;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * @author Xuhang Ye
 * @time 11:41 AM
 */
@Data
public class ChangePwDTO {
    private String username;
    private String oldPassword;
    private String newPassword1;
    private String newPassword2;
    private LocalDateTime updateAt;
}