package com.qf.oa.service.impl;

import com.qf.oa.dao.EmployeeMapper;
import com.qf.oa.dao.RoleMapper;
import com.qf.oa.entity.Employee;
import com.qf.oa.entity.Role;
import com.qf.oa.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/2 13:57
 * @Version 1.0
 */
@Service
public class
EmpServiceImpl implements IEmpService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Employee> queryAll() {
        return employeeMapper.queryAll();
    }

    @Override
    public int saveOrUpdate(Employee employee) {
        if (employee.getId() != null) {
            return employeeMapper.updateByPrimaryKeySelective(employee);
        } else {
            return employeeMapper.insertSelective(employee);
        }
    }

    @Override
    public int delete(Integer id) {
        return employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 修改员工的角色信息
     *
     * @param eid
     * @param rids
     * @return
     */
    @Override
    @Transactional
    public int updateRoleInfo(Integer eid, Integer[] rids) {
        // 根据id，去中间表中删除所有和角色的关联
        employeeMapper.deleteEmpAndRole(eid);

        // 添加新的角色关联
        employeeMapper.addEmpAndRole(eid,rids);
        return 1;
    }


    @Override
    public List<Role> queryRoleByEid(Integer eid) {
        return  roleMapper.queryRoleByEid(eid);
    }

    @Override
    public Employee login(String email, String password) {
        return employeeMapper.login(email,password);
    }

    @Override
    public Employee queryByEmail(String email) {
        return employeeMapper.queryByEmail(email);
    }

    @Override
    public List<Employee> queryEmpInfo(String keyword,Integer eid) {
        return employeeMapper.queryEmpInfo(keyword,eid);
    }

    @Override
    public List<Employee> sexCount() {
        return employeeMapper.sexCount();
    }
}
