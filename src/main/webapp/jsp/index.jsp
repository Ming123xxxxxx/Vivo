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

        $(window).unload(function () {
            $.ajax({
                url:`${pageContext.request.contextPath}/homepage/getonoff`,
                success:function (p) {
                    if(p==1){
                    $.ajax({
                        url:`${pageContext.request.contextPath}/exitac/ea`,
                    })
                }
           }
        })
       })

       window.onload=function () {
           $.ajax({
               url:`${pageContext.request.contextPath}/homepage/getonoff`,
               success:function (p) {
                   if(p==1){
                       $("#s1").hide();
                       $("#s2").hide();
                       $("#s3").show();
                       $("#s4").show();
                       $("#s5").show();
                       $("#s6").hide();

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
                       $("#s2").show();
                       $("#s6").show();
                   }
               }
           })

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
                       success:function(data){
                           window.location.href=data
                       }
                   })
           })

       })

       $(function () {
           //点击会给当前的class=.l的span添加.cli,其他除去cli
           $(".calendar_frame .ool .l").click(function () {
               $(this).addClass("cli").siblings().removeClass("cli")
           })
           //点击此事件会出现补签事件
           $(".calendar_frame .ool .p").click(function () {
               console.log("ppppp")
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
              <span id="s6" class="icom">  <a href="${pageContext.request.contextPath}/admin/jump">    管理员登录</a></span>
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
              <span id="ret">返回</span>
          </div>

      </div>

      <!-- 搜索层 -->
      <div class="search template">
          <img src="${pageContext.request.contextPath}/img/cat.gif"/>
          <input type="text" placeholder="&nbsp;&nbsp;&nbsp;搜索 天猫 商品/品牌/店铺">
          <button>搜索</button>
      </div>

      <!-- 物品分类 -->
      <div class="classification template">
          <div class="moudule"><span class="icom"></span>商品分类</div>
          <img src="${pageContext.request.contextPath}/img/supermarket2.png" style="margin-left: 3px;"/>
          <img src="${pageContext.request.contextPath}/img/international.png"  style="left: 330px;"/>
          <span class="often">
      <span><a href="#">天猫会员</a></span>
      <span><a href="#">电器城</a></span>
      <span><a href="#">喵鲜生</a></span>
      <span><a href="#">医药馆</a></span>
      <span><a href="#">魅力惠</a></span>
      <span><a href="#">飞猪旅行</a></span>
      <span><a href="#">苏宁易购</a></span>
    </span>
      </div>

      <div class="hr"></div>
      <!-- 轮播图 -->
      <div class="carousel">
          <div class="image template">
      <span class="list">
      <ul>
        <a href="#">
          <li>女装/内衣</li>
        </a>
        <a href="#"><li>男装/运动户外</li></a>
        <a href="#"><li>女鞋/男鞋/箱包</li></a>
        <a href="#"><li>美妆/个人护理</li></a>
        <a href="#"><li>腕表/眼睛/珠宝饰品</li></a>
        <a href="#"><li>手机/数码/电脑办公</li></a>
        <a href="#"><li>母婴玩具</li></a>
        <a href="#"><li>零食/茶酒/进口食品</li></a>
        <a href="#"><li>生鲜水果</li></a>
        <a href="#"><li>大家电/生活电器</li></a>
        <a href="#"><li>家具建材</li></a>
        <a href="#"><li>汽车/配件/用品</li></a>
        <a href="#"><li>家纺/家纺/鲜花</li></a>
        <a href="#"><li>医药保健</li></a>
        <a href="#"><li>厨具/收纳/宠物</li></a>
        <a href="#"> <li>图书音像</li></a>
      </ul>
    </span>
              <span class="side">
      <span  class="lef">
     <ul>
       <li style="margin-top: 20px;">当季流行 ></li>
       <li>精选上装 ></li>
       <li>浪漫裙装 ></li>
       <li>女士下装 ></li>
       <li>特色女装 ></li>
       <li>文胸塑身 ></li>
       <li>家居服 ></li>
       <li>内裤背心 ></li>
     </ul>
    </span>
    <span class="rig">
     <ul>
      <li>女装新品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商场同款&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;仙女连衣裙&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;T恤&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;衬衫&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;时髦外套&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;休闲裤&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牛仔裤</br>
          </br>
          无痕文胸&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;运动文胸&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;潮流家居服&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;百搭船袜</li>
      <li style="margin-top: 13px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;毛呢外套&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;羽绒服&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;棉服&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;丝绒卫衣&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;毛针织衫&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;皮毛一体&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;皮草毛衣&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        衬衫卫衣&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          </br>
          </br>
          针织衫&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;T恤&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;短外套&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;小西装&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;风衣</li>
      <li> </li>
      <li> </li>
      <li> </li>
      <li> </li>
      <li> </li>
      <li> </li>
     </ul>
    </span>
    </span>
              <ul class="images">
                  <ol>
                      <li class="one"></li>
                      <li></li>
                      <li></li>
                      <li></li>
                      <li></li>
                      <li></li>
                      <li></li>
                  </ol>
                  <span>
    <li><img src="${pageContext.request.contextPath}/img/bautique.jpg" style="z-index: 2;display: block;"/></li>
    <li><img src="${pageContext.request.contextPath}/img/skycat.png" /></li>
    <li><img src="${pageContext.request.contextPath}/img/honest.jpg" /></li>
    <li><img src="${pageContext.request.contextPath}/img/newgoods.jpg" /></li>
    <li><img src="${pageContext.request.contextPath}/img/party.jpg"  /></li>
    <li><img src="${pageContext.request.contextPath}/img/snacks.jpg" /></li>
    <li><img src="${pageContext.request.contextPath}/img/Christmas.jpg" /></li>
              </ul>
              </span>
              <!-- <img src="E:\天猫\image\party.jpg" > -->
          </div>
      </div>

      <!-- 侧边条 -->
      <div class="sidebar">
          <span style="background-color: #ff0036;line-height: 36px">导航</span>
          <ul>
              <li>天猫<br>超市</li>
              <li>天猫<br>国际</li>
              <li>美丽<br>人生</li>
              <li>酷电<br>潮玩</li>
              <li>居家<br>生活</li>
              <li>打造<br>爱巢</li>
              <li>户外<br>出行</li>
              <li>猜你<br>喜欢</li>
          </ul>
          <span style="background-color: #ababab;margin-top: 1px;">返回<br>顶部</span>
      </div>

      <!-- 合作品牌 -->
      <div class="cooperation">
          <ul class="one">
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
          </ul>
          <ul class="two">
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
          </ul>
          <ul class="three">
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
              <li>
                  <img src="${pageContext.request.contextPath}/img/litte.png" />
                  <div>优惠券￥40
                      <span>点击进入</span>
                  </div>
              </li>
          </ul>
      </div>

      <!-- 侧边条分类 -->
      <div class="sidecalssfication">
          <ul>
              <li><span style="top: -37px;"><img src="${pageContext.request.contextPath}/img/catsupermarket.png" /></span></li>
              <li><span style="top: 514px;"><img src="${pageContext.request.contextPath}/img/supermarket.png" /></span></li>
              <li><span style="top: 1064px;" class="verline">美丽人生&nbsp;&nbsp; &nbsp;FASHION & BEAUTY</span></li>
              <li><span style="top: 1615px;" class="verline">酷电潮玩&nbsp;&nbsp; &nbsp;ELECTRONICS</span></li>
              <li><span style="top: 2165px;" class="verline">居家生活&nbsp;&nbsp; &nbsp;GROCERY & HEALTH</span></li>
              <li><span style="top: 2715px;" class="verline">打造爱巢&nbsp;&nbsp; &nbsp;HOME</span></li>
              <li><span style="top: 3264px;" class="verline">户外出行&nbsp;&nbsp; &nbsp;OUTDOORS & AUTOMOTIVE</span></li>
              <li><span style="top: 3814px;left: 43%;">--<i class="icom"></i>   猜你喜欢--</span></li>
          </ul>
      </div>
      <!-- 尾部介绍 -->
      <div class="introduce">
  <span class="guarantee ">
    <ul>
      <a><li>
      <p>品质保障</p>
      品质护航，购物无忧
      </li>
    </a>
      <a><li>
       <p>七天无理由退货</p>
      为你提供售后无忧保障
      </li>
    </a>
      <a><li>
        <p>特色服务体验</p>
        为你呈现不一样的服务
      </li>
    </a>
      <a><li>
       <p>帮助中心</p>
       你的购物指南
     </li>
    </a>
    </ul>
  </span>
          <span>

   </span>
      </div>
      <div class="bottombar">

      </div>
</body>
</html>
