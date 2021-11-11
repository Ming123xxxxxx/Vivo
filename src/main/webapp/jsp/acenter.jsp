<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/11/7
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>账户中心</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/acenter.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript">
        $(function () {
             window.onload=function(){
                 $.ajax({
                     url:`${pageContext.request.contextPath}/atcenter/pikeupinfo`,
                     success:function (data) {
                         $("#vname").text(data[0]),
                         $("#vac").text(data[1]),
                         $("#vpwd").text(data[2])
                     }
                 })
             }

              $("#img1").click(function () {
                  window.location.href="http://localhost:8080/Vivo_war_exploded/";
              })
        })
    </script>
</head>
<body>

        <div class="bottom">

            <div class="top">
                 <div class="blank"></div>
                 <div class="logos">
                     <img id="img1" src="${pageContext.request.contextPath}/img/logo.png">
                 </div>
                <h2>账户中心</h2>
            </div>

            <div class="information_bar" style="margin-top: 35px">
              <img src="${pageContext.request.contextPath}/img/uname.png" />  Vivo账号名:
              <span id="vname"></span>
            </div>
            <div class="information_bar">
              <img src="${pageContext.request.contextPath}/img/act.png" />  账号:
              <span id="vac"></span>
            </div>
            <div class="information_bar">
                <img src="${pageContext.request.contextPath}/img/pwd.png" />  密码:
                <span id="vpwd"></span>
            </div>
            <div class="information_bar op">
                <div class="update sty">修改信息</div>
            </div>
            <div class="information_bar op">
                <div class="exit sty"> 退出登录</div>
            </div>
            <div class="information_bar op">
                <div class="cancell sty">账号注销</div>
            </div>
        </div>

</body>
</html>
