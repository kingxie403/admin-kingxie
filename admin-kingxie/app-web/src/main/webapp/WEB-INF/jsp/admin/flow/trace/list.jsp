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
    <script src="${ctx}/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js" charset="UTF-8"></script>
    <link rel="stylesheet" href="${ctx}/plugins/datepicker/datepicker3.css">
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
        <h3 class="box-title">流程监控</h3>
    </div>
    <div class="box-pane">
        <table id="user-table" style="table-layout: fixed;word-wrap: break-word" class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>流程定义ID</th>
                <th>流程定义名称</th>
                <th>流程实例ID</th>
                <th>流程状态</th>
                <th>查看流程</th>
            </tr>
            </thead>
            <tbody id="tableBody">
            <c:forEach items="${page.result }" var="e">
                <tr>
                    <td>${e.processDefinitionId}</td>
                    <td>${definitions[e.processDefinitionId].name}</td>
                    <td>${e.processInstanceId}</td>
                    <td>${e.currentTask}</td>
                    <td><a href="${ctx}/process/trace/view?processInstanceId=${e.processInstanceId}" target="_blank">监控</a></td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>
    <div class="box-footer">
        <tags:pagination page="${page}" paginationSize="${page.pageSize}"/>
        <!-- 流程跟踪对话框 -->
        <div id="traceProcessModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="traceProcessModalLabel" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="traceProcessModalLabel">新任务</h3>
            </div>
            <div class="modal-body">
                <iframe src="" frameborder="0"></iframe>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">


</script>
</body>
</html>
