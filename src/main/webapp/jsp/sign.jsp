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
    <script TYPE="text/javascript">

        //刷新验证码
         $(function () {
                   $("#codes").click(
                       function () {
                           this.src="${basePath}${pageContext.request.contextPath}/kaptcha.jpg?d="+new Date();
                       }
                   );
                   $("#sub").click(function () {
                               $.ajax({
                                   type:"post",
                                   url:`${pageContext.request.contextPath}/log/ver`,
                                   data:{
                                       "account":$("#act").val(),
                                       "pwd":$("#pwd").val(),
                                       "code":$("#code").val()
                                   },
                                   success:function (data) {
                                    if (data[1]=="001"){
                                        $("#pwd").val(""),
                                        $("#code").val(""),
                                        $("#codes").attr("src","${basePath}${pageContext.request.contextPath}/kaptcha.jpg?d="+new Date())
                                        alert("账号或密码错误");
                                    }else if (data[1]=="002") {
                                        $("#pwd").val(""),
                                        $("#code").val(""),
                                        $("#codes").attr("src","${basePath}${pageContext.request.contextPath}/kaptcha.jpg?d="+new Date())
                                        alert("验证码错误")
                                    }else if(data[1]=="000"){
                                        window.location.href=data[0];
                                    }

                                   }
                               })
                   })

         })
    </script>
</head>
<body>
       <div class="bottom">

           <div class="middle" style="background-image: url('${pageContext.request.contextPath}/img/signin.jpg')">
                     <div class="top">
                         <a href="${pageContext.request.contextPath}/homepage/index"><img src="${pageContext.request.contextPath}/img/logo.png" class="h"></a>
                         <p>登录</p>
                          <div class="sig">
                             <div>
                                 <input type="text" placeholder="       请输入账号" name="account" id="act"><br>
                                 <input type="password" placeholder="       请输入密码" name="pwd" id="pwd"><br>
                                 <input type="text" placeholder="       请输入验证码" style="width: 240px" name="code" id="code">
                                 <img src="${pageContext.request.contextPath}/kaptcha.jpg" style="height:44px;width:120px;position: relative;top: 17px;right: 5px" id="codes"/> <br>
                                 <input type="submit" value="登录" style="background-color: #4375ff " id="sub">
                             </div>
                              <a href="${pageContext.request.contextPath}/registerinfo/register"><button>注册vivo账号</button></a>
                          </div>
                     </div>
           </div>

       </div>



</body>
</html>
