<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/12/1
  Time: 18:44
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- 引入 Bootstrap -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript">
        setTimeout("fmPost()",10000)
        function fmPost(){
          location.reload()
        }

        window.onload=function () {
            $.ajax({
                url:`${pageContext.request.contextPath}/admin/on`,
                success:function (data) {
                    if(data==0) {
                        window.location.href =data;
                    }
                }
            })
        }

            function x() {
                var p=$("#onandof option:selected").val()
                console.log("p="+p)
                $.ajax({
                    url:`${pageContext.request.contextPath}/admin/updatedata`,
                    data:{
                        "onandoff":p,
                    },
                    success:function (data) {
                        window.location.href =data;
                    }
                })
            }



    </script>
</head>

<body>

<div class="container">

    <div class="row clearfix">
        <div class="col-md-10 column">
            <div class="page-header">
                <h1>
                    <small>用户列表—— 显示所有用户状况</small>
                </h1>
            </div>
        </div>
    </div>

    <div class="row clearfix">
        <div class="col-md-16 column">
            <table class="table table-hover table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户名</th>
                    <th>账号</th>
                    <th>注册时间</th>
                    <th>修改账号时间</th>
                    <th>最后登录时间</th>
                    <th>在线状况</th>
                    <th>
                        <select id="onandof" onchange="x()">
                            <option  value="0"></option>
                            <option  value="0">所有用户</option>
                            <option  value="1">在线用户</option>
                            <option  value="2">离线用户</option>
                        </select>
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="register" items="${list}">
                    <tr>
                        <td>${register.id}</td>
                        <td>${register.username}</td>
                        <td>${register.account}</td>
                        <td>${register.regdate}</td>
                        <td>${register.modifytime}</td>
                        <td>${register.lastlogintime}</td>
                        <td>${register.onoff}</td>

                        <td>
                            <a href="${pageContext.request.contextPath}/admin/forcuoff?account=${register.account}" style="text-decoration: none;color: yellowgreen">强制下线  </a>
                            |
                            <a href="${pageContext.request.contextPath}/admin/delus?account=${register.account}" style="text-decoration: none;color: red">  删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>
</body>
</html>
