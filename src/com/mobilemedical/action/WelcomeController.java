package com.mobilemedical.action;

import com.mobilemedical.bean.Message;
import com.mobilemedical.model.Userinfo;
import com.mobilemedical.service.UserinfoService;
import com.mobilemedical.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * zhujun
 * Date: 13-7-9
 * Time: 上午10:33
 */
@Controller
@RequestMapping(value = "welcome")
@SessionAttributes({Constant.USERINFO})
public class WelcomeController {

    @Autowired
    UserinfoService userinfoService;

    @RequestMapping(value = "/login.action", method = RequestMethod.POST)
    public String login(Userinfo userinfo, HttpSession session,HttpServletRequest request,ModelMap modelMap) {

        Message message = new Message();
        Userinfo exist = userinfoService.findByIdCode(userinfo.getIdcode());
        if(exist!=null){
           if(exist.getPassword().equals(userinfo.getPassword())){
               modelMap.addAttribute(Constant.USERINFO,exist);
               return "redirect:/welcome/manager.action";
           }else{
               //密码错误
               message.setType(false);
               message.setTitle("提示");
               message.setMessage("密码错误");
               message.setDescription("<a href='/'>返回登入界面</a>");
           }
        }else{
           //用户名不存在
            message.setType(false);
            message.setTitle("提示");
            message.setMessage("用户名不存在");
            message.setDescription("<a href='/'>返回登入界面</a>");
        }
        modelMap.addAttribute("message",message);
        return "html";
    }

    @RequestMapping(value = "/manager.action", method = RequestMethod.GET)
    public String  manager(@ModelAttribute(Constant.USERINFO) Userinfo userinfo,ModelMap modelMap){

        return "view/manager";
    }

    @RequestMapping(value = "/loginout.action", method = RequestMethod.GET)
    public String loginout(@ModelAttribute(Constant.USERINFO) Userinfo userinfo,SessionStatus status,ModelMap modelMap){

        status.setComplete();
        modelMap.remove(Constant.USERINFO);

        return "redirect:/";
    }

    @RequestMapping(value = "/map.action", method = RequestMethod.GET)
    public String map(){
        return "view/map";
    }


}
