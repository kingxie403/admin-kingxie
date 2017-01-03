<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/11
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../common/tag.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <jsp:include page="../../../common/head.jsp"/>
    <jsp:include page="../../../common/treegrid.jsp"/>
    <link rel="stylesheet" href="${ctx}/plugins/zTree/css/metroStyle/metroStyle.css">
    <script type="text/javascript" src="${ctx}/plugins/zTree/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/zTree/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/zTree/js/jquery.ztree.exedit.js"></script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="container">
    <div class="box box-primary">
        <div class="box-pane">
            <table id="treegridTable" class="table table-bordered table-striped table-condensed">
            </table>
        </div>
        <div class="box-footer">
            <button class="btn btn-primary" onclick="addUserGroup(null);">添加组织</button>
        </div>
    </div>
</div> <!-- /container -->
<%--添加组织 start--%>
<div id="add-user-group-modal" class="modal modal-primary">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加组织</h4>
            </div>
            <div class="modal-body">
                <form id="add-user-group-form" role="form">
                    <div class="box-body">
                        <input id="add-user-group-id" name="groupId" type="hidden" class="form-control" >
                        <div class="form-group">
                            <label>组织名称</label>
                            <input id="add-user-group-name"  name="groupName" type="text" class="form-control">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="saveUserGroup();">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<%--添加组织 end--%>

<%--分配角色框 start--%>
<div id="distribute-group-role-modal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">分配角色</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="user-group-id">
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
<script type="text/javascript">
    function loadData() {
        $.ajax({
            type: "POST",
            url: '${ctx}/user/group/list',
            dataType: "json",
            success: function (data) {
                var trBody = "";
                $.each(data, function (index, item) {
                    if (item.parentId != '' && item.parentId != null) {
                        trBody += '<tr class="treegrid-' + item.groupId + ' treegrid-parent-' + item.parentId + '"><td>' + item.groupName + '</td>' +
                                '<td><button class="btn btn-primary glyphicon glyphicon-plus" onclick="addUserGroup('+item.groupId+')"/>  ' +
                                '<button class="btn btn-danger glyphicon glyphicon-minus"/>  ' +
                                '<button class="btn btn-warning glyphicon glyphicon-edit"/>  ' +
                                '<button class="btn btn-success" onclick="distributeRole(' + item.groupId + ')">分配角色</button></td></tr>';
                    } else {
                        trBody += '<tr class="treegrid-' + item.groupId + '"><td>' + item.groupName + '</td>' +
                                '<td><button class="btn btn-primary glyphicon glyphicon-plus" onclick="addUserGroup('+item.groupId+')"/>  ' +
                                '<button class="btn btn-danger glyphicon glyphicon-minus"/>  ' +
                                '<button class="btn btn-warning glyphicon glyphicon-edit"/>  ' +
                                '<button class="btn btn-success" onclick="distributeRole(' + item.groupId + ')">分配角色</button></td></tr>';
                    }
                })
                $("#treegridTable").empty();
                $("#treegridTable").append(trBody);
                $('#treegridTable').treegrid({
                    expanderExpandedClass: 'glyphicon glyphicon-menu-down',
                    expanderCollapsedClass: 'glyphicon glyphicon-menu-right'
                });
            },
            error: function (msg) {
                console.log(msg);
            }
        });
    }

    function addUserGroup(menuId) {

        $("#add-user-group-id").val(menuId);
        $("#add-user-group-modal").modal('show');


    }
    function saveUserGroup() {
        var reqParam=$("#add-user-group-form").serializeObject();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: '${ctx}/user/group/save',
            data:JSON.stringify(reqParam),
            dataType: "json",
            success:function (msg) {
                $("#add-user-group-modal").modal('hide');
                loadData();
            },
            error:function (msg) {

            }
        });

    }

    $(document).ready(function () {
        loadData();
    });

    function distributeRole(groupId) {
        $("#user-group-id").val(groupId);
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
            url: '${ctx}/userGroup/roles/'+groupId,
            dataType: "json",
            success:function (data) {
                var t = $("#roleTree");
                $.fn.zTree.init(t, setting, data);
                $("#distribute-group-role-modal").on('shown.bs.modal', function () {
                    var $this = $(this);
                    var $modal_dialog = $this.find('.modal-dialog');
                    var m_top = ( $(document).height() - $modal_dialog.height() ) / 2;
                    $modal_dialog.css({'margin': m_top + 'px auto'});
                });
                $("#distribute-group-role-modal").modal('show');
            },
            error:function (data) {
                alert(data);
            }
        });

    }

    function saveRole() {
        var groupId=$("#user-group-id").val();
        var treeObj=$.fn.zTree.getZTreeObj("roleTree");
        var nodes=treeObj.getCheckedNodes(true);
        var roleIds="";
        for(var i=0;i<nodes.length;i++){
            roleIds+=nodes[i].id + ",";
        }
        var reqParams = {'roles':roleIds,'userGroupId':groupId};
        $.ajax({
            type: "POST",
            url: '${ctx}/userGroup/roles/save',
            data: reqParams,
            dataType: "json",
            success: function (data) {
                if(data.msg == 'sucs'){
                    $("#distribute-group-role-modal").modal('hide');
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
