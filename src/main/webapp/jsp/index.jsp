<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/10/29
  Time: 18:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Vivo首页</title>
    <style>
        @font-face{
            font-family: 'icomoon';
            src:url('${pageContext.request.contextPath}/fonts/icomoon.eot?87xwgt');
            src:url('${pageContext.request.contextPath}/fonts/icomoon.eot?87xwgt#iefix') format('embedded-opentype'),
            url('${pageContext.request.contextPath}/icomoon.ttf?87xwgt') format('truetype'),
            url('${pageContext.request.contextPath}/fonts/icomoon.woff?87xwgt') format('woff'),
            url('${pageContext.request.contextPath}/fonts/icomoon.svg?87xwgt#icomoon') format('svg');
            font-weight: normal;
            font-style: normal;
            font-display: block;
        }
    </style>
    <link rel="shortcut icon" href="#">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/index.js"></script>
    <script type="text/javascript">
       window.onload=function () {
           var p=<%=session.getAttribute("veri")%>;
           console.log("p="+p);
           if(p!="fail"&&p!=null){
               $("#s1").hide();
               $("#s2").hide();
               $("#s3").show();
               $("#s4").show();
           }else{
               $("#s3").hide();
               $("#s4").hide();
               $("#s1").show();
               $("#s2").show();
           }
       }

       $(function () {
           $("#s4").click(function () {
                   $.ajax({
                       url:`${pageContext.request.contextPath}/exitac/ea`,
                       success:function(){
                           window.location.href="http://localhost:8080/Vivo_war_exploded/"
                       }

                   })
           })
       })
    </script>
</head>
<body>
      <div class="top_bar">

          <span class="top_bar_left">
              <a href="javascript:;"><li>品牌</li></a>
              <a href="javascript:;"><li>OriginOS</li></a>
              <a href="javascript:;"><li>体验店</li></a>
              <a href="javascript:;"><li>企业业务</li></a>
              <a href="javascript:;"><li>社区</li></a>
          </span>

          <span class="top_bar_right">
              <a href="javascript:;"><li>购物车</li></a>
              <a href="javascript:;" class="admin"> <li>个人中心</li></a>

              <!--注册/登录-->
          <div class="register_sign">
              <span id="s1" class="icom">  <a href="${pageContext.request.contextPath}/log/on">    登录</a></span>
              <span id="s2" class="icom">  <a href="${pageContext.request.contextPath}/registerinfo/register.action">   注册</a></span>
              <span id="s3" class="icom">  <a href="${pageContext.request.contextPath}/atcenter/pinformation.action">    账户中心</a></span>
              <span id="s4" class="icom">  <a href="javascript:;">   退出登录</a></span>
          </div>

          </span>


      </div>


</body>
</html>
