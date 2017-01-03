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
                <input id="queryDicTypeName" type="text" name="roleName" class="form-control" placeholder="输入字典类型名称">
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
                <th>类型名称</th>
                <th>类型编码</th>
                <th>状态</th>
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
            <button class="btn-primary" onclick="alertDicType();">添加新字典类型</button>
        </div>
    </div>
</div>
<%--新增字典类型框 start--%>
<div id="dicType-add-modal" class="modal modal-info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增字典类型</h4>
            </div>
            <div class="modal-body">
                <form role="form" id="dicType-add-form">
                    <div class="box-body">
                        <div class="form-group">
                            <label>字典名称</label>
                            <input type="text" name="dicName" class="form-control">
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
                            <label>字典编码</label>
                            <input type="text" name="dicCode" class="form-control">
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
                            <label>是否可用</label>
                            <div class="form-group">
                                <select class="form-control" name="status">
                                    <option value="1">是</option>
                                    <option value="0">否</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="saveDicType();">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--新增字典类型框 end--%>
<%--字典类型编辑框 start--%>
<div id="dicType-edit-modal" class="modal modal-info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">字典类型编辑</h4>
            </div>
            <div class="modal-body">
                <form role="form" id="dicType-edit-form">
                    <div class="box-body">
                        <div class="form-group">
                            <label>类型名称</label>
                            <input id="dicType-edit-id" name="id" type="hidden">
                            <input id="dicType-edit-dicName" name="dicName" type="text" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>类型编码</label>
                            <input id="dicType-edit-dicCode" name="dicCode" type="text" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>是否可用</label>
                            <div class="form-group">
                                <select class="form-control" name="status">
                                    <option value="1">是</option>
                                    <option value="0">否</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="updateDicType()">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--字典类型编辑框 end--%>
<%--条目管理框 start--%>
<div id="add-item-modal" class="modal modal-info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">条目管理</h4>
            </div>
            <div class="box-body">
                <table id="item-table" class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th class="col-xs-3">字典内容</th>
                        <th class="col-xs-3">字典值</th>
                        <th class="col-xs-2">排序值</th>
                        <th class="col-xs-1">操作</th>
                    </tr>
                    </thead>
                    <input type="hidden" id="dicType-id-item">
                    <form role="form" id="item-form">
                    <tbody id="itemTableBody">

                    </tbody>
                    </form>
                </table>
            </div>
            <div >
                <button class="btn btn-success" onclick="addItem();">添加新条目</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-outline" onclick="saveItem();">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<%--条目管理框 end--%>
