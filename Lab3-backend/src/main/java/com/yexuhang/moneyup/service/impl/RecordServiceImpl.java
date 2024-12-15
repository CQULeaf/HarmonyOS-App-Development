package com.yexuhang.moneyup.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yexuhang.moneyup.bean.Record;
import com.yexuhang.moneyup.config.CommonResult;
import com.yexuhang.moneyup.mapper.RecordMapper;
import com.yexuhang.moneyup.service.RecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 账单表 服务实现类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-11-29
 */
@Service
public class RecordServiceImpl extends ServiceImpl<RecordMapper, Record> implements RecordService {
    @Autowired
    private RecordMapper recordMapper;

    // 添加账单
    @Override
    public CommonResult<?> addRecord(Record record) {
        int result = recordMapper.insert(record);
        if (result > 0) {
            return CommonResult.success("添加成功", record);
        } else {
            return CommonResult.error("添加失败, 请稍后再试");
        }
    }

    // 删除账单
    @Override
    public CommonResult<?> deleteRecord(Integer id) {
        int result = recordMapper.deleteById(id);
        if (result > 0) {
            return CommonResult.success("删除成功", id);
        } else {
            return CommonResult.error("删除失败, 请稍后再试");
        }
    }

    // 查询用户账单
    @Override
    public CommonResult<?> getRecordList(String username) {
        List<Record> recordList = recordMapper.selectList(new QueryWrapper<Record>().eq("username", username));
        return CommonResult.success("查询成功", recordList);
    }
}
