<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/11/4
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sign.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <SCRIPT TYPE="text/javascript">
        //刷新验证码
         $(function () {
                   $("#codes").click(
                       function () {
                           this.src="${basePath}${pageContext.request.contextPath}/kaptcha.jpg?d="+new Date();
                       }
                   );
                   $("#sub").click(function () {
                               $.ajax({
                                   url:"${pageContext.request.contextPath}/log/ver",
                                   type:"post",
                                   data:{
                                       "account":$("#act").val(),
                                       "pwd":$("#pwd").val(),
                                       "code":$("#code").val()
                                   },
                                   success:function (data) {
                                       console.log(data)
                                    if (data=="001"){
                                        alert("账号或密码错误")
                                        <%session.setAttribute("veri","error");%>
                                    }else if (data=="002") {
                                        alert("验证码错误")
                                        <%session.setAttribute("veri","error");%>
                                    }else if(data=="000"){
                                       <%session.setAttribute("veri","success");%>
                                    }
                                   }

                               })
                   })

         })
    </SCRIPT>
</head>
<body>
       <div class="bottom">

           <div class="middle" style="background-image: url('${pageContext.request.contextPath}/img/signin.jpg')">
                     <div class="top">
                         <a href="${pageContext.request.contextPath}/homepage/index"><img src="${pageContext.request.contextPath}/img/logo.png" class="h"></a>
                         <p>登录</p>
                          <div class="sig">
                             <form action="${pageContext.request.contextPath}/log/result" method="post">
                                 <input type="text" placeholder="       请输入账号" name="account" id="act"><br>
                                 <input type="password" placeholder="       请输入密码" name="pwd" id="pwd"><br>
                                 <input type="text" placeholder="       请输入验证码" style="width: 240px" name="code" id="code">
                                 <img src="${pageContext.request.contextPath}/kaptcha.jpg" style="height:44px;width:120px;position: relative;top: 17px;right: 5px" id="codes"/> <br>
                                 <input type="submit" value="登录" style="background-color: #4375ff " id="sub">
                             </form>
                              <a href="${pageContext.request.contextPath}/registerinfo/register"><button>注册vivo账号</button></a>

                          </div>
                     </div>
           </div>

       </div>



</body>
</html>