package com.mobilemedical.action;

import com.alibaba.fastjson.JSON;
import com.mobilemedical.bean.Message;
import com.mobilemedical.bean.Tree;
import com.mobilemedical.model.Usergroup;
import com.mobilemedical.service.UsergroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * User: zhujun
 * Date: 13-7-10
 * Time: 上午9:22
 */
@Controller
@RequestMapping(value = "usergroup")
public class UsergroupController {

    @Autowired
    UsergroupService usergroupService;

    @RequestMapping(value = "/index.action", method = RequestMethod.GET)
    public String index(){

        return "view/usergroup/index";
    }

    @RequestMapping(value = "/getJson.action", method = RequestMethod.GET)
    @ResponseBody
    public String getJson(){

        List<Usergroup> usergroups = usergroupService.getAll();
        List<Tree> treeList = new ArrayList<Tree>();

        for(int i=0;i<usergroups.size();i++){
            if(usergroups.get(i).getParentid()==-1){
                Tree t = new Tree();
                t.setId(usergroups.get(i).getUsergroupId());
                t.setText(usergroups.get(i).getGroupname());
                t.setIconCls("icon-group");
                t.setAttributes(usergroups.get(i));
                setTree(t, usergroups);
                treeList.add(t);
            }
        }

        return JSON.toJSONString(treeList);
    }

    private void setTree(Tree root, List<Usergroup> usergroups) {
       for(int i=0;i<usergroups.size();i++){
           if(root.getId() == usergroups.get(i).getParentid()){
               Tree tree = new Tree();
               tree.setId(usergroups.get(i).getUsergroupId());
               tree.setText(usergroups.get(i).getGroupname());
               tree.setIconCls("icon-group");
               tree.setAttributes(usergroups.get(i));
               setTree(tree,usergroups);
               root.getChildren().add(tree);
           }
       }
    }


    @RequestMapping(value = "/edit.action", method = RequestMethod.POST)
    @ResponseBody
    public String edit(Usergroup usergroup){
        if(usergroup.getUsergroupId()!=null){
            //修改
            usergroupService.updateUsergroup(usergroup);
        }else{
            //添加
            usergroup.setDeleted(0);
            usergroupService.insertUsergroup(usergroup);
        }
        Message msg = new Message();
        msg.setType(true);
        return JSON.toJSONString(msg);
    }

    @RequestMapping(value = "/delete.action", method = RequestMethod.GET)
    @ResponseBody
    public String delete(int id){

        usergroupService.updateUsergroupStatus(id,1);

        Message msg = new Message();
        msg.setType(true);
        return JSON.toJSONString(msg);
    }

}