<script type="text/javascript">
    var PAGESIZE = 10;
    //生成表格
    function buildTable(roleName, pageNumber, pageSize) {
        var url = "${ctx}/dicType/list"; //请求的网址
        var reqParams = {'dicTypeName': roleName, 'pageNo': pageNumber, 'pageSize': pageSize};//请求数据
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
                            var dicTypeNameName = $("#queryDicTypeName").val(); //取内容
                            buildTable(dicTypeNameName, page, PAGESIZE);//默认每页最多10条
                        }
                    };
                    $('#bottomTab').bootstrapPaginator(newoptions); //重新设置总页面数目
                    var dataList = data.dataList;
                    $("#tableBody").empty();//清空表格内容
                    if (dataList.length > 0) {
                        $(dataList).each(function () {//重新生成
                            var status = "可用";
                            if (this.status == 0) {
                                status = "不可用";
                            }
                            var dataTr = '<tr><td>' + this.id + '</td><td>' + this.dicName + '</td><td>' +
                                    this.dicCode + '</td><td>' + status + '</td><td>' +
                                    '<button type="button" class="btn btn-primary" onclick="dicTypeEdit(' + this.id + ');">编辑</button> ' +
                                    '<button type="button" class="btn btn-info" onclick="itemManager(' + this.id + ');">条目管理</button></td>' +
                                    '</tr>';
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
            var dicTypeName = $("#queryDicTypeName").val();
            buildTable(dicTypeName, 1, PAGESIZE);
        });
    });

    function alertDicType() {
        $("#dicType-add-modal").modal('show');
    }

    function saveDicType() {
        var str_data = $("#dicType-add-form").serializeObject();
        $.ajax({
            type: 'POST',
            contentType: "application/json",
            url: "${ctx}/dicType/save",
            data: JSON.stringify(str_data),
            dataType: "json",
            success: function (msg) {
                buildTable("", 1, 10);
                $("#dicType-add-modal").modal('hide');
            }
        });
    }

    function dicTypeEdit(id) {
        $.ajax({
            type: "POST",
            url: '${ctx}/dicType/get/' + id,
            dataType: "json",
            success: function (msg) {
                $("#dicType-edit-id").val(msg.id);
                $("#dicType-edit-dicName").val(msg.dicName);
                $("#dicType-edit-dicCode").val(msg.dicCode);
                $("#dicType-edit-modal").modal('show');
            }
        });

    }

    function updateDicType() {
        var str_data = $("#dicType-edit-form").serializeObject();
        $.ajax({
            type: "POST",
            url: '${ctx}/dicType/update/',
            contentType: "application/json",
            data: JSON.stringify(str_data),
            dataType: "json",
            success: function (msg) {
                $("#dicType-edit-modal").modal('hide');
                buildTable("", 1, 10);
            }
        });
    }

    function itemManager(id) {
        $("#dicType-id-item").val(id);
        $.ajax({
            type: "POST",
            url: '${ctx}/dicItem/list/'+id,
            dataType: "json",
            success:function (data) {
                if(data==null || data.length == 0){
                    $("#itemTableBody").empty();
                    $("#itemTableBody").append('<tr><th colspan ="4"><center>查询无数据</center></th></tr>');
                    $("#add-item-modal").modal('show');
                }else{
                        $("#itemTableBody").empty();//清空表格内容
                        if (data.length > 0) {
                            $(data).each(function () {//重新生成
                                var dataTr = '<tr><td><input type="text" name="text" class="form-control" value="'+this.text+'"></td>' +
                                        '<td><input type="text" name="value" class="form-control" value="'+this.value+'"></td>' +
                                        '<td><input type="text" name="sort" class="form-control" value="'+this.sort+'"></td>' +
                                        '<td><button type="button" class="btn btn-box-tool glyphicon glyphicon-remove" onclick="deleteItem(this)"></button></td></tr>';
                                $("#itemTableBody").append(dataTr);
                            });
                        };
                        $("#add-item-modal").modal('show');
                }
            },
            error:function (e) {
                alert(e);
            }
        });
    }

    function addItem() {

        var has=$("#itemTableBody:contains('查询无数据')");
        if(has.length != 0){
            $("#itemTableBody").empty();
            var item='<tr><td><input type="text" name="text" class="form-control"></td>' +
                    '<td><input type="text" name="value" class="form-control"></td>' +
                    '<td><input type="text" name="sort" class="form-control"></td>' +
                    '<td><button type="button" class="btn btn-box-tool glyphicon glyphicon-remove" onclick="deleteItem(this)"></button></td></tr>';
            $("#itemTableBody").append(item);
        }else{
            var item='<tr><td><input type="text" name="text" class="form-control"></td>' +
                    '<td><input type="text" name="value" class="form-control"></td>' +
                    '<td><input type="text" name="sort" class="form-control"></td>' +
                    '<td><button type="button" class="btn btn-box-tool glyphicon glyphicon-remove" onclick="deleteItem(this)"></button></td></tr>';
            $("#itemTableBody").append(item);
        }

    }

    function deleteItem(item) {
        $(item).parent().parent().remove();
    }

    function saveItem() {
        var typeId=$("#dicType-id-item").val();
        var tableData=new Array();
        $("#itemTableBody tr").each(function(trindex,tritem){
            tableData[trindex]=new Array();
            $(tritem).find("td").each(function(tdindex,tditem){
                var item = $(tditem).children();
                tableData[trindex][tdindex]=$(item).val();
            });
        });
        var objData = new Array();
        var obj;
        var reg = /^\+?[1-9][0-9]*$/;
        for(var i=0;i<tableData.length;i++){
            obj={};
            obj.text=tableData[i][0];
            obj.value=tableData[i][1];
            obj.sort=tableData[i][2];
            obj.typeId=typeId;
            objData[i] = obj;
            if(obj.text == null || obj.text == '' || !reg.test(obj.value) || !reg.test(obj.sort)){
                return;
            }
        }
        $.ajax({
            type: "POST",
            url: '${ctx}/dicItem/save',
            contentType: "application/json",
            data: JSON.stringify(objData),
            dataType: "json",
            success: function (data) {
                if(data.msg == 'sucs'){
                    $("#add-item-modal").modal('hide');
                }else {
                    alert("不能全部删完,如需删完请直接禁用字典类型");
                }
            }
        });
    }

    $.fn.serializeObject = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
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
