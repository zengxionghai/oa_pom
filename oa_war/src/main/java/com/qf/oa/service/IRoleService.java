package com.qf.oa.service;

import com.qf.oa.entity.Role;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/3 16:08
 * @Version 1.0
 */
public interface IRoleService {

    List<Role> queryAll();

    List<Role> queryAllByEid(Integer eid);

    int saveOrUpdate(Role role);

    int delete(Integer id);

    int updateResc(Integer rid,Integer[] reids);

}
