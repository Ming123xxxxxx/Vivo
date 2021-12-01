<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/12/1
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/varifaction.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
</head>
<body>
   <form action="${pageContext.request.contextPath}/admin/varis" method="post">
       <input type="text" placeholder="       请输入账号" name="account"><br>
       <input type="password" placeholder="       请输入密码" name="pwd"><br>
       <input type="submit" value="提交">
   </form>
</body>
</html>
