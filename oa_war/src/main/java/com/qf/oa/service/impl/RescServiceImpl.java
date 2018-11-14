package com.qf.oa.service.impl;

import com.qf.oa.dao.RescMapper;
import com.qf.oa.entity.Resc;
import com.qf.oa.service.IRescService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/4 14:05
 * @Version 1.0
 */
@Service
public class RescServiceImpl implements IRescService {

    @Autowired
    private RescMapper rescMapper;

    @Override
    public List<Resc> queryAll() {
        return rescMapper.queryAll();
    }

    @Override
    public int saveOrUpdate(Resc resc) {
        if (resc.getId() != null) {
            return rescMapper.updateByPrimaryKeySelective(resc);
        } else {
            return rescMapper.insertSelective(resc);
        }
    }

    @Override
    public int delete(Integer id) {
        return rescMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Resc> queryAllByRid(Integer rid) {
        return rescMapper.queryAllByRid(rid);
    }


}
