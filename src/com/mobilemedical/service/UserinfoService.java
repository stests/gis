package com.mobilemedical.service;

import com.mobilemedical.mapper.UserinfoMapper;
import com.mobilemedical.model.Userinfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * User: zhujun
 * Date: 13-7-9
 * Time: 上午10:48
 */
@Service
public class UserinfoService {

    @Autowired
    UserinfoMapper userinfoMapper;

    public Userinfo findByIdCode(String idcode) {
        return userinfoMapper.findByIdCode(idcode);
    }

    public int selectTotal() {
        return userinfoMapper.selectTotal();
    }

    public List selectList(int page, int rows) {
        int start = (page-1)*rows;
        return userinfoMapper.selectList(start,rows);
    }

    public void updateStatus(int id, int status) {
        userinfoMapper.updateStatus(id,status);
    }

    public void updateUserinfo(Userinfo userinfo) {
        userinfoMapper.updateByPrimaryKeySelective(userinfo);
    }

    public void insertUserinfo(Userinfo userinfo) {
        userinfoMapper.insert(userinfo);
    }

    public List<Userinfo> getByGroupid(Integer usergroupId) {
        return userinfoMapper.getByGroupid(usergroupId);
    }
}
