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
           var p=<%=session.getAttribute("veri")%>
           if(p!=null){
               $("#s1").hide();
               $("#s2").hide();
               $("#s3").show();
               $("#s4").show();
               $("#s5").show()
               $(".top_bar .register_sign").css({
                   "height":"120px"
               })

               $.ajax({
                   url:`${pageContext.request.contextPath}/homepage/attendance`,
                   success:function (data) {
                       $.ajax({
                           url:`${pageContext.request.contextPath}/homepage/currenttime`,
                           success:function (data) {
                               $(".calendar_frame .top_bars span:nth-child(2)").html(data[0]+" / "+data[1]+" / "+data[2])
                           }
                       })
                       var p=data.length;
                       var l=0;
                       var q=0;
                       for(var i=1;i<=p;i++){

                           if(data[i-1]==-2){
                               $(".calendar_frame .ool").append("<span class='day'></span>")
                               l++
                           }else{
                               q=i-l
                               $(".calendar_frame .ool").append("<span class='day'>"+q+"</span>")
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("l")
                           }
                           if(i/7==0){
                               $(".calendar_frame .ool").append("<br>")
                           }
                           if(data[i-1]==-1){
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("s")
                           }else if(data[i-1]==0){
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("p")
                           }else if(data[i-1]==1){
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("w")
                           }
                       }
                   }
               })

           }else{
               $("#s3").hide();
               $("#s4").hide();
               $("#s5").hide();
               $("#s1").show();
               $("#s2").show()
               $(".top_bar .register_sign").css({
                   "height":"80px"
               })
           }
           $(".calendar_frame").hide();
       }


       $(function () {

           $(".calendar_frame .top_bars span:nth-child(2)").click(function () {
                   $.ajax({
                       url:`${pageContext.request.contextPath}/homepage/cus`,
                       success:function () {
                           $.ajax({
                               url:`${pageContext.request.contextPath}/homepage/attendance`,
                               success:function (data) {
                                   $(".calendar_frame .ool").empty()
                                   $.ajax({
                                       url:`${pageContext.request.contextPath}/homepage/currenttime`,
                                       success:function (data) {
                                           $(".calendar_frame .top_bars span:nth-child(2)").html(data[0]+" / "+data[1]+" / "+data[2])
                                       }
                                   })

                                   var p=data.length;
                                   var l=0;
                                   var q=0;
                                   for(var i=1;i<=p;i++){
                                       if(data[i-1]==-2){
                                           $(".calendar_frame .ool").append("<span class='day'></span>")
                                           l++
                                       }else{
                                           q=i-l
                                           $(".calendar_frame .ool").append("<span class='day'>"+q+"</span>")
                                           $(".calendar_frame .ool span:nth-child("+i+")").addClass("l")
                                       }
                                       if(i/7==0){
                                           $(".calendar_frame .ool").append("<br>")
                                       }
                                       if(data[i-1]==-1){
                                           $(".calendar_frame .ool span:nth-child("+i+")").addClass("s")
                                       }else if(data[i-1]==0){
                                           $(".calendar_frame .ool span:nth-child("+i+")").addClass("p")
                                       }else if(data[i-1]==1){
                                           $(".calendar_frame .ool span:nth-child("+i+")").addClass("w")
                                       }
                                   }
                               }
                           })
                       }
                   })
           })

           $(".calendar_frame .top_bars span:nth-child(1)").click(function () {
               $.ajax({
                   url:`${pageContext.request.contextPath}/homepage/attendance`,
                   data:{
                       "swicths":"-1",
                   },
                   success:function (data) {
                       $(".calendar_frame .ool").empty()

                       $.ajax({
                           url:`${pageContext.request.contextPath}/homepage/currenttime`,
                           success:function (data) {
                               $(".calendar_frame .top_bars span:nth-child(2)").html(data[0]+" / "+data[1]+" / "+data[2])
                           }
                       })

                       var p=data.length;
                       var l=0;
                       var q=0;
                       for(var i=1;i<=p;i++){
                           if(data[i-1]==-2){
                               $(".calendar_frame .ool").append("<span class='day'></span>")
                               l++;
                           }else{
                               q=i-l
                               $(".calendar_frame .ool").append("<span class='day'>"+q+"</span>")
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("l")
                           }
                           if(i/7==0){
                               $(".calendar_frame .ool").append("<br>")
                           }
                           if(data[i-1]==-1){
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("s")
                           }else if(data[i-1]==0){
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("p")
                           }else if(data[i-1]==1){
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("w")
                           }
                       }
                   }
               })
           })

           $(".calendar_frame .top_bars span:nth-child(3)").click(function () {
               $.ajax({
                   url:`${pageContext.request.contextPath}/homepage/attendance`,
                   data:{
                       "swicths":"1",
                   },
                   success:function (data) {
                       $(".calendar_frame .ool").empty()
                       $.ajax({
                           url:`${pageContext.request.contextPath}/homepage/currenttime`,
                           success:function (data) {
                               $(".calendar_frame .top_bars span:nth-child(2)").html(data[0]+" / "+data[1]+" / "+data[2])
                           }
                       })
                       var p=data.length;
                       var l=0;
                       var q=0;
                       for(var i=1;i<=p;i++){
                           q=i;
                           if(data[i-1]==-2){
                               $(".calendar_frame .ool").append("<span class='day'></span>")
                               l++;
                           }else{
                               q=i-l;
                               $(".calendar_frame .ool").append("<span class='day'>"+q+"</span>")
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("l")
                           }
                           if(i/7==0){
                               $(".calendar_frame .ool").append("<br>")
                           }
                           if(data[i-1]==-1){
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("s")
                           }else if(data[i-1]==0){
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("p")
                           }else if(data[i-1]==1){
                               $(".calendar_frame .ool span:nth-child("+i+")").addClass("w")
                           }
                       }
                   }
               })
           })

           $("#s5").click(function () {
               $(".calendar_frame").show()
           })

           $("#ret").click(function () {
               $(".calendar_frame").hide()
           })

           $("#s4").click(function () {
                   $.ajax({
                       url:`${pageContext.request.contextPath}/exitac/ea`,
                       success:function(){
                           window.location.href="http://localhost:8080/Vivo_war_exploded/"
                       }
                   })
           })

           $(".calendar_frame .ool .l").click(function () {
               $(this).addClass("cli").siblings().removeClass("cli")
           })

           $(".calendar_frame .ool .s").click(function () {
               $(".calendar_frame .atten span:nth-child(1)").text("补签")
               $(".calendar_frame .atten span:nth-child(1)").css({
                   "background":"red",
                   "color":"white"
               })
           })

           $(".calendar_frame .ool .w").click(function () {
               $(".calendar_frame .atten span:nth-child(1)").text("已签到")
               $(".calendar_frame .atten span:nth-child(1)").css({
                   "background":"#e2e2e2",
                   "color":"white"
               })
           })

           $(".calendar_frame .ool .s").click(function () {
               $(".calendar_frame .atten span:nth-child(1)").html("签到")
               $(".calendar_frame .atten span:nth-child(1)").css({
                   "background":"#green",
                   "color":"white"
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
              <span id="s5" class="icom"> <a href="javascript:;">    签到</a></span>
              <span id="s4" class="icom">  <a href="javascript:;">   退出登录</a></span>
          </div>

          </span>

      </div>

      <div class="series" id="seri">

           <div class="center" id="cent">
               <ll>vivo</ll>
               <span class="drop_down" id="ddwon">
                       <li>NEX系列</li>
                       <li>X系列</li>
                       <li>S系列</li>
                       <li>Y系列</li>
                       <li>IQOO手机</li>
                       <li>智能硬件</li>
                       <a href="javascript:;"><li>商城</li></a>
                       <a href="javascript:;"><li>服务</li></a>
               </span>
           </div>

      </div>

      <script type="text/javascript">



      </script>

      <div class="calendar_frame" style="background: url(${pageContext.request.contextPath}/img/attendence.jpg) no-repeat;background-size:100% 100%">
          <div class="top_bars">
              <span>上个月</span>
              <span></span>
              <span>下个月</span>
          </div>
          <div class="hrs"></div>

          <div class="week">
              <span>一</span>
              <span>二</span>
              <span>三</span>
              <span>四</span>
              <span>五</span>
              <span>六</span>
              <span>七</span>
          </div>

          <div class="hrs"></div>

          <div class="ool">

          </div>

          <div class="atten">
              <span>签到</span>
              <span id="ret">返回</span>
          </div>

      </div>

</body>
</html>
