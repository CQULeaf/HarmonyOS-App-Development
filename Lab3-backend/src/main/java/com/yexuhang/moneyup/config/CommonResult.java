package com.yexuhang.moneyup.config;

import lombok.Data;
import lombok.ToString;

/**
 * @author Xuhang Ye
 * @time 8:37 PM
 */
@Data
@ToString
public class CommonResult<T> {
    private Integer code;
    private String msg;
    private T data;

    // 全参构造方法
    public CommonResult(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    // 静态方法：成功返回，包含数据
    public static <T> CommonResult<T> success(T data) {
        return new CommonResult<>(200, "操作成功", data);
    }

    // 静态方法：成功返回，无数据
    public static <T> CommonResult<T> success(String msg) {
        return new CommonResult<>(200, msg, null);
    }

    // 静态方法：成功返回，自定义消息和数据
    public static <T> CommonResult<T> success(String msg, T data) {
        return new CommonResult<>(200, msg, data);
    }

    // 静态方法：错误返回，包含错误消息
    public static <T> CommonResult<T> error(int code, String msg) {
        return new CommonResult<>(code, msg, null);
    }

    // 静态方法：错误返回，包含错误消息和数据
    public static <T> CommonResult<T> error(int code, String msg, T data) {
        return new CommonResult<>(code, msg, data);
    }

    // 静态方法：默认错误返回，操作失败，无数据
    public static <T> CommonResult<T> error(String msg) {
        return new CommonResult<>(400, msg, null);
    }
}