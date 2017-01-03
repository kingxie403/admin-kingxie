<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/4
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../common/tag.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <jsp:include page="../../common/head.jsp"/>
    <link rel="stylesheet" href="${ctx}/plugins/zTree/css/metroStyle/metroStyle.css">
    <script type="text/javascript" src="${ctx}/plugins/zTree/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/zTree/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/zTree/js/jquery.ztree.exedit.js"></script>
    <script type="text/javascript" src="${ctx}/bootstrap/js/bootstrap-paginator.min.js"></script>
    <style type="text/css">
        form {
            margin: 0 0 20px;
        }

        .pagination-centered {
            text-align: center;
        }

        .pagination {
            margin: 20px 0;
        }

        .pagination ul {
            border-radius: 4px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            display: inline-block;
            margin-bottom: 0;
            margin-left: 0;
        }

        ul, ol {
            margin: 0 0 10px 25px;
            padding: 0;
        }

        .pagination ul > li {
            display: inline;
        }

        li {
            line-height: 20px;
        }

        .pagination ul > li:first-child > a, .pagination ul > li:first-child > span {
            border-bottom-left-radius: 4px;
            border-left-width: 1px;
            border-top-left-radius: 4px;
        }

        .pagination ul > li:last-child > a, .pagination ul > li:last-child > span {
            border-bottom-right-radius: 4px;
            border-top-right-radius: 4px;
        }

        .pagination ul > li > a, .pagination ul > li > span {
            -moz-border-bottom-colors: none;
            -moz-border-left-colors: none;
            -moz-border-right-colors: none;
            -moz-border-top-colors: none;
            background-color: #fff;
            border-color: #ddd;
            border-image: none;
            border-style: solid;
            border-width: 1px 1px 1px 0;
            float: left;
            line-height: 20px;
            padding: 4px 12px;
            text-decoration: none;
            cursor: pointer;
        }

        .pagination ul > .active > a, .pagination ul > .active > span {
            color: #999;
            cursor: default;
        }

        .pagination ul > li > a:hover, .pagination ul > li > a:focus, .pagination ul > .active > a, .pagination ul > .active > span {
            background-color: #1d75b3;
        }
    </style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="box box-primary">
    <form role="form">
        <div class="box-body">
            <div class="form-group col-xs-5">
                <input id="queryUserName" type="text" name="userName" class="form-control" placeholder="输入用户名">
            </div>
            <div class="form-group col-xs-2">
                <button id="queryButton" type="button" class="btn btn-primary">查询</button>
            </div>
        </div>
    </form>
    <div class="box-header with-border">
        <h3 class="box-title">查询结果</h3>
    </div>
    <div class="box-pane">
        <table id="user-table" class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>序号</th>
                <th>用户名</th>
                <th>密码</th>
                <th>用户邮箱</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="tableBody"></tbody>

        </table>
    </div>
    <div class="box-footer">
        <div class="col-xs-8 col-xs-offset-4">
            <!-- 底部分页按钮 -->
            <div id="bottomTab"></div>
        </div>
    </div>
</div>
<%--用户编辑框 start--%>
<div id="user-edit-modal" class="modal modal-info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户编辑</h4>
            </div>
            <div class="modal-body">
                <form id="user-edit-form" role="form">
                    <div class="box-body">
                        <input id="user-edit-id" name="userId" type="hidden" class="form-control" >
                        <div class="form-group">
                            <label>用户名</label>
                            <input id="user-edit-userName" name="userName" type="text" class="form-control" disabled>
                        </div>
                        <div class="form-group">
                            <label>邮箱</label>
                            <input id="user-edit-email" name="email" type="text" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>密码</label>
                            <input id="user-edit-password" name="password" type="password" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>确认密码</label>
                            <input id="user-edit-conFirmPassword" name="confirmPassword" type="password" class="form-control">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="saveUser()">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--用户编辑框 end--%>

<%--用户删除框 start--%>
<div id="user-delete-modal" class="modal modal-danger">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">删除用户</h4>
            </div>
            <div class="modal-body">
                <p>确定删除吗？</p>
                <input id="user-delete-id" type="hidden">
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="conFirmDeleteUser();">确定</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--用户删除框 end--%>
<%--分配角色框 start--%>
<div id="distribute-role-modal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">分配角色</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="user-role-id">
                <ul id="roleTree" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveRole()">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--分配角色框 end--%>
