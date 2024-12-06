package com.yexuhang.harmony_lab;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author  Xuhang Ye
 */
@SpringBootApplication
@MapperScan("com.yexuhang.harmony_lab.mapper")
public class HarmonyLabApplication {

    public static void main(String[] args) {
        SpringApplication.run(HarmonyLabApplication.class, args);
    }

}
