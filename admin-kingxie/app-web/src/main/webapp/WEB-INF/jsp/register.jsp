<%--
  Created by IntelliJ IDEA.
  User: think
  Date: 2016/11/2
  Time: 13:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 2 | 注册</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <jsp:include page="common/head.jsp"/>
    <jsp:include page="common/validator.jsp"/>

</head>
<body class="hold-transition register-page">
    <div class="register-box">
        <div class="register-logo">
            <a href="#"><b>Admin</b>LTE</a>
        </div>
        <div class="register-box-body">
            <p class="login-box-msg">注册一个新账号</p>
            <div class="row">
                <section>
                    <div class="col-sm-8 col-sm-offset-2">
                        <form id="registerForm"  class="form-horizontal" >
                            <div class="form-group">
                                <div class="col-sm-25">
                                    <input type="text" class="form-control" name="userName" placeholder="用户名"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-25">
                                    <input type="text" class="form-control" name="email" placeholder="邮箱"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-25">
                                    <input type="password" class="form-control" name="password" placeholder="密码"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-25">
                                    <input type="password" class="form-control" name="confirmPassword" placeholder="确认密码"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-8">
                                    <div class="checkbox icheck">
                                        <label>
                                            <input type="checkbox" name="terms"> 我同意 <a href="#">《协议》</a>
                                        </label>
                                    </div>
                                </div>
                                <!-- /.col -->
                                <div class="col-xs-4">
                                    <button  type="button" class="btn btn-primary btn-block btn-flat" onclick="register()">注册</button>
                                </div>
                                <!-- /.col -->
                            </div>
                        </form>
                        <div class="social-auth-links text-center">
                            <p>- 或者 -</p>
                            <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i>使用Facebook 登录</a>
                            <a href="#" class="btn btn-block btn-social btn-google btn-flat"><i class="fa fa-google-plus"></i>使用Google+ 登录</a>
                        </div>
                        <a href="login.html" class="text-center">我已有账号</a>
                    </div>
                </section>
            </div>
            <div class="modal modal-success" id="success-msg">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">提示</h4>
                        </div>
                        <div class="modal-body">
                            <p>注册成功，请前往登录页面登录</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline" >确定</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $.fn.serializeObject = function()
        {
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
        function register() {
            var str_data=$("#registerForm").serializeObject();
            $.ajax({
                type:'POST',
                contentType: "application/json",
                url:"${ctx}/register/save",
                data:JSON.stringify(str_data),
                dataType:"json",
                success:function (msg) {
                    $("#success-msg").modal('show');
                }
            });
        }
        $(document).ready(function () {
            $('#registerForm').bootstrapValidator({
                container: 'tooltip',
//        trigger: 'blur',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    userName: {
                        validators: {
                            stringLength: {
                                enabled: true,
                                min: 5,
                                message: '用户名必须超过5个字符'
                            },
                            notEmpty: {
                                message: '用户名不能空'
                            },
                            regexp: {
                                enabled: true,
                                regexp: /^[a-z]+$/i,
                                message: '用户名必须是a-z,A-Z之间字符'
                            }
                        }
                    },
                    email: {
                        validators: {
                            notEmpty: {
                                message: '邮箱不能为空'
                            },
                            regexp: {
                                regexp: /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/,
                                message: '邮箱格式不正确'
                            }
                        }
                    },
                    password:{
                        validators:{
                            stringLength:{
                                enabled: false,
                                min: 6,
                                message: '密码必须超过5个字符'
                            },
                            notEmpty: {
                                message: '密码不能为空'
                            },
                            regexp: {
                                regexp: /^[a-z]+$/i,
                                message: '密码必须是a-z,A-Z之间字符'
                            }
                        }
                    },
                    confirmPassword:{
                        validators: {
                            notEmpty: {
                                message: '确认密码不能为空'
                            },
                            identical: {
                                field: 'password',
                                message: '密码和确认密码必须一致'
                            }
                        }
                    },
                    terms:{
                        validators:{
                            notEmpty: {
                                message: '必须同意此协议'
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
