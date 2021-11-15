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
                 $.ajax({
                     url:`${pageContext.request.contextPath}/homepage/dact`,
                     success:function x(data) {
                     if(data!="0"){
                         window.location.href=data;
                     }
                 }
                 })
             }

                $("#img1").click(function () {
                      window.location.href="http://localhost:8080/Vivo_war_exploded/";
                  })

                $("#exit").click(function () {
                    $.ajax({
                        url:`${pageContext.request.contextPath}/exitac/ea`,
                     success:function(){
                      window.location.href="http://localhost:8080/Vivo_war_exploded/"
                        }
                    })
                })

                $("#cancll").click(function () {
                     $("#bottom").hide(),
                     $("#forms").show(),
                     $("#ccells").show(),
                     $("#upuser").hide()
                })

                $("#ups").click(function () {
                    $("#bottom").hide(),
                        $("#forms").show(),
                        $("#ccells").hide(),
                        $("#upuser").show()
                })

                $("#upuser").click(function () {
                    $.ajax({
                        url:`${pageContext.request.contextPath}/atcenter/upuser`,
                        data:{
                            "upact":$("#upact").val()
                        },
                        success:function (data) {
                            window.location.href=data
                        }
                    })
                })

                $("#ccells").click(function () {
                     $.ajax({
                         url:`${pageContext.request.contextPath}/atcenter/deluser`,
                         data:{
                             "upact":$("#upact").val()
                         }
                     })
                })
        })
    </script>
</head>
<body>
        <div class="bottom" id="bottom">

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
                <div class="update sty" id="ups">修改信息</div>
            </div>
            <div class="information_bar op">
                <div class="exit sty" id="exit"> 退出登录</div>
            </div>
            <div class="information_bar op">
                <div class="cancell sty" id="cancll">账号注销</div>
            </div>
        </div>

        <form  method="post" id="forms">
        <input type="password" placeholder="    请输入密码(>6&&<12)" id="upact"><br>
        <input type="submit" value="注销" style="background: red;color: white" id="ccells">
        <input type="submit" value="修改" style="background: #4370ff;color: white" id="upuser"><br>
        <button id="butt">返回</button>
        </form>

</body>
</html>
