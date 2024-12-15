package com.yexuhang.moneyup.service.impl;

import com.yexuhang.moneyup.bean.Category;
import com.yexuhang.moneyup.mapper.CategoryMapper;
import com.yexuhang.moneyup.service.CategoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 收支分类 服务实现类
 * </p>
 *
 * @author Xuhang Ye
 * @since 2024-11-27
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {

}
