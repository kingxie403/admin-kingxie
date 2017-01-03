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
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">任务列表</h3>
    </div>
    <div class="box-pane">
        <table id="task-list-table" style="table-layout: fixed;word-wrap: break-word" class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>任务ID</th>
                <th>任务名称</th>
                <th>流程实例ID</th>
                <th>任务创建时间</th>
                <th>办理人</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="tableBody">
            <c:forEach items="${tasks}" var="task">
                <tr>
                    <td>${task.id}</td>
                    <td>${task.name}</td>
                    <td>${task.processInstanceId}</td>
                    <td><fmt:formatDate value="${task.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>${task.assignee}</td>
                    <td><button class="btn-primary" onclick="javascript:window.location.href='${ctx }/task/claim/${task.id}'">签收</button></td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>
    <div class="box-footer">
    </div>
</div>

<script type="text/javascript">


</script>
</body>
</html>
