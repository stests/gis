package com.mobilemedical.service;

import com.mobilemedical.mapper.UserpointMapper;
import com.mobilemedical.model.Userpoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * User: zhujun
 * Date: 13-7-12
 * Time: 上午10:34
 */
@Service
public class UserpointService {

    @Autowired
    UserpointMapper userpointMapper;


    public List<Userpoint> getTodayPoints(int userid,String today) {
        return userpointMapper.getTodayPoints(userid,today);
    }

    public List<Userpoint> getPointsIn(int userid,String start, String end) {
        return userpointMapper.getPointsIn(userid,start,end);
    }
}
