package com.mobilemedical.action;

import com.alibaba.fastjson.JSON;
import com.mobilemedical.bean.Datagrid;
import com.mobilemedical.bean.Message;
import com.mobilemedical.bean.Tree;
import com.mobilemedical.model.Usergroup;
import com.mobilemedical.model.Userinfo;
import com.mobilemedical.service.UsergroupService;
import com.mobilemedical.service.UserinfoService;
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
@RequestMapping(value = "userinfo")
public class UserinfoController {

    @Autowired
    UserinfoService userinfoService;
    @Autowired
    UsergroupService usergroupService;

    @RequestMapping(value = "/index.action", method = RequestMethod.GET)
    public String index(){

        return "view/userinfo/index";
    }

    @RequestMapping(value = "/list.action", method = RequestMethod.POST)
    @ResponseBody
    public String list(int page,int rows){

        Datagrid datagrid = new Datagrid();

        int total = userinfoService.selectTotal();
        List records = userinfoService.selectList(page,rows);

        datagrid.setTotal(total);
        datagrid.setRows(records);

        return JSON.toJSONString(datagrid);
    }

    @RequestMapping(value = "/delete.action", method = RequestMethod.GET)
    @ResponseBody
    public String delete(int id){

        userinfoService.updateStatus(id,1);

        Message message = new Message();
        message.setType(true);

        return JSON.toJSONString(message);
    }

    @RequestMapping(value = "/edit.action", method = RequestMethod.POST)
    @ResponseBody
    public String edit(Userinfo userinfo){

        if(userinfo.getUserinfoId()!=null){
            //修改
            userinfoService.updateUserinfo(userinfo);
        }else{
            //添加
            userinfoService.insertUserinfo(userinfo);
        }
        Message msg = new Message();
        msg.setType(true);

        return JSON.toJSONString(msg);
    }

    @RequestMapping(value = "/getUserTree.action", method = RequestMethod.GET)
    @ResponseBody
    public String getUserTree(){

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
                //添加人员
                List<Userinfo> userinfos = userinfoService.getByGroupid(usergroups.get(i).getUsergroupId());
                if(userinfos.size()>0){
                    for(int j=0;j<userinfos.size();j++){
                        Tree u = new Tree();
                        u.setId(userinfos.get(j).getUserinfoId());
                        u.setText(userinfos.get(j).getUsername());
                        u.setIconCls("icon-person");
                        u.setAttributes(userinfos.get(j));
                        tree.getChildren().add(u);
                    }
                }
                setTree(tree,usergroups);
                root.getChildren().add(tree);
            }

        }
    }

}
