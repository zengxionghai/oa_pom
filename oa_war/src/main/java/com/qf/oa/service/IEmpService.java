package com.qf.oa.service;

import com.qf.oa.entity.Employee;
import com.qf.oa.entity.Role;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/2 13:52
 * @Version 1.0
 */
public interface IEmpService {

    List<Employee> queryAll();

    int saveOrUpdate(Employee employee);

    int delete(Integer id);

    int updateRoleInfo(Integer eid, Integer[] rids);

    List<Role> queryRoleByEid(Integer eid);

    Employee login(String email, String password);

    Employee queryByEmail(String email);

    List<Employee> queryEmpInfo(String keyword,Integer eid);

    List<Employee> sexCount();
}
