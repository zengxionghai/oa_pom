package com.qf.oa.service.impl;

import com.qf.oa.dao.DepartmentMapper;
import com.qf.oa.entity.Department;
import com.qf.oa.service.IDepService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/1 17:41
 * @Version 1.0
 */
@Service
public class DepServiceImpl implements IDepService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> queryAll() {
        return departmentMapper.qureyAll();
    }

    @Override
    public int saveOrUpdate(Department department) {
        if (department.getId() != null) {
            return departmentMapper.updateByPrimaryKeySelective(department);
        } else {
            return departmentMapper.insertSelective(department);
        }
    }

    @Override
    public int delete(Integer id) {
        return departmentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Department> numConut() {
        return departmentMapper.numCount();
    }

    @Override
    public int batchAdd(List<Department> temp) {
        return departmentMapper.batchAdd(temp);
    }

}
