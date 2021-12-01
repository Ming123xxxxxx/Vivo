<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/12/1
  Time: 18:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script type="text/javascript">
    window.onload=function () {
        $.ajax({
            url:`${pageContext.request.contextPath}/admin/on`,
            success:function (data) {
                   if(data==0) {
                       window.location.href = "http://localhost:8080/Vivo_war_exploded/admin/jump";
                   }
            }
        })
    }
</script>

<body>
dawdawd
</body>
</html>
