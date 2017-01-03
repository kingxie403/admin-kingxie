<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/3
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="tag.jsp" %>
<!-- 菜单栏-->
<div class="user-panel">
    <div class="pull-left image">
        <img src="${ctx}/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
    </div>
    <div class="pull-left info">
        <p>${user.userName}</p>
        <!-- Status -->
        <a href="#"><i class="fa fa-circle text-success"></i> 在线</a>
    </div>
</div>

<!-- search form (Optional) -->
<form action="#" method="get" class="sidebar-form">
    <div class="input-group">
        <input type="text" name="q" class="form-control" placeholder="搜索...">
        <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
    </div>
</form>
<!-- /.search form -->

<!-- Sidebar Menu -->
<ul class="sidebar-menu">
    <li class="header">系统管理</li>
    <!-- Optionally, you can add icons to the links -->
    <%--<li class="treeview">
        <a href="#"><i class="fa fa-link"></i> <span>系统管理</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
        </a>
        <ul class="treeview-menu">
            <li class="active"><a
                    href="javascript:closableTab.addTab({'id':'2','name':'用户管理','url':'${ctx}/user/manager','closable':true});"><i
                    class="fa fa-link"></i> <span>用户管理</span></a></li>
            <li class="active"><a
                    href="javascript:closableTab.addTab({'id':'3','name':'组织管理','url':'${ctx}/user/group/manager','closable':true});"><i
                    class="fa fa-link"></i> <span>组织管理</span></a></li>
            <li>
                <a href="javascript:closableTab.addTab({'id':'4','name':'角色管理','url':'${ctx}/role/manager','closable':true});"><i
                        class="fa fa-link"></i> <span>角色管理</span></a></li>
            <li>
                <a href="javascript:closableTab.addTab({'id':'5','name':'权限管理','url':'${ctx}/privilege/manager','closable':true});"><i
                        class="fa fa-link"></i> <span>权限管理</span></a></li>
            <li>
                <a href="javascript:closableTab.addTab({'id':'6','name':'菜单管理','url':'${ctx}/menu/manager','closable':true});"><i
                        class="fa fa-link"></i> <span>菜单管理</span></a></li>
            <li>
                <a href="javascript:closableTab.addTab({'id':'7','name':'数据字典管理','url':'${ctx}/dicType/manager','closable':true});"><i
                        class="fa fa-link"></i> <span>数据字典管理</span></a></li>
        </ul>
    </li>--%>
</ul>

