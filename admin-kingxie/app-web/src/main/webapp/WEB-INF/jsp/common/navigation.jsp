<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/3
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="tag.jsp"%>
<!-- 导航栏 -->
<div class="navbar-custom-menu">
    <ul class="nav navbar-nav">
        <!-- Messages: style can be found in dropdown.less-->
        <li class="dropdown messages-menu">
            <!-- Menu toggle button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-envelope-o"></i>
                <span class="label label-success">4</span>
            </a>
            <ul class="dropdown-menu">
                <li class="header">您有4条信息未查看</li>
                <li>
                    <!-- inner menu: contains the messages -->
                    <ul class="menu">
                        <li><!-- start message -->
                            <a href="#">
                                <div class="pull-left">
                                    <!-- User Image -->
                                    <img src="${ctx}/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                                </div>
                                <!-- Message title and timestamp -->
                                <h4>
                                    支持团队
                                    <small><i class="fa fa-clock-o"></i> 5 mins</small>
                                </h4>
                                <!-- The message -->
                                <p>为什么不给我买?</p>
                            </a>
                        </li>
                        <!-- end message -->
                    </ul>
                    <!-- /.menu -->
                </li>
                <li class="footer"><a href="#">查看所有消息</a></li>
            </ul>
        </li>
        <!-- /.messages-menu -->

        <!-- Notifications Menu -->
        <li class="dropdown notifications-menu">
            <!-- Menu toggle button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-bell-o"></i>
                <span class="label label-warning">10</span>
            </a>
            <ul class="dropdown-menu">
                <li class="header">您有10条通知未查看</li>
                <li>
                    <!-- Inner Menu: contains the notifications -->
                    <ul class="menu">
                        <li><!-- start notification -->
                            <a href="#">
                                <i class="fa fa-users text-aqua"></i> 今天有5位新成员加入
                            </a>
                        </li>
                        <!-- end notification -->
                    </ul>
                </li>
                <li class="footer"><a href="#">查看所有</a></li>
            </ul>
        </li>
        <!-- Tasks Menu -->
        <li class="dropdown tasks-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-flag-o"></i>
                <span class="label label-danger">9</span>
            </a>
            <ul class="dropdown-menu">
                <li class="header">您有9条任务未处理</li>
                <li>
                    <!-- Inner menu: contains the tasks -->
                    <ul class="menu">
                        <li><!-- Task item -->
                            <a href="#">
                                <!-- Task title and progress text -->
                                <h3>
                                    设计一些按钮
                                    <small class="pull-right">20%</small>
                                </h3>
                                <!-- The progress bar -->
                                <div class="progress xs">
                                    <!-- Change the css width attribute to simulate progress -->
                                    <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                        <span class="sr-only">20% 完成</span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <!-- end task item -->
                    </ul>
                </li>
                <li class="footer">
                    <a href="#">查看所有任务</a>
                </li>
            </ul>
        </li>
        <!-- User Account Menu -->
        <li class="dropdown user user-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <!-- The user image in the navbar-->
                <img src="${ctx}/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
                <!-- hidden-xs hides the username on small devices so only the image appears. -->
                <span class="hidden-xs">${user.userName}</span>
            </a>
            <ul class="dropdown-menu">
                <!-- The user image in the menu -->
                <li class="user-header">
                    <img src="${ctx}/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">

                    <p>
                        kingxie - Web开发工程师
                        <small>2012年10月加入</small>
                    </p>
                </li>
                <!-- Menu Body -->
                <li class="user-body">
                    <div class="row">
                        <div class="col-xs-4 text-center">
                            <a href="#">粉丝</a>
                        </div>
                        <div class="col-xs-4 text-center">
                            <a href="#">销售的</a>
                        </div>
                        <div class="col-xs-4 text-center">
                            <a href="#">朋友</a>
                        </div>
                    </div>
                    <!-- /.row -->
                </li>
                <!-- Menu Footer-->
                <li class="user-footer">
                    <div class="pull-left">
                        <a href="#" class="btn btn-default btn-flat">个人设置</a>
                    </div>
                    <div class="pull-right">
                        <a href="#" class="btn btn-default btn-flat">登出</a>
                    </div>
                </li>
            </ul>
        </li>
        <!-- Control Sidebar Toggle Button -->
        <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
        </li>
    </ul>
</div>
