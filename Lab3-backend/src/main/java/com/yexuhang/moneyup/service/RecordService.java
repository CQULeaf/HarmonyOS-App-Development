package com.yexuhang.moneyup.service;

import com.yexuhang.moneyup.bean.Record;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yexuhang.moneyup.config.CommonResult;

/**
 * <p>
 * 账单表 服务类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-11-29
 */
public interface RecordService extends IService<Record> {

        // 添加账单
        CommonResult<?> addRecord(Record record);

        // 删除账单
        CommonResult<?> deleteRecord(Integer id);

        // 查询用户账单
        CommonResult<?> getRecordList(String username);
}
