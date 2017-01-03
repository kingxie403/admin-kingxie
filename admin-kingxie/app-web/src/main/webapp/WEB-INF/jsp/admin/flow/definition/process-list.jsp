<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/4
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@include file="../../../common/tag.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <jsp:include page="../../../common/head.jsp"/>
    <script type="application/javascript" src="${ctx}/plugins/jQuery/ajaxfileupload.js"></script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">流程定义</h3>
    </div>
    <div class="box-pane">
        <table id="user-table" style="table-layout: fixed;word-wrap: break-word" class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>流程定义ID</th>
                <th>部署ID</th>
                <th>流程定义名称</th>
                <th>流程定义KEY</th>
                <th>版本号</th>
                <th>XML资源名称</th>
                <th>图片资源名称</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="tableBody">
                <c:forEach items="${processDefinitionList}" var="pd">
                    <tr>
                        <td>${pd.id}</td>
                        <td>${pd.deploymentId}</td>
                        <td>${pd.name}</td>
                        <td>${pd.key}</td>
                        <td>${pd.version}</td>
                        <td><a target="_blank" href="${ctx}/flow/read/resource?pdid=${pd.id}&resourceName=${pd.resourceName}">${pd.resourceName}</a></td>
                        <td><a target="_blank" href="${ctx}/flow/read/resource?pdid=${pd.id}&resourceName=${pd.diagramResourceName}">${pd.diagramResourceName}</a></td>
                        <td><button class="btn-danger" onclick="alertDeleteProcess(${pd.deploymentId})">删除</button> <button class="btn-primary" onclick="javascript:window.location.href='${ctx }/flow/form/process/start/${pd.id }'">启动</button></td>
                    </tr>
                </c:forEach>
            </tbody>

        </table>
    </div>
    <div class="box-footer">
        <div class="col-xs-8 col-xs-offset-4">
            <button class="btn-primary" onclick="definitionProcess();">定义新流程</button>
        </div>
    </div>
</div>
<%--定义新流程框 start--%>
<div id="process-definition-modal" class="modal modal-info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增流程</h4>
            </div>
            <div class="modal-body">
                <form id="process-definition-form" role="form" enctype="multipart/form-data">
                    <div class="box-body">
                        <div class="form-group">
                            <label for="processInputFile">支持文件格式：zip、bpmn、bpmn20.xml</label>
                            <input type="file" id="processInputFile" name="processInputFile">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="saveProcess()">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--定义新流程框 end--%>
<%--删除流程框 start--%>
<div id="process-delete-modal" class="modal modal-danger">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">删除流程</h4>
            </div>
            <input type="hidden" id="delete-process-id">
            <div class="modal-body">
                确定删除吗？
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="deleteProcess()">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--删除流程框 end--%>
<script type="text/javascript">

    function definitionProcess() {
        $("#process-definition-modal").modal('show');
    }
    function saveProcess() {
        $.ajaxFileUpload({
            url:'${ctx}/flow/deployment',
            secureuri:false,                       //是否启用安全提交,默认为false
            fileElementId:'processInputFile',      //文件选择框的id属性
            dataType:'json',                       //服务器返回的格式,可以是json或xml等
            success:function(data, status){        //服务器响应成功时的处理函数
                $("#process-definition-modal").modal('hide');
                window.location.reload();
            },
            error:function(data, status, e){ //服务器响应失败时的处理函数
                console.log(e);
                console.log(data);
            }
        });
    }
    function deleteProcess() {
        var deploymentId = $("#delete-process-id").val();
        $.ajax({
            type: "POST",
            url: '${ctx}/flow/delete/deployment/'+deploymentId,
            dataType: "json",
            success:function (data) {
                window.location.reload();
            },
            error:function (data) {
                console.log(data);
            }
        });
    }
    function alertDeleteProcess(deploymentId) {
        $("#delete-process-id").val(deploymentId);
        $("#process-delete-modal").modal('show');
    }
</script>
</body>
</html>
