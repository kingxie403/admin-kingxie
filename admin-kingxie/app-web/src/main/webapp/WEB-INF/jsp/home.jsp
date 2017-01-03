<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/3
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 2 | 首页</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <jsp:include page="common/head.jsp"/>
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <!-- Main Header -->
    <header class="main-header">

        <!-- Logo -->
        <a href="index2.html" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>A</b>LT</span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>Admin</b>LTE</span>
        </a>

        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <!-- Navbar Right Menu -->
            <jsp:include page="common/navigation.jsp"/>
        </nav>
    </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">

        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <jsp:include page="common/menu.jsp"/>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                页面标题
                <small>随意写点东西</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Your Page Content Here -->
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="nav-tabs-main">

                </ul>
                <div class="tab-content" id="nav-tabContent-main">

                </div>
                <!-- /.tab-content -->
            </div>
            <!-- nav-tabs-custom -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <footer class="main-footer">
        <jsp:include page="common/foot.jsp"/>
    </footer>

    <!-- Control Sidebar -->
    <jsp:include page="common/setting.jsp"/>
</div>
<!-- ./wrapper -->
<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. Slimscroll is required when using the
     fixed layout. -->
<script type="text/javascript">

    $(function(){
        var item = {'id':'1','name':'首页','url':'${ctx}/user/home','closable':false};
        closableTab.addTab(item);
    });

    var closableTab = {
        //frame加载完成后设置父容器的高度，使iframe页面与父页面无缝对接
        frameLoad:function (frame){
            var wh = $(".content-wrapper").height();
            $(frame).parent().height(wh);
        },

        //添加tab
        addTab:function(tabItem){ //tabItem = {id,name,url,closable}

            var id = "tab_seed_" + tabItem.id;
            var container ="tab_container_" + tabItem.id;

            $("li[id^=tab_seed_]").removeClass("active");
            $("div[id^=tab_container_]").removeClass("active");

            if(!$('#'+id)[0]){
                var li_tab = '<li role="presentation" class="" id="'+id+'"><a href="#'+container+'"  role="tab" data-toggle="tab" style="position: relative;padding:2px 20px 2px 15px">'+tabItem.name;
                if(tabItem.closable){
                    li_tab = li_tab + '<i class="glyphicon glyphicon-remove small" tabclose="'+id+'" style="position: absolute;right:4px;top: 4px;"  onclick="closableTab.closeTab(this)"></i></a></li> ';
                }else{
                    li_tab = li_tab + '</a></li>';
                }

                var tabpanel = '<div role="tabpanel" class="tab-pane" id="'+container+'" style="width: 100%;">'+
                        '<iframe src="'+tabItem.url+
                        '" id="tab_frame_'+tabItem.id+'"'
                        +' frameborder="0" style="overflow-x: hidden; overflow-y: hidden;width:100%;height: 100%"  ' +
                        'onload="closableTab.frameLoad(this)"></iframe>'+
                        '</div>';


                $('#nav-tabs-main').append(li_tab);
                $('#nav-tabContent-main').append(tabpanel);
            }
            $("#"+id).addClass("active");
            $("#"+container).addClass("active");
        },

        //关闭tab
        closeTab:function(item){
            var val = $(item).attr('tabclose');
            var containerId = "tab_container_"+val.substring(9);

            if($('#'+containerId).hasClass('active')){
                $('#'+val).prev().addClass('active');
                $('#'+containerId).prev().addClass('active');
            }

            $("#"+val).remove();
            $("#"+containerId).remove();
        }
    }

</script>
</body>
</html>
