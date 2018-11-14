package com.qf.oa.service;

import com.qf.oa.entity.Resc;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/4 14:04
 * @Version 1.0
 */
public interface IRescService {

    List<Resc> queryAll();

    int saveOrUpdate(Resc resc);

    int delete(Integer id);

    List<Resc> queryAllByRid(Integer rid);
}
