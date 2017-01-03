<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/4
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="org.activiti.engine.form.*, org.apache.commons.lang3.*" %>
<%@include file="../../common/tag.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <jsp:include page="../../common/head.jsp"/>
    <script src="${ctx}/plugins/datepicker/bootstrap-datepicker.js"></script>
    <script src="${ctx}/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js" charset="UTF-8"></script>
    <link rel="stylesheet" href="${ctx}/plugins/datepicker/datepicker3.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">任务办理—[${hasFormKey ? task.name : taskFormData.task.name}]，流程定义ID：[${hasFormKey ? task.processDefinitionId : taskFormData.task.processDefinitionId}]</h3>
    </div>
    <div class="box-pane">
        <div class="col-md-6">
            <div class="box box-primary">
                <div class="box-body">
                    <form action="${ctx }/task/complete/${hasFormKey ? task.id : taskFormData.task.id}" class="form-horizontal"
                          method="post">
                        <c:if test="${hasFormKey}">
                            ${taskFormData}
                        </c:if>

                        <c:if test="${!hasFormKey}">
                            <c:forEach items="${taskFormData.formProperties}" var="fp">
                                <c:set var="fpo" value="${fp}"/>
                                <c:set var="disabled" value="${fp.writable ? '' : 'disabled'}" />
                                <c:set var="readonly" value="${fp.writable ? '' : 'readonly'}" />
                                <c:set var="required" value="${fp.required ? 'required' : ''}" />
                                <%
                                    // 把需要获取的属性读取并设置到pageContext域
                                    FormType type = ((FormProperty)pageContext.getAttribute("fpo")).getType();
                                    String[] keys = {"datePattern", "values"};
                                    for (String key: keys) {
                                        pageContext.setAttribute(key, type.getInformation(key));
                                    }
                                %>

                                <%-- 文本或者数字类型 --%>
                                <c:if test="${fp.type.name == 'string' || fp.type.name == 'long'}">
                                    <div class="form-group">
                                        <label>${fp.name}:</label>
                                        <input type="text" class="form-control" id="${fp.id}" name="${fp.id}"
                                               data-type="${fp.type.name}"
                                               value="${fp.value}" ${readonly} ${required}/>
                                    </div>
                                </c:if>

                                <%-- 日期 --%>
                                <c:if test="${fp.type.name == 'date'}">
                                    <div class="form-group">
                                        <label>${fp.name}:</label>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <input type="text" id="${fp.id}" name="${fp.id}"
                                                   class="form-control pull-right datepicker" value="${fp.value}" data-type="${fp.type.name}" ${readonly} ${required}>
                                        </div>
                                        <!-- /.input group -->
                                    </div>
                                </c:if>

                                <%-- 下拉框 --%>
                                <c:if test="${fp.type.name == 'enum'}">
                                    <div class="form-group">
                                    <label >${fp.name}:</label>
                                    <div class="controls">
                                        <select name="${fp.id}" id="${fp.id}" ${disabled} ${required}>
                                            <c:forEach items="${values}" var="item">
                                                <option value="${item.key}" <c:if test="${item.value == fp.value}">selected</c:if>>${item.value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    </div>
                                </c:if>

                                <%-- Javascript --%>
                                <c:if test="${fp.type.name == 'javascript'}">
                                    <script type="text/javascript">${fp.value};</script>
                                </c:if>

                            </c:forEach>
                        </c:if>

                        <%-- 按钮区域 --%>
                        <div class="control-group">
                            <div class="controls">
                                <a href="javascript:history.back();"><i
                                        class="glyphicon glyphicon-chevron-left"></i>返回列表</a>
                                <button type="submit" class="btn-primary"><i class="glyphicon glyphicon-play"></i>完成任务
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="box-footer">
    </div>
</div>
<script type="text/javascript">
    $('.datepicker').datepicker({
        autoclose: true,
        format: 'yyyy-mm-dd',
        language: 'zh-CN'
    });
</script>
</body>
</html>
