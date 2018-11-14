package com.qf.oa.service;

import com.qf.oa.entity.Department;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/1 17:41
 * @Version 1.0
 */
public interface IDepService {

    List<Department> queryAll();

    int saveOrUpdate(Department department);

    int delete(Integer id);

    List<Department> numConut();

    int batchAdd(List<Department> temp);
}