<script type="text/javascript">
    var menuList=[];
    function loadMenu() {
        $.ajax({
            type: "POST",
            url: '${ctx}/user/menu/all',
            dataType: "json",
            success:function (data) {
                menuList=data;
                for (var i=0;i<menuList.length;i++) {
                    if (menuList[i].menuParent == 0) {
                        build(menuList[i]);
                    }
                }
            },
            error:function (data) {
                alert(data);
            }
        });
    }

    function build(menu) {
        var children = getChildren(menu);
        var treeView="";
        var menuView="";
        if (children.length != 0 && menu.menuParent==0) {//顶级菜单，有子节点
            treeView='<li class="treeview">' +
                        '<a href="#"><i class="fa '+menu.menuIcon+'"></i><span>'+menu.menuName+'</span>' +
                        '<span class="pull-right-container">' +
                        '<i class="fa fa-angle-left pull-right">' +
                        '</i>' +
                        '</span>' +
                        '</a>' +
                        '<ul class="treeview-menu" id="ul-menu-'+menu.menuId+'"></ul>' +
                    '</li>';
            $(".sidebar-menu").append(treeView);
            //迭代子节点
            for (var i=0;i<children.length;i++) {
                var sub=getChildren(children[i]);
                if(sub.length == 0){
                    menuView='<li id="li-menu-'+children[i].menuId+'">' +
                                '<a href="javascript:closableTab.addTab({\'id\':\''+children[i].menuId+'\',\'name\':\''+children[i].menuName+'\',\'url\':\'${ctx}'+children[i].menuUrl+'\',\'closable\':true});">' +
                                    '<i class="fa '+children[i].menuIcon+'"></i><span>'+children[i].menuName+'</span>' +
                                '</a>' +
                            '</li>';
                }else{
                    menuView='<li id="li-menu-'+children[i].menuId+'">' +
                            '<a href="javascript:closableTab.addTab({\'id\':\''+children[i].menuId+'\',\'name\':\''+children[i].menuName+'\',\'url\':\'${ctx}'+children[i].menuUrl+'\',\'closable\':true});">' +
                            '<i class="fa '+children[i].menuIcon+'"></i><span>'+children[i].menuName+'</span>' +
                            '<span class="pull-right-container">' +
                            '<i class="fa fa-angle-left pull-right">' +
                            '</i>' +
                            '</span>' +
                            '</a>' +
                            '<ul class="treeview-menu" id="ul-menu-'+children[i].menuId+'"></ul>' +
                            '</li>';
                }
                $("#ul-menu-"+menu.menuId).append(menuView);
                build(children[i]);
            }
        }else if(children.length != 0 && menu.menuParent != 0){//非顶级菜单，有子节点
            for (var i=0;i<children.length;i++) {
                var sub=getChildren(children[i]);
                if(sub.length == 0){
                    menuView='<li class="active" id="li-menu-'+children[i].menuId+'">' +
                            '<a href="javascript:closableTab.addTab({\'id\':\''+children[i].menuId+'\',\'name\':\''+children[i].menuName+'\',\'url\':\'${ctx}'+children[i].menuUrl+'\',\'closable\':true});">' +
                            '<i class="fa '+children[i].menuIcon+'"></i><span>'+children[i].menuName+'</span>' +
                            '</a></li>';
                }else{
                    menuView='<li class="active" id="li-menu-'+children[i].menuId+'">' +
                            '<a href="javascript:closableTab.addTab({\'id\':\''+children[i].menuId+'\',\'name\':\''+children[i].menuName+'\',\'url\':\'${ctx}'+children[i].menuUrl+'\',\'closable\':true});">' +
                            '<i class="fa '+children[i].menuIcon+'"></i><span>'+children[i].menuName+'</span>' +
                            '<span class="pull-right-container">' +
                            '<i class="fa fa-angle-left pull-right">' +
                            '</i>' +
                            '</span>' +
                            '</a>' +
                            '<ul class="treeview-menu" id="ul-menu-'+children[i].menuId+'"></ul>' +
                            '</li>';
                }
                $("#ul-menu-"+children[i].menuParent).append(menuView);
                build(children[i]);
            }
        }else if(children.length ==0 && menu.menuParent !=0 ){//非顶级菜单,无子节点
            menuView = '<li><a href="#"><i class="fa '+menu.menuIcon+'"></i><span>'+menu.menuName+'</span></a></li>';
            $("#ul-menu-"+menu.menuId).append(menuView);
        }else if(children.length==0 && menu.menuParent==0){//顶级菜单，无子节点
            treeView='<li class="treeview" id="treeview">' +
                    '<a href="#">' +
                    '<i class="fa '+menu.menuIcon+'"></i> ' +
                    '<span>'+menu.menuName+'</span>' +
                    '<span class="pull-right-container">' +
                    '<i class="fa fa-angle-left pull-right">' +
                    '</i>' +
                    '</span>' +
                    '</a>' +
                    '<ul class="treeview-menu" id="ul-menu'+menu.menuId+'"></ul>' +
                    '</li>';
            $(".sidebar-menu").append(treeView);
        }
    }

    function getChildren(menu) {
        var children  = [];
        var mid = menu.menuId;
        var index=0;
        for(var i=0;i<menuList.length;i++){
            if(mid == menuList[i].menuParent){
                children[index]= menuList[i];
                index++;
            }
        }
        return children;
    }


    $(function () {
        loadMenu();
    });
</script>
