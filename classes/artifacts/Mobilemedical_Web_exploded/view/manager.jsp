<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理界面&nbsp;-&nbsp;移动医疗监护系统</title>
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="/resources/style.css">
    <link rel="stylesheet" type="text/css" href="/resources/menu/menu.css">
    <script type="text/javascript" src="/resources/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="/resources/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/resources/easyui/easyloader.js"></script>
    <script type="text/javascript" src="/resources/easyui/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="/resources/global.js"></script>

</head>
<body class="easyui-layout"  >
    <div data-options="region:'north',border:false" style="height:80px;overflow: hidden;">

        <div class="tools fr clear" style="display: block;">
            【${userinfo.username}】&nbsp;&nbsp;<a href="/welcome/loginout.action">退出</a>
        </div>


    </div>
    <div data-options="region:'south',border:false" style="height:50px;">
        <div class="footer">
            技术支持： <b><a href=Bypt.com target=_blank>无锡北邮</a></b> &copy;2013-2013 &nbsp;<a href=
                                                                                                  target=_blank>Bypt.com</a>	</div>
    </div>
    <div data-options="region:'west',split:true" style="width:200px;">
        <div class="easyui-accordion" data-options="fit:true,border:false">
            <div title="人员组织" style="padding:10px;">
                <ul class="easyui-tree" id="manager_userinfo" data-options="url:'/userinfo/getUserTree.action',method:'get',lines:true"></ul>
            </div>
            <div title="系统设置" >
                <div class="menubar">
                    <ul>
                        <li><a href="javascript:tabUrl('人员管理','/userinfo/index.action')">人员管理</a></li>
                        <li><a href="javascript:tabUrl('组织管理','/usergroup/index.action')" >组织管理</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div data-options="region:'center'">
        <div class="easyui-tabs" id="globaltab" data-options="fit:true,border:false,plain:true">
            <div title="地图" id="mapContainer" class="easyui-layout"  >
                <div style="padding:5px;border:1px solid #ddd">
                    <a href="#" class="easyui-menubutton" data-options="menu:'#mm1',plain:true">查看人员轨迹</a>
                    <div id="mm1" style="width:150px;">
                        <div data-options="iconCls:'icon-line'" onclick="line_today()" >今日轨迹</div>
                        <div data-options="iconCls:'icon-line'" onclick="line_month()">月轨迹</div>
                    </div>
                </div>
                <div id="map" style="height: 100%;" ></div>
            </div>
        </div>
    </div>
    <script  src="http://api.map.baidu.com/api?v=15&key=7b9e5c6b8d6719e8309fd5abb63096c9" type="text/javascript"></script>
    <script>
       var manager_user;
       var map;
       function layoutMap(){
           map = new BMap.Map("map");          // 创建地图实例
           map.centerAndZoom("全国",5);
           map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
           map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
           map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用

           map.addControl(new BMap.MapTypeControl({anchor: BMAP_ANCHOR_TOP_RIGHT}));    //左上角，默认地图控件


       }
       $(function(){

           /*
            <div data-options="region:'center',border:false" >
            <div id="map" style="height: 100%;" ></div>
            </div>
           */
           layoutMap();

           $('#manager_userinfo').tree({
               onClick: function(node){
                   manager_user = node;
               }
           });


       });
       function line_today(){
          if(typeof(manager_user)!="undefined"&&manager_user.iconCls == 'icon-person'){
              $.get('../userpoint/getPoints.action',{type:'today',start:'',end:'',userid:manager_user.id},function(res){
                  viewLines(res);
              },'json');
          }else{
              $.messager.alert('提示','请选择人员！');
          }
       }
       function line_month(){
           if(manager_user.iconCls == 'icon-person'){
               $.get('../userpoint/getPoints.action',{type:'month',start:'',end:'',userid:manager_user.id},function(res){
                   viewLines(res);
               },'json');
           }else{
               $.messager.alert('提示','请选择人员！');
           }
       }
       function viewLines(res){
           map.clearOverlays();
           var pointArray = new Array();
           if(res.length>0){
               var fp;
               var lp;
               for(var i=0;i<res.length;i++){
                   var p = res[i].pointinfo.split(',');
                   if(i==0){
                       fp = new BMap.Point(p[0],p[1]);
                   }
                   if(i==res.length-1){
                       lp = new BMap.Point(p[0],p[1]);
                   }
                   pointArray.push(new BMap.Point(p[0],p[1]));
               }
               var polyline = new BMap.Polyline(pointArray, {strokeColor:"red", strokeWeight:3, strokeOpacity:0.5});
               map.addOverlay(polyline);
               map.centerAndZoom(fp, 15);

               var opts = {
                   position : fp,    // 指定文本标注所在的地理位置
                   offset   : new BMap.Size(0,0)    //设置文本偏移量

               }
               var label = new BMap.Label("起点", opts);  // 创建文本标注对象
               map.addOverlay(label);

               var opts = {
                   position : lp,    // 指定文本标注所在的地理位置
                   offset   : new BMap.Size(5, -5)    //设置文本偏移量

               }
               var label = new BMap.Label("终点", opts);  // 创建文本标注对象
               map.addOverlay(label);

           }
       }
    </script>
</body>
</html>
