package com.qf.oa.service.impl;

import com.qf.oa.dao.RoleMapper;
import com.qf.oa.entity.Role;
import com.qf.oa.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/3 16:13
 * @Version 1.0
 */
@Service
public class RoleServiceImpl implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Role> queryAll() {
        return roleMapper.queryAll();
    }

    @Override
    public List<Role> queryAllByEid(Integer eid) {
        return roleMapper.queryAllByEid(eid);
    }

    @Override
    public int saveOrUpdate(Role role) {
        if (role.getId() != null) {
            return roleMapper.updateByPrimaryKeySelective(role);
        } else {
            return roleMapper.insertSelective(role);
        }
    }

    @Override
    public int delete(Integer id) {
        return roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    @Transactional
    public int updateResc(Integer rid, Integer[] reids) {
        // 删除角色与权限的关系
        roleMapper.deleteRescByRid(rid);
        // 添加角色权限
        roleMapper.addRoleResc(rid,reids);
        return 1;
    }
}
