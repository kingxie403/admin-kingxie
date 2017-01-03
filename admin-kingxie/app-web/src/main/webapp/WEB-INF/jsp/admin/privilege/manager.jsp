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
                <input id="queryPrivilegeName" type="text" name="roleName" class="form-control" placeholder="输入权限名称">
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
        <table id="privilege-table" class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>序号</th>
                <th>权限名称</th>
                <th>权限类型</th>
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
            <button class="btn-primary" onclick="alertPrivilege();">添加新权限</button>
        </div>
    </div>
</div>
<%--新增权限框 start--%>
<div id="privilege-add-modal" class="modal modal-info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增权限</h4>
            </div>
            <div class="modal-body">
                <form role="form" id="add-privilege-form">
                    <div class="box-body">
                        <div class="form-group">
                            <label>权限名称</label>
                            <input  type="text" name="priName" class="form-control">
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
                            <label>权限类型</label>
                            <select id="privilege-type" name="priType" class="form-control">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="savePrivilege();">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--新增权限框 end--%>
<%--权限编辑框 start--%>
<div id="privilege-edit-modal" class="modal modal-info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">权限编辑</h4>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="box-body">
                        <div class="form-group">
                            <label>权限名称</label>
                            <input type="hidden" id="privilege-edit-id" name="priId">
                            <input type="text" id="privilege-edit-priName" class="form-control" name="priName">
                        </div>
                        <div class="form-group">
                            <label>权限类型</label>
                            <select id="privilege-edit-type" name="priType" class="form-control" disabled>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="savePrivilege()">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--权限编辑框 end--%>

<%--权限删除框 start--%>
<div id="privilege-delete-modal" class="modal modal-danger">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">删除权限</h4>
            </div>
            <div class="modal-body">
                <p>确定删除吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline">确定</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--权限删除框 end--%>

<%--分配菜单框 start--%>
<div id="distribute-menu-modal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">分配菜单</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="menu-pri-id">
                <ul id="menuTree" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="savePriRefMenu()">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--分配菜单框 end--%>
<%--分配文件框 start TODO--%>
<%--分配文件框 end--%>
<%--分配页面元素框 start TODO--%>
<%--分配页面元素框 end--%>
<%--分配操作框 start TODO--%>
<%--分配操作框 end--%>

<script type="text/javascript">
    var PAGESIZE = 10;
    //生成表格
    function buildTable(privilegeName, pageNumber, pageSize) {
        var url = "${ctx}/privilege/list"; //请求的网址
        var reqParams = {'privilegeName': privilegeName, 'pageNo': pageNumber, 'pageSize': pageSize};//请求数据
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
                            var privilegeName = $("#queryPrivilegeName").val(); //取内容
                            buildTable(privilegeName, page, PAGESIZE);//默认每页最多10条
                        }
                    };
                    $('#bottomTab').bootstrapPaginator(newoptions); //重新设置总页面数目
                    var dataList = data.dataList;
                    $("#tableBody").empty();//清空表格内容
                    if (dataList.length > 0) {
                        $(dataList).each(function () {//重新生成
                            var typeName="";
                            if(this.priType.trim().toLowerCase() == 'menu'){
                                typeName="分配菜单";
                            }else if(this.priType.trim().toLowerCase() == 'file'){
                                typeName="控制文件";
                            }else if(this.priType.trim().toLowerCase() == 'page'){
                                typeName="绑定元素";
                            }else if(this.priType.trim().toLowerCase() == 'operate'){
                                typeName="操作管理";
                            }
                            var dataTr = '<tr><td>' + this.priId + '</td>' +
                                    '<td>' + this.priName + '</td>' +
                                    '<td>'+this.priType+'</td>' +
                                    '<td><button class="btn btn-primary" onclick="editPrivilegeModal('+this.priId+');">编辑</button>  ' +
                                    '<button class="btn btn-info" onclick="distributeType(\''+this.priId+'\',\''+this.priType.trim().toLowerCase()+'\')">'+typeName+'</button></td></tr>';
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
            var privilegeName = $("#queryPrivilegeName").val();
            buildTable(privilegeName, 1, PAGESIZE);
        });
    });

    function alertPrivilege() {
        var pri_type="PRI_TYPE";
        $.ajax({
            type: "GET",
            url: '${ctx}/dicItem/list/?dicTypeCode='+pri_type,
            data: pri_type,
            dataType: "json",
            success:function(data){
                var options="";
                $.each(data,function (index,item) {
                    options += "<option value='"+item.text+"'>"+item.text+"</option>";
                })
                $("#privilege-type").empty();
                $("#privilege-type").append(options);
                $("#privilege-add-modal").modal('show');
            },
            error:function(){

            }
        });

    }

    function savePrivilege(){
        var str_data=$("#add-privilege-form").serializeObject();
        $.ajax({
            type:'POST',
            contentType: "application/json",
            url:"${ctx}/privilege/save",
            data:JSON.stringify(str_data),
            dataType:"json",
            success:function (msg) {
                buildTable("",1,10);
                $("#privilege-add-modal").modal('hide');
            }
        });
    }

    function editPrivilegeModal(priId){
        $.ajax({
            type:'POST',
            contentType: "application/json",
            url:"${ctx}/privilege/get/"+priId,
            dataType:"json",
            success:function (msg) {
                $("#privilege-edit-id").val(priId);
                $("#privilege-edit-priName").val(msg.priName);
                var options = "<option>"+msg.priType+"</option>"
                $("#privilege-edit-type").append(options);
                $("#privilege-edit-modal").modal('show');
            }
        });



    }

    function distributeType(priId, priType) {
        $("#menu-pri-id").val(priId);
        if(priType == 'menu'){
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
                    chkboxType : {"Y" : "ps", "N" : "s"}
                }
            };

            $.ajax({
                type: "POST",
                url: '${ctx}/pri/menus/'+priId,
                dataType: "json",
                success:function (data) {
                    var t = $("#menuTree");
                    $.fn.zTree.init(t, setting, data);
                    $("#distribute-menu-modal").on('shown.bs.modal', function () {
                        var $this = $(this);
                        var $modal_dialog = $this.find('.modal-dialog');
                        var m_top = ( $(document).height() - $modal_dialog.height() ) / 2;
                        $modal_dialog.css({'margin': m_top + 'px auto'});
                    });
                    $("#distribute-menu-modal").modal('show');
                },
                error:function (data) {
                    alert(data);
                }
            });
        }else if(priType=='file'){

        }else if(priType == 'page'){

        }else if(priType == 'operate'){

        }

    }

    function savePriRefMenu() {
        var priId=$("#menu-pri-id").val();
        var treeObj=$.fn.zTree.getZTreeObj("menuTree");
        var nodes=treeObj.getCheckedNodes(true);
        var menuIds="";
        for(var i=0;i<nodes.length;i++){
            menuIds+=nodes[i].id + ",";
        }
        var reqParams = {'menus':menuIds,'priId':priId} ;
        $.ajax({
            type: "POST",
            url: '${ctx}/pri/menus/save',
            data:reqParams,
            dataType: "json",
            success:function (data) {
                $("#distribute-menu-modal").modal('hide');
            },
            error:function (data) {
                alert(data);
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
