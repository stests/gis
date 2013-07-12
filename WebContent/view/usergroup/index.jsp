<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="cc" class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'west',split:true,border:false" style="width:200px" class="p10">
        <ul class="easyui-tree" id="usergroup_index_tree" data-options="url:'/usergroup/getJson.action',required:true,method:'get',lines:true,
        onContextMenu: function(e,node){
				e.preventDefault();
				$(this).tree('select',node.target);
				$('#usergroup_index_mm').menu('show',{
					left: e.pageX,
					top: e.pageY
				});
			}
        "></ul>

        <div id="usergroup_index_mm" class="easyui-menu" style="width:120px;">
            <div onclick="usergroup_index_addTop()" data-options="iconCls:'icon-add'">添加顶级组织</div>
            <div onclick="usergroup_index_addItem()" data-options="iconCls:'icon-add'">添加下级组织</div>
            <div class="menu-sep"></div>
            <div onclick="usergroup_index_delete()" data-options="iconCls:'icon-del'">删除</div>
        </div>
    </div>
    <div data-options="region:'center',border:false" style="padding:10px;">
        <form id="usergroup_index_form" method="post" action="usergroup/edit.action" >
            <input type="hidden" name="usergroupId" />
            <table class="formtab">
                <tr>
                    <td class="label">上一级：</td>
                    <td><input class="text " name="parentText" type="text" readonly="readonly" />
                        <input type="hidden" name="parentid" />
                    </td>
                </tr>
                <tr>
                    <td class="label">组名：</td>
                    <td><input class="text easyui-validatebox" name="groupname" type="text" data-options="required:true" /></td>
                </tr>
            </table>
            <div class="dbar">
                <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="usergroup_index_edit()">编辑</a>
            </div>
        </form>
    </div>
</div>
<script>
    function usergroup_index_addTop(){
        $("#usergroup_index_form").form("clear");
        $("#usergroup_index_form").find("input[name=parentText]").val("根目录");
        $("#usergroup_index_form").find("input[name=parentid]").val(-1);
    }
    function usergroup_index_addItem(){
        var node = $('#usergroup_index_tree').tree('getSelected');
        $("#usergroup_index_form").find("input[name=parentText]").val(node.attributes.groupname);
        $("#usergroup_index_form").find("input[name=parentid]").val(node.attributes.usergroupId);
    }
    function usergroup_index_edit(){
        //编辑群组
        $('#usergroup_index_form').form('submit', {
            url:"/usergroup/edit.action",
            onSubmit: function(){
                if($('#usergroup_index_form').form("validate")){
                    return true;
                }
                return false;
            },
            success:function(data){
                var data = eval('(' + data + ')');
                if(data.type == true){
                    $("#usergroup_index_tree").tree("reload");
                    $("#usergroup_index_form").form("clear");
                }
            }
        });
    }
    function usergroup_index_delete(){
        //删除
        var node = $('#usergroup_index_tree').tree('getSelected');
        $.messager.confirm('提示','确定删除\"'+node.text+'\"？',function(r){
            if (r){
                $.get('/usergroup/delete.action',{id:node.attributes.usergroupId},function(r){
                    if(r.type == true){
                        $('#usergroup_index_tree').tree('remove', node.target);
                    }
                },'json');
            }
        });
    }
    $(function(){
        $('#usergroup_index_tree').tree({
            onClick: function(node){
                $("#usergroup_index_form").form("load",node.attributes);
                if(node.attributes.parentid == -1){
                    $("#usergroup_index_form").find("input[name=parentText]").val("根目录");
                }
            }
        });
    });
</script>