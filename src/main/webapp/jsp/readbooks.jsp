<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/12/15
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
        a{
            width: 100%;
            height: 30px;
            text-align:center;
            line-height: 30px;
            background-color: #4cc4b4;
            display: inline-block;
        }
        div{
            width: 1200px;
            height: 1000px;
            background-color: white;
        }
    </style>
</head>
<body>
<a  href="${pageContext.request.contextPath}/community/into">
    返回社区
</a>
<div>
    <textarea default readonly style="width: 1200px; height: 1000px;margin: auto;text-align: center;font-size: 15px" disabled>${text}</textarea>
</div>

</body>
</html>