<%--分配组织框 start--%>
<div id="distribute-group-modal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">分配组织</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="user-group-id">
                <ul id="groupTree" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveGroup()">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--分配组织框 end--%>
<script type="text/javascript">
    var PAGESIZE = 10;
    //生成表格
    function buildTable(userName, pageNumber, pageSize) {
        var url = "${ctx}/user/list"; //请求的网址
        var reqParams = {'userName': userName, 'pageNo': pageNumber, 'pageSize': pageSize};//请求数据
        $.ajax({
            type: "POST",
            url: url,
            data: reqParams,
            dataType: "json",
            success: function (data) {
                if (data.isError == false) {
                    // options.totalPages = data.pages;
                    var newoptions = {
                        currentPage: data.pageNo,  //当前页数
                        totalPages: data.pages == 0 ? 1 : data.pages,  //总页数
                        size: "normal",
                        alignment: "center",
                        itemContainerClass: function (type, page, current) {
                            return (page === current) ? "active" : "pointer-cursor";
                        },
                        itemTexts: function (type, page, current) {
                            switch (type) {
                                case "first":
                                    return "第一页";
                                case "prev":
                                    return "前一页";
                                case "next":
                                    return "下一页";
                                case "last":
                                    return "末页";
                                case "page":
                                    return page;
                            }
                        },
                        onPageClicked: function (e, originalEvent, type, page) {
                            var userName = $("#queryUserName").val(); //取内容
                            buildTable(userName, page, PAGESIZE);//默认每页最多10条
                        }
                    };
                    $('#bottomTab').bootstrapPaginator(newoptions); //重新设置总页面数目
                    var dataList = data.dataList;
                    $("#tableBody").empty();//清空表格内容
                    if (dataList.length > 0) {
                        $(dataList).each(function () {//重新生成
                            var dataTr = '<tr><td>' + this.userId + '</td><td>' + this.userName + '</td><td>' + this.password + '</td><td>' + this.email +
                                    '</td><td><button type="button" class="btn btn-primary" onclick="userEdit('+this.userId+');">编辑</button>  ' +
                                    '<button type="button" class="btn btn-danger" onclick="deleteUser('+this.userId+')">删除</button>  ' +
                                    '<button type="button" class="btn btn-info" onclick="distributeRole('+this.userId+')">分配角色</button>  ' +
                                    '<button type="button" class="btn btn-success" onclick="distributeGroup('+this.userId+')">分配组织</button></td></tr>';
                            $("#tableBody").append(dataTr);
                        });
                    } else {
                        $("#tableBody").append('<tr><th colspan ="4"><center>查询无数据</center></th></tr>');
                    }
                } else {
                    alert(data.errorMsg);
                }
            },
            error: function (e) {
                alert("查询失败:" + e);
            }
        });
    }

    //渲染完就执行
    $(function () {
        buildTable("", 1, 10);//默认空白查全部
        //创建结算规则
        $("#queryButton").bind("click", function () {
            var userName = $("#queryUserName").val();
            buildTable(userName, 1, PAGESIZE);
        });
    });

    function userEdit(id) {
        $.ajax({
            type: "POST",
            url: '${ctx}/user/'+id,
            dataType: "json",
            success:function (data) {
                $("#user-edit-modal").on('shown.bs.modal', function () {
                    var $this = $(this);
                    var $modal_dialog = $this.find('.modal-dialog');
                    var m_top = ( $(document).height() - $modal_dialog.height() ) / 2;
                    $modal_dialog.css({'margin': m_top + 'px auto'});
                });
                $("#user-edit-modal").modal('show');
                $("#user-edit-id").val(data.userId);
                $("#user-edit-userName").attr('placeholder',data.userName);
            },
            error:function (data) {
                alert(e);
            }
        });

    }

    function deleteUser(id) {
        $("#user-delete-id").val(id);
        $("#user-delete-modal").on('shown.bs.modal', function () {
            var $this = $(this);
            var $modal_dialog = $this.find('.modal-dialog');
            var m_top = ( $(document).height() - $modal_dialog.height() ) / 2;
            $modal_dialog.css({'margin': m_top + 'px auto'});
        });
        $("#user-delete-modal").modal('show');
    }

    function conFirmDeleteUser() {
        var user_id=$("#user-delete-id").val();
        $.ajax({
            type:'POST',
            contentType: "application/json",
            url:"${ctx}/user/delete/"+user_id,
            dataType:"json",
            success:function (msg) {
                buildTable("",1,10);
                $("#user-delete-modal").modal('hide');
            }
        });
    }

    function saveUser() {
        var str_data=$("#user-edit-form").serializeObject();
        $.ajax({
            type:'POST',
            contentType: "application/json",
            url:"${ctx}/user/update",
            data:JSON.stringify(str_data),
            dataType:"json",
            success:function (msg) {
                buildTable("",1,10);
                $("#user-edit-modal").modal('hide');
            }
        });
    }

    function distributeRole(id) {
        $("#user-role-id").val(id);
        var setting = {
            view: {
                selectedMulti: false
            },data: {
                simpleData: {
                    enable:true,
                    idKey: "id",
                    pIdKey: "pId",
                    rootPId: ""
                }
            },check:{
                enable : true   //是否有复选框：true?false
            }
        };

        $.ajax({
            type: "POST",
            url: '${ctx}/user/roles/'+id,
            dataType: "json",
            success:function (data) {
                var t = $("#roleTree");
                $.fn.zTree.init(t, setting, data);
                $("#distribute-role-modal").on('shown.bs.modal', function () {
                    var $this = $(this);
                    var $modal_dialog = $this.find('.modal-dialog');
                    var m_top = ( $(document).height() - $modal_dialog.height() ) / 2;
                    $modal_dialog.css({'margin': m_top + 'px auto'});
                });
                $("#distribute-role-modal").modal('show');
            },
            error:function (data) {
                alert(data);
            }
        });
    }

    function saveRole() {
        var userId = $("#user-role-id").val();
        var treeObj=$.fn.zTree.getZTreeObj("roleTree");
        var nodes=treeObj.getCheckedNodes(true);
        var roleIds="";
        for(var i=0;i<nodes.length;i++){
            roleIds+=nodes[i].id + ",";
        }
        var reqParams = {'roles':roleIds,'userId':userId};
        $.ajax({
            type: "POST",
            url: '${ctx}/user/roles/save',
            data: reqParams,
            dataType: "json",
            success: function (data) {
                if(data.msg == 'sucs'){
                    $("#distribute-role-modal").modal('hide');
                }
            },
            error: function (e) {
                alert(e);
            }
        });
    }

    function distributeGroup(userId) {
        $("#user-group-id").val(userId);
        var setting = {
            view: {
                selectedMulti: false
            },data: {
                simpleData: {
                    enable:true,
                    idKey: "id",
                    pIdKey: "pid",
                    rootPId: ""
                }
            },check:{
                enable : true,   //是否有复选框：true?false
                chkboxType : { "Y" : "", "N" : "" }
            }
        };

        $.ajax({
            type: "POST",
            url: '${ctx}/user/groups/'+userId,
            dataType: "json",
            success:function (data) {
                var t = $("#groupTree");
                $.fn.zTree.init(t, setting, data);
                $("#distribute-group-modal").on('shown.bs.modal', function () {
                    var $this = $(this);
                    var $modal_dialog = $this.find('.modal-dialog');
                    var m_top = ( $(document).height() - $modal_dialog.height() ) / 2;
                    $modal_dialog.css({'margin': m_top + 'px auto'});
                });
                $("#distribute-group-modal").modal('show');
            },
            error:function (data) {
                alert(data);
            }
        });
    }

    function saveGroup() {
        var userId = $("#user-group-id").val();
        var treeObj=$.fn.zTree.getZTreeObj("groupTree");
        var nodes=treeObj.getCheckedNodes(true);
        var groupIds="";
        for(var i=0;i<nodes.length;i++){
            groupIds+=nodes[i].id + ",";
        }
        var reqParams = {'userGroups':groupIds,'userId':userId};
        $.ajax({
            type: "POST",
            url: '${ctx}/user/groups/save',
            data: reqParams,
            dataType: "json",
            success: function (data) {
                if(data.msg == 'sucs'){
                    $("#distribute-group-modal").modal('hide');
                }
            },
            error: function (e) {
                alert(e);
            }
        });
    }

    $.fn.serializeObject = function(){
        var o = {};
        var a = this.serializeArray();
        $.each(a, function() {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };
</script>
</body>
</html>
