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
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <jsp:include page="../../common/head.jsp"/>
    <jsp:include page="../../common/treegrid.jsp"/>

    <link rel="stylesheet" href="${ctx}/bootstrap/iconpicker/icon-fonts/elusive-icons-2.0.0/css/elusive-icons.min.css"/>
    <link rel="stylesheet" href="${ctx}/bootstrap/iconpicker/icon-fonts/font-awesome-4.2.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${ctx}/bootstrap/iconpicker/icon-fonts/ionicons-1.5.2/css/ionicons.min.css"/>
    <link rel="stylesheet" href="${ctx}/bootstrap/iconpicker/icon-fonts/map-icons-2.1.0/css/map-icons.min.css"/>
    <link rel="stylesheet" href="${ctx}/bootstrap/iconpicker/icon-fonts/material-design-1.1.1/css/material-design-iconic-font.min.css"/>
    <link rel="stylesheet" href="${ctx}/bootstrap/iconpicker/icon-fonts/octicons-2.1.2/css/octicons.min.css"/>
    <link rel="stylesheet" href="${ctx}/bootstrap/iconpicker/icon-fonts/typicons-2.0.6/css/typicons.min.css"/>
    <link rel="stylesheet" href="${ctx}/bootstrap/iconpicker/icon-fonts/weather-icons-1.2.0/css/weather-icons.min.css"/>
    <link rel="stylesheet" href="${ctx}/bootstrap/iconpicker/bootstrap-iconpicker/css/bootstrap-iconpicker.min.css"/>

    <script type="text/javascript" src="${ctx}/bootstrap/iconpicker/bootstrap-iconpicker/js/iconset/iconset-all.min.js"></script>
    <script type="text/javascript" src="${ctx}/bootstrap/iconpicker/bootstrap-iconpicker/js/bootstrap-iconpicker.js"></script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="container">
    <div class="box box-primary">
        <div class="box-pane">
            <table id="treegridTable" class="table table-bordered table-striped table-condensed">
            </table>
        </div>
        <div class="box-footer">
        <button class="btn btn-primary" onclick="addMenu(null);">添加菜单</button>
        </div>
    </div>
</div> <!-- /container -->
<%--添加菜单 start--%>
<div id="add-menu-modal" class="modal modal-primary">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加菜单</h4>
            </div>
            <div class="modal-body">
                <form id="add-menu-form" role="form">
                    <div class="box-body">
                        <input id="add-menu-id" name="menuId" type="hidden" class="form-control" >
                        <div class="form-group">
                            <label>菜单名称</label>
                            <input id="add-menu-name"  name="menuName" type="text" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>菜单URL</label>
                            <input id="add-menu-url" name="menuUrl" type="text" class="form-control">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="saveMenu();">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%--添加图标 start--%>
<div id="add-icon-modal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">选择图标</h4>
            </div>
            <div class="modal-body">
                <div id="target"></div>
                <input type="hidden" id="icon-name">
                <input type="hidden" id="icon-menu-id">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveIcon();">确定</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<%--添加图标 end--%>
<script type="text/javascript">
    function loadData() {
        $.ajax({
            type: "POST",
            url: '${ctx}/menu/list',
            dataType: "json",
            success: function (data) {
                var trBody = "";
                $.each(data, function (index, item) {
                    if (item.menuParent != '' && item.menuParent != null) {
                        trBody += '<tr class="treegrid-' + item.menuId + ' treegrid-parent-' + item.menuParent + '"><td>' + item.menuName + '</td><td>'+item.menuUrl+'</td>' +
                                '<td><i class="fa '+item.menuIcon+'"></i></td>' +
                                '<td><button class="btn btn-primary glyphicon glyphicon-plus" onclick="addMenu('+item.menuId+')"/>  ' +
                                '<button class="btn btn-danger glyphicon glyphicon-minus"/>  ' +
                                '<button class="btn btn-warning glyphicon glyphicon-edit"/>  ' +
                                '<button class="btn btn-success glyphicon glyphicon-picture" onclick="addPicture('+item.menuId+')"/></td></tr>';
                    } else {
                        trBody += '<tr class="treegrid-' + item.menuId + '"><td>' + item.menuName + '</td><td>'+item.menuUrl+'</td>' +
                                '<td><i class="fa '+item.menuIcon+'"></i></td>' +
                                '<td><button class="btn btn-primary glyphicon glyphicon-plus" onclick="addMenu('+item.menuId+')"/>  ' +
                                '<button class="btn btn-danger glyphicon glyphicon-minus"/>  ' +
                                '<button class="btn btn-warning glyphicon glyphicon-edit"/>  ' +
                                '<button class="btn btn-success glyphicon glyphicon-picture" onclick="addPicture('+item.menuId+')"/></td></tr>';
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

    function addMenu(menuId) {

            $("#add-menu-id").val(menuId);
            $("#add-menu-modal").modal('show');


    }
    function saveMenu() {
        var reqParam=$("#add-menu-form").serializeObject();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: '${ctx}/menu/save',
            data:JSON.stringify(reqParam),
            dataType: "json",
            success:function (msg) {
                $("#add-menu-modal").modal('hide');
                loadData();
            },
            error:function (msg) {

            }
        });

    }


    function addPicture(menuId) {
        $("#icon-menu-id").val(menuId);
        $("#add-icon-modal").modal('show');
    }

    function saveIcon() {
        var menuId=$("#icon-menu-id").val();
        var iconName=$("#icon-name").val();
        var reqParam={'menuId':menuId,'iconName':iconName};
        $.ajax({
            type: "POST",
            url: '${ctx}/menu/update/icon',
            data:reqParam,
            dataType: "json",
            success:function (msg) {
                $("#add-icon-modal").modal('hide');
                loadData();
            },
            error:function (msg) {
               alert(msg);
            }
        });
    }
    
    $(document).ready(function () {
        loadData();
        $('#target').iconpicker({
            arrowClass: 'btn-danger',
            arrowPrevIconClass: 'glyphicon glyphicon-chevron-left',
            arrowNextIconClass: 'glyphicon glyphicon-chevron-right',
            cols: 10,
            footer: true,
            header: true,
            icon: 'fa-bomb',
            iconset: 'fontawesome',
            labelHeader: '第{0}页， 共 {1} 页',
            labelFooter: '第{0} - {1}个，共 {2} 个',
            placement: 'bottom',
            rows: 5,
            search: true,
            searchText: '搜索',
            selectedClass: 'btn-success',
            unselectedClass: ''
        });
        $('#target').on('change', function(e) {
            $("#icon-name").val(e.icon);
        });
    });


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
