package com.yexuhang.moneyup.controller;

import com.yexuhang.moneyup.bean.Record;
import com.yexuhang.moneyup.config.CommonResult;
import com.yexuhang.moneyup.service.RecordService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 账单表 前端控制器
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-11-29
 */
@Slf4j
@RestController
@RequestMapping("/record")
@CrossOrigin(origins = "*")
public class RecordController {
    @Autowired
    private RecordService recordService;

    // 添加账单
    @PostMapping("/add")
    public CommonResult<?> addRecord(@RequestBody Record record) {
        log.info("Add record: {}", record);
        return recordService.addRecord(record);
    }

    // 删除账单
    @DeleteMapping("/delete/{id}")
    public CommonResult<?> deleteRecord(@PathVariable Integer id) {
        log.info("Delete record with id: {}", id);
        return recordService.deleteRecord(id);
    }

    // 查询用户账单
    @GetMapping("/list/{username}")
    public CommonResult<?> getRecordList(@PathVariable String username) {
        log.info("Get record list of user: {}", username);
        return recordService.getRecordList(username);
    }
}
