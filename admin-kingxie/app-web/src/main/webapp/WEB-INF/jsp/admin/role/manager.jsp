<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/11
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../common/tag.jsp" %>
<%
        request.setCharacterEncoding("UTF-8");
%>
<html >
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
                <input id="queryRoleName" type="text" name="roleName" class="form-control" placeholder="输入角色名">
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
                <th>角色名称</th>
                <th>角色代码</th>
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
        <div class="col-xs-2">
            <button class="btn-primary" onclick="alertRole();">添加新角色</button>
        </div>
    </div>
</div>
<%--新增角色框 start--%>
<div id="role-add-modal" class="modal modal-info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增角色</h4>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="box-body">
                        <div class="form-group">
                            <label>角色名称</label>
                            <input id="roleNameValue" type="text" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>角色代码</label>
                            <input id="roleNameCode" type="text" class="form-control">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="saveRole();">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--新增角色框 end--%>
<%--编辑角色框 start--%>
<div id="role-edit-modal" class="modal modal-info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑角色</h4>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="box-body">
                        <div class="form-group">
                            <label>角色名称</label>
                            <input id="editRoleId" type="hidden" class="form-control">
                            <input id="editRoleName" type="text" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>角色代码</label>
                            <input id="editRoleCode" type="text" class="form-control">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="updateRole();">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--编辑角色框 end--%>
<%--分配权限框 start--%>
<div id="distribute-privilege-modal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">分配权限</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="role-pri-id">
                <ul id="priTree" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="savePri()">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--分配权限框 end--%>

<script type="text/javascript">
    var PAGESIZE = 10;
    //生成表格
    function buildTable(roleName, pageNumber, pageSize) {
        var url = "${ctx}/role/list"; //请求的网址
        var reqParams = {'roleName': roleName, 'pageNo': pageNumber, 'pageSize': pageSize};//请求数据
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
                            var roleName = $("#queryRoleName").val(); //取内容
                            buildTable(roleName, page, PAGESIZE);//默认每页最多10条
                        }
                    };
                    $('#bottomTab').bootstrapPaginator(newoptions); //重新设置总页面数目
                    var dataList = data.dataList;
                    $("#tableBody").empty();//清空表格内容
                    if (dataList.length > 0) {
                        $(dataList).each(function () {//重新生成
                            var dataTr = '<tr><td>' + this.roleId + '</td><td>' + this.roleName + '</td><td>'+this.roleCode+'</td>' +
                                    '<td><button class="btn btn-info" onclick="distributePrivilege(' + this.roleId + ');">分配权限</button>  ' +
                                    '<button class="btn btn-primary" onclick="editRole(' + this.roleId + ');">编辑</button></td></tr>'
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
            var roleName = $("#queryRoleName").val();
            buildTable(roleName, 1, PAGESIZE);
        });
    });

    function alertRole() {
        $("#role-add-modal").on('shown.bs.modal', function () {
            var $this = $(this);
            var $modal_dialog = $this.find('.modal-dialog');
            var m_top = ( $(document).height() - $modal_dialog.height() ) / 2;
            $modal_dialog.css({'margin': m_top + 'px auto'});
        });
        $("#role-add-modal").modal('show');
    }

    function saveRole() {
        var roleName = $("#roleNameValue").val();
        var roleCode = $("#roleNameCode").val();
        var dataRole = {'roleName':roleName,'roleCode':roleCode};
        $.ajax({
            type: "POST",
            url: '${ctx}/role/save',
            data: dataRole,
            dataType: "json",
            success: function (data) {
                if(data.msg == "success"){
                    $("#role-add-modal").modal('hide');
                    buildTable("",1,10);
                }
            },
            error: function (e) {
                alert("保存失败:" + e);
            }
        });
    }

    function distributePrivilege(roleId){
        $("#role-pri-id").val(roleId);
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
                enable : true   //是否有复选框：true?false
            }
        };

        $.ajax({
            type: "POST",
            url: '${ctx}/role/pris/'+roleId,
            dataType: "json",
            success:function (data) {
                var t = $("#priTree");
                $.fn.zTree.init(t, setting, data);
                $("#distribute-privilege-modal").on('shown.bs.modal', function () {
                    var $this = $(this);
                    var $modal_dialog = $this.find('.modal-dialog');
                    var m_top = ( $(document).height() - $modal_dialog.height() ) / 2;
                    $modal_dialog.css({'margin': m_top + 'px auto'});
                });
                $("#distribute-privilege-modal").modal('show');
            },
            error:function (data) {
                alert(data);
            }
        });
    }

    function savePri() {
        var roleId=$("#role-pri-id").val();
        var treeObj=$.fn.zTree.getZTreeObj("priTree");
        var nodes=treeObj.getCheckedNodes(true);
        var pris="";
        for(var i=0;i<nodes.length;i++){
            pris+=nodes[i].id + ",";
        }
        var reqParams = {'pris':pris,'roleId':roleId} ;
        $.ajax({
            type: "POST",
            url: '${ctx}/role/pris/save',
            data:reqParams,
            dataType: "json",
            success:function (data) {
                $("#distribute-privilege-modal").modal('hide');
            },
            error:function (data) {
                alert(data);
            }
        });
    }

    function editRole(roleId) {
        var url = '${ctx}/role/get/'+roleId;
        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: function (data) {
                 $("#editRoleId").val(roleId);
                 $("#editRoleName").val(data.roleName);
                 $("#editRoleCode").val(data.roleCode);
                $("#role-edit-modal").on('shown.bs.modal', function () {
                    var $this = $(this);
                    var $modal_dialog = $this.find('.modal-dialog');
                    var m_top = ( $(document).height() - $modal_dialog.height() ) / 2;
                    $modal_dialog.css({'margin': m_top + 'px auto'});
                });
                $("#role-edit-modal").modal('show');
            },
            error: function (e) {
                alert(e);
            }
        });
    }
    function updateRole() {
        var roleId=$("#editRoleId").val();
        var roleName=$("#editRoleName").val();
        var roleCode=$("#editRoleCode").val();
        var reqParams = {'roleId':roleId,'roleName':roleName,'roleCode':roleCode} ;
        $.ajax({
            type: "POST",
            url: '${ctx}/role/update',
            data:reqParams,
            dataType: "json",
            success:function (data) {
                $("#role-edit-modal").modal('hide');
                buildTable("",1,10);
            },
            error:function (data) {
                alert(data);
            }
        });
    }

</script>
</body>
</html>
