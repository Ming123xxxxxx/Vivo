<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/10/29
  Time: 21:12
  To change this template use File top| Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript">

        window.onload=function(){

            $.ajax({
                url:`${pageContext.request.contextPath}/homepage/getonoff`,
                success:function (i) {
                    if (i ==1) {
                        $("#reorup").text("修改信息")
                        $("#sus").val("修改")
                        $("#act").hide()
                        $("#s2").hide()
                    } else {
                        $("#reorup").text("用户注册")
                    }
                }
            })
        }
            $(function () {
                $("#sus").click(
                    function () {
                        $.ajax({
                            url:"${pageContext.request.contextPath}/registerinfo/varifaction",
                            type:"post",
                            data:{
                                "name":$("#name").val(),
                                "act":$("#act").val(),
                                "pwd":$("#pwd").val(),
                                "rpwd":$("#rpwd").val(),
                            },
                            success:function (data) {

                                    $("#name").css("background-color",data[0].color),

                                    $("#act").css("background-color",data[1].color),

                                    $("#pwd").css("background-color",data[2].color),

                                    $("#rpwd").css("background-color",data[3].color),

                                    $("#s1").text(data[0].text).css("color",data[0].color,"font-size","10px"),
                                    $("#s2").text(data[1].text).css("color",data[1].color,"font-size","10px"),
                                    $("#s3").text(data[2].text).css("color",data[2].color,"font-size","10px"),
                                    $("#s4").text(data[3].text).css("color",data[3].color,"font-size","10px")

                                    $.ajax({
                                    url:`${pageContext.request.contextPath}/homepage/getonoff`,
                                    success:function (p) {

                                    for(var i=0;i<4;i++){
                                        if(i==1&&p==1){
                                            continue;
                                        }
                                        if(data[i].color=="#ea8585"){
                                             break;
                                        }
                                    }

                                    if(($("input[type='checkbox']").attr('checked')=="checked"&&i==4)&&p!=1) {
                                        alert("注册成功")
                                        $.ajax({
                                            url:"${pageContext.request.contextPath}/registerinfo/adduser",
                                            data:{
                                                "username":$("#name").val(),
                                                "account":$("#act").val(),
                                                "pwd":$("#pwd").val(),
                                            },
                                            success:function (data) {
                                                if(data!=null){
                                                    window.location.href=data;
                                                }
                                            }
                                        })

                                    }else if(($("input[type='checkbox']").attr('checked')=="checked"&&i==4&&p==1)){
                                        $.ajax({
                                            url:"${pageContext.request.contextPath}/registerinfo/adduser",
                                            data:{
                                                "username":$("#name").val(),
                                                "account":$("#act").val(),
                                                "pwd":$("#pwd").val(),
                                            },
                                            success:function (data) {
                                                if(data!=null&&data!="0"){
                                                    alert("修改成功")
                                                    window.location.href=data;
                                                }
                                                if(data=="0"){
                                                    alert("今日已经修改过了,请明日再来修改")
                                                }
                                            }
                                        })

                                    } else if((($("input[type='checkbox']").attr('checked')!="checked"||i<4)&&p==1)){
                                        alert("修改失败")
                                    }else{
                                        alert("注册失败")
                                    }
                                    }
                                    })
                            },
                            error:function () {
                                console.log("error")
                            }

                        })
                    }
                )
            })
    </script>
</head>
<body>
     <div class="homepage">

         <a href="${pageContext.request.contextPath}/homepage/index"> <span class="logo"><img src="${pageContext.request.contextPath}/img/logo.png"></span></a>

         <div>

             <h1 id="reorup"></h1>
             <input id="name" type="text" placeholder="    请输入用户名(<6位)" class="input_register" name="username" onkeyup="this.value=this.value.replace(/\s+/g,'')">

             <span id="s1"></span>
             <input id="act" type="text" placeholder="    请输入账号(11位)" class="input_register" name="account" onkeyup="this.value=this.value.replace(/\s+/g,'')">

             <span id="s2"></span>
             <input id="pwd" type="password"  placeholder="    请输入密码(>6&&<12)" class="input_register" name="pwd" onkeyup="this.value=this.value.replace(/\s+/g,'')">

             <span id="s3"></span>
             <input id="rpwd" type="password"  placeholder="    请确认密码" class="input_register" onkeyup="this.value=this.value.replace(/\s+/g,'')">

             <span id="s4"></span>
             <input type="checkbox" class="sel">
             <span class="conf">我已阅读并接受 <a href="javascrpit:;"> 《服务协议》 </a> 和 <a href="javascrpit:;"> 《隐私政策》</隐私政策> </a></span>
             <br>
             <input type="submit" value="注册" class="sub" id="sus">

         </div>

     </div>

</body>
</html>
