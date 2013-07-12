package com.mobilemedical.service;

import com.mobilemedical.mapper.UsergroupMapper;
import com.mobilemedical.model.Usergroup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * User: zhujun
 * Date: 13-7-11
 * Time: 上午11:09
 */
@Service
public class UsergroupService {

    @Autowired
    UsergroupMapper usergroupMapper;

    public List<Usergroup> getAll() {
        return usergroupMapper.getAll();
    }

    public void updateUsergroup(Usergroup usergroup) {
        usergroupMapper.updateByPrimaryKeySelective(usergroup);
    }

    public void insertUsergroup(Usergroup usergroup) {
        usergroupMapper.insert(usergroup);
    }

    public void deleteUsergroup(int id) {
        usergroupMapper.deleteByPrimaryKey(id);
    }

    public void updateUsergroupStatus(int id, int delete) {
        Usergroup usergroup = new Usergroup();
        usergroup.setUsergroupId(id);
        usergroup.setDeleted(delete);
        usergroupMapper.updateByPrimaryKeySelective(usergroup);
    }
}
