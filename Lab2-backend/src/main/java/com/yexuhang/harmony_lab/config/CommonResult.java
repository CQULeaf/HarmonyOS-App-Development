package com.yexuhang.harmony_lab.config;

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

    public CommonResult(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public CommonResult(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static <T> CommonResult<T> success(T t) {
        return new CommonResult<T>(200, "操作成功", t);
    }

    public static <T> CommonResult<T> error(String t) {
        return (CommonResult<T>) new CommonResult<String>(400, "操作失败", t);
    }
}
