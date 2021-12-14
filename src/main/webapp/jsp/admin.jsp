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

    <style type="text/css">

        *{
            margin: 0;
            margin: auto;
            padding: 0;
            box-sizing: border-box;
            text-decoration: none;
        }

        body{
            background-color: #a3a3a3;
        }

        .uporwrite{
            height: 30px;
            width: 1200px;
            margin-left: 21%;
            font-size: 20px;
        }
        .uporwrite span{
            display: inline-block;
            width: 50%;
            float: left;
            text-align: center;
            line-height: 30px;
            background-color: #e67689;
        }
        .uporwrite span:nth-child(1){
            background-color: white;
        }
    </style>
    <script type="text/javascript">
        setTimeout("fmPost()",10000)
        function fmPost(){
          location.reload()
        }

        window.onload=function () {
            $.ajax({
                url:`${pageContext.request.contextPath}/admin/on`,
            })
            $(".texts").hide();
        }

            function x() {
                var p=$("#onandof option:selected").val()
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

        $(function () {
            $(".uporwrite #s1").click(function () {
                $(".texts").hide();
                $(".container").show();
                $("#s1").css("background-color","white");
                $("#s2").css("background-color","#e67689")
            })

            $(".uporwrite #s2").click(function () {
                $(".texts").show();
                $(".container").hide();
                $("#s2").css("background-color","white");
                $("#s1").css("background-color","#e67689")
            })
        })
    </script>
</head>

<body>

<div class="uporwrite">
    <span id="s1">管理用户</span>
    <span id="s2">管理文本</span>
</div>

<div class="container">

    <div class="row clearfix">
        <div class="col-md-10 column">
            <div class="page-header">
                <h1>
                    <small>用户列表—— 显示所有用户状况</small>
                </h1>
                <h4>当天访问人数:<c:out value="${cusssday}"/></h4>
                <h4>当前在线人数:<c:out value="${cussspeop}"/></h4>
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
