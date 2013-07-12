<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../include.jsp"%>
<table class="easyui-datagrid" id="userinfo_index_list"  data-options="rownumbers:true,singleSelect:true,url:'/userinfo/list.action',fitColumns:true,fit:true,toolbar:'#userinfo_tbar',pagination:true,pageSize:10,border:false,idField:'userinfoId'">
    <thead>
    <tr>
        <th data-options="field:'idcode',width:10">身份证号</th>
        <th data-options="field:'username',width:10">用户名</th>
        <th data-options="field:'sex',width:10,formatter:userinfo_index_formatsex">性别</th>
        <th data-options="field:'isadmin',width:10,formatter:userinfo_index_formatisadmin">管理员</th>
    </tr>
    </thead>
</table>
<div id="userinfo_tbar" >
    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="userinfo_index_adduser()">添加人员</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="userinfo_index_edituser()">修改人员</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-del" plain="true" onclick="userinfo_index_deleteuser()">删除人员</a>
</div>
<div class="hid">
    <div id="userinfo_index_win_edit" class="easyui-window " style="width:600px;height:370px"
         data-options="iconCls:'icon-edit',<%=win_params%>">
        <div class="easyui-layout" data-options="fit:true,border:false">
            <div data-options="region:'south',border:false" style="text-align:right;padding:5px 5px 5px 0;height: 35px;border-top:1px solid #95B8E7;">
                <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="userinfo_index_edituser_do()">编辑</a>&nbsp;&nbsp;<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="userinfo_index_cancelWindow()">取消</a>
            </div>
            <div data-options="region:'center',border:false">
                <form id="userinfo_index_form" method="post" action="userinfo/edit.action" >
                    <input type="hidden" name="userinfoId" />
                    <table class="formtab">
                        <tr>
                            <td class="label">身份证号：</td><td><input class="text easyui-validatebox" name="idcode" type="text" data-options="required:true" /></td>
                            <td class="label">密码：</td><td><input class="text easyui-validatebox" name="password" type="text" data-options="required:true"/></td>
                        </tr>
                        <tr>
                            <td class="label">姓名：</td><td><input class="text easyui-validatebox" type="text" name="username" data-options="required:true" /></td>
                            <td class="label">性别：</td><td><select class="text" name="sex"><option value="1">男</option><option value="0">女</option></select></td>
                        </tr>
                        <tr>
                            <td class="label">组织：</td><td>
                            <select  name="usergroupId" class="easyui-combotree text"
                                    data-options="url:'/usergroup/getJson.action',required:true,method:'get',lines:true" style="width:160px;" ></select>
                            </td>
                            <td class="label">管理员：</td><td><input name="isadmin" value="1" type="checkbox"/></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>

    </div>

</div>
<script>
function userinfo_index_cancelWindow(){
     $("#userinfo_index_win_edit").window("close");
}

function userinfo_index_formatsex(val,row){
     if(val==1){
         return "男";
     }
     return "女";
}
function userinfo_index_formatisadmin(val,row){
    if(val==1){
        return "是";
    }
    return "否";
}
function userinfo_index_adduser(){
    $("#userinfo_index_win_edit").window({title:'添加人员',onClose:function(){
        $("#userinfo_index_form").form("clear");
    }});
    $("#userinfo_index_win_edit").window("open");
}
function userinfo_index_edituser(){
    var select =  $("#userinfo_index_list").datagrid("getSelected");
    if(select!=null){
        $("#userinfo_index_win_edit").window({title:'编辑人员',onClose:function(){
            $("#userinfo_index_form").form("clear");
        }});
        $("#userinfo_index_win_edit").window("open");


        $("#userinfo_index_form").form({
            onLoadSuccess:function(){
                if(select.isadmin==1){
                    $("#userinfo_index_form").find("input[name='isadmin']").attr("checked","checked");
                }
            }
        });
        $("#userinfo_index_form").form("load",select);

    }else{
        $.messager.alert('提示','请选择一条记录！');
    }
}
function userinfo_index_edituser_do(){
    $('#userinfo_index_form').form('submit', {
        url:"/userinfo/edit.action",
        onSubmit: function(){
            if($('#userinfo_index_form').form("validate")){
                return true;
            }
            return false;
        },
        success:function(data){
            var data = eval('(' + data + ')');
            if(data.type == true){
                $("#userinfo_index_list").datagrid("reload");
                $("#userinfo_index_win_edit").window("close");
            }
        }
    });

}
function userinfo_index_deleteuser(){
    var select =  $("#userinfo_index_list").datagrid("getSelected");
    if(select!=null){
        $.messager.confirm('提示','确定删除人员？',function(r){
            if (r){
                $.get('/userinfo/delete.action',{id:select.attributes.userinfoId},function(res){
                    if(res.type == true){
                        $("#userinfo_index_list").datagrid("reload");
                    }
                },'json');
            }
        });
    }else{
        $.messager.alert('提示','请选择一条记录！');
    }
}
</script>
