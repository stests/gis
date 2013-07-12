package com.mobilemedical.action;

import com.alibaba.fastjson.JSON;
import com.mobilemedical.model.Userinfo;
import com.mobilemedical.model.Userpoint;
import com.mobilemedical.service.UserpointService;
import com.mobilemedical.util.Constant;
import com.mobilemedical.util.time.TimeGet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * User: zhujun
 * Date: 13-7-10
 * Time: 上午9:23
 */
@Controller
@RequestMapping(value = "userpoint")
public class UserpointController {

    @Autowired
    UserpointService userpointService;

    @RequestMapping(value = "/getPoints.action", method = RequestMethod.GET)
    @ResponseBody
    public String getPoints(String type,String start,String end,int userid){
        List<Userpoint> userpoints = null;
        if(type.equals("today")){
           TimeGet tt = new TimeGet();
           userpoints = userpointService.getTodayPoints(userid,tt.getNowTime("yyyy-MM-dd"));
        }else if(type.equals("month")){
            TimeGet tt = new TimeGet();
            userpoints = userpointService.getPointsIn(userid,tt.getFirstDayOfMonth(),tt.getDefaultDay());
        }
        return JSON.toJSONString(userpoints);
    }

}
