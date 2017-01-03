<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/4
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../common/tag.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <jsp:include page="../../../common/head.jsp"/>
    <%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
    <script src="${ctx}/plugins/datepicker/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="${ctx}/bootstrap/js/bootstrap-paginator.min.js"></script>
    <style type="text/css">
        form {
            margin: 0 0 20px;
        }

        .pagination-centered ul {
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
    <div class="box-header with-border">
        <button class="btn-default" onclick="addModel()">创建新模型</button>
    </div>
    <div class="box-pane">
        <table id="user-table" style="table-layout: fixed;word-wrap: break-word" class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>模型ID</th>
                <th>模型名称</th>
                <th>KEY</th>
                <th>类别</th>
                <th>创建时间</th>
                <th>更新时间</th>
                <th>版本</th>
                <th>概述</th>
                <th>部署ID</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="tableBody">
            <c:forEach items="${page.result }" var="e">
                <tr>
                    <td>${e.id}</td>
                    <td>${e.name}</td>
                    <td>${e.key}</td>
                    <td>${e.category}</td>
                    <td><fmt:formatDate value="${e.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td><fmt:formatDate value="${e.lastUpdateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>${e.version}</td>
                    <td>${e.metaInfo}</td>
                    <td>${e.deploymentId}</td>
                    <td><button class="btn-primary" onclick="editModel(${e.id})" >编辑</button>
                        <button class="btn-danger" onclick="deleteModel(${e.id})">删除</button>
                        <button class="btn-info" onclick="deployModel(${e.id})">部署</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>
    <div class="box-footer">
        <tags:pagination  page="${page}" paginationSize="${page.pageSize}"/>

    </div>
</div>

<%--删除模型框 start--%>
<div id="model-delete-modal" class="modal modal-danger">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">删除模型</h4>
            </div>
            <input type="hidden" id="delete-model-id">
            <div class="modal-body">
                确定删除吗？
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="deleteFlowModel()">确定</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--删除模型框 end--%>

<script type="text/javascript">
    function editModel(id) {
        var url= "${ctx}/bpm/modeler.html?modelId="+id;
        window.open(url);
    }
    function deleteModel(id) {
        $("#delete-model-id").val(id);
        $("#model-delete-modal").modal('show');
    }
    function deleteFlowModel() {
        var modelId = $("#delete-model-id").val();
        $.ajax({
            type: "POST",
            url: '${ctx}/flow/model/delete/'+modelId,
            dataType: "json",
            success:function (data) {
                $("#model-delete-modal").modal('hide');
                window.location.reload();
            },
            error:function (data) {
                console.log(data);
            }
        });
    }
    function deployModel(id) {
        $.ajax({
            type: "POST",
            url: '${ctx}/flow/model/deploy/'+id,
            dataType: "json",
            success:function (data) {
                window.location.reload();
            },
            error:function (data) {
                console.log(data);
            }
        });
    }
    function addModel() {
        var url= "${ctx}/model/new";
        window.open(url);
    }

</script>
</body>
</html>
