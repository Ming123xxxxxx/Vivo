<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/12/8
  Time: 15:28
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>社区</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/communitys.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <style>
        @font-face {
            font-family: 'icomoon';
            src: url('${pageContext.request.contextPath}/fonts/icomoon.eot?ijeeu0');
            src: url('${pageContext.request.contextPath}/fonts/icomoon.eot?ijeeu0#iefix') format('embedded-opentype'),
            url('${pageContext.request.contextPath}/fonts/icomoon.ttf?ijeeu0') format('truetype'),
            url('${pageContext.request.contextPath}/fonts/icomoon.woff?ijeeu0') format('woff'),
            url('${pageContext.request.contextPath}/fonts/icomoon.svg?ijeeu0#icomoon') format('svg');
            font-weight: normal;
            font-style: normal;
            font-display: block;
        }
    </style>
    <link rel="shortcut icon" href="#">
    <script type="text/javascript">

        function x() {
            var p=$("#personals option:selected").val()
            if(p==1){
               window.location.reload();
            }
            if(p==2){
                $.ajax({
                    url:`${pageContext.request.contextPath}/artice/select`,
                    data:{
                        "vl":p,
                    },
                    success:function (data) {
                        if(data!=0) {
                            window.location.href = data;
                        }
                    }
                })
            }

            if(p==3){
                $(".informa .publishes").empty()
                $(".informa .publishes").show()
                $(".informa .allbookss").hide()
                $(".informa .collectionss").hide()
                $.ajax({
                    url:`${pageContext.request.contextPath}/community/publishbook`,
                    success:function (data) {
                        var i=0;
                        for (i;i<data.length;i++) {
                            $(".informa .publishes").append(
                                "<ul>"
                                   +
                                    "<li><a href=javascript:;>"+data[i].hot+"</a></li>"+
                                    "<li><a href=${pageContext.request.contextPath}/community/readtext?name="+data[i].name+">"+data[i].title+"</a>"+"</li>"+
                                    "<li>"+data[i].author+"</li>"+
                                    "<li>"+data[i].times+"</li>"+
                                    "<li>"+
                                          "<a href=${pageContext.request.contextPath}/community/readtext?name="+data[i].name+">"+"修改"+"</a>"+"   |   "+
                                          "<a href=${pageContext.request.contextPath}/community/deletebooks?textname="+data[i].name+">"+"删除"+"</a>"+"   |   "+"<select style='width:120px;height:25px'>"+
                                           "<option>"+"点赞数:"+data[i].up+"</option>"+
                                           "<option>"+"点踩数:"+data[i].low+"</option>"+
                                           "<option>"+"收藏数:"+data[i].collection+"</option>"+
                                           "<option>"+"下载数:"+data[i].download+"</option>"
                                           +"</select>"
                                          +
                                    "</li>"

                                +"</li>"+
                                "</ul>"
                            )
                        }
                    }
                })
            }

            if(p==4){
                $(".informa .collectionss").empty()
                $(".informa .collectionss").show()
                $(".informa .publishes").hide()
                $(".informa .allbookss").hide()
                $.ajax({
                    url:`${pageContext.request.contextPath}/community/collectionbooks`,
                    success:function (data) {
                        var i=0;
                        for (i;i<data.length;i++) {
                            $(".informa .collectionss").append(
                                "<ul>"
                                +
                                "<li><a href=javascript:;>"+data[i].hot+"</a></li>"+
                                "<li><a href=${pageContext.request.contextPath}/community/readtext?name="+data[i].name+">"+data[i].title+"</a>"+"</li>"+
                                "<li>"+data[i].author+"</li>"+
                                "<li>"+data[i].times+"</li>"+
                                "<li>"+
                                "<a href=${pageContext.request.contextPath}/community/cancelcollection?textname="+data[i].name+">"+"取消收藏"+"</a>"+"   |   "+
                                 "<select style='width:120px;height:25px'>"+
                                "<option>"+"点赞数:"+data[i].up+"</option>"+
                                "<option>"+"点踩数:"+data[i].low+"</option>"+
                                "<option>"+"收藏数:"+data[i].collection+"</option>"+
                                "<option>"+"下载数:"+data[i].download+"</option>"
                                +"</select>"
                                +
                                "</li>"

                                +"</li>"+
                                "</ul>"
                            )
                        }
                    }
                })

        }
        }

        $(function () {
            $(".icom").click(function () {
                $(this).css(
                    "color","#e67689"
                )
            })

            $(".icom:nth-child(1)").click(function () {
                $(this).css(
                    "color","#e67689"
                )
                $(".icom:nth-child(2)").css(
                    "color","black"
                )
            })

            $(".icom:nth-child(2)").click(function () {
                $(this).css(
                    "color","#e67689"
                )
                $(".icom:nth-child(1)").css(
                    "color","black"
                )
            })


        })

        setInterval(function xxss(){
            $.ajax({
                url:`${pageContext.request.contextPath}/community/getnewbooks`,
                success:function (data) {
                    if(data!=""){
                        var i=0;
                        for (i;i<data.length;i++) {
                            $(".informa .allbookss").append(

                                ' <ul>\n' +
                                '                      <li style="margin-left: 30px"><a href="javascript:;">'+data[i].hot+'</a></li>\n' +
                                '                      <li title="'+data[i].title+'"><a  href="${pageContext.request.contextPath}/community/readtext?name='+data[i].name+'" class="tils">'+data[i].title+'</a></li>\n' +
                                '                      <li>'+data[i].author+'</li>\n' +
                                '                      <li>'+data[i].times+'</li>\n' +
                                '                      <li>\n' +
                                '                          <a  style="color: '+data[i].upcolor+'" href="${pageContext.request.contextPath}/community/operations?name='+data[i].name+'&type=up" class="icom" style="color:'+data[i].upcolor+'">:'+data[i].up+'</a>\n' +
                                '                          <a  style="color: '+data[i].lowcolor+'" href="${pageContext.request.contextPath}/community/operations?name='+data[i].name+'&type=low" class="icom">:'+data[i].low+'</a>\n' +
                                '                          <a  style="color:'+data[i].collectioncolor+'" href="${pageContext.request.contextPath}/community/operations?name='+data[i].name+'&type=collections" class="icom"> :'+data[i].collection+'</a>\n' +
                                '                          <a  href="${pageContext.request.contextPath}/artice/testDown?name='+data[i].name+'" class="icom"> :'+data[i].download+'</a>\n' +
                                '                      </li>\n' +
                                '                  </ul>'
                            )
                        }
                    }
                }
            })
        },4000)

    </script>
</head>
<body>

       <div class="top_bar">
           <a href="${pageContext.request.contextPath}/homepage/index">   <span style="background-color: #09a8e7;">主页</span>    </a>
           <a href="${pageContext.request.contextPath}/chartsroom/into">    <span style="background-color:#db5860;">聊天室</span>  </a>
           <a href="${pageContext.request.contextPath}/atcenter/pinformation.action">    <span style="background-color:green;">账户</span>  </a>
       </div>

       <div class="options">
           <span style="margin-left: 75px">热度</span>
           <span style="margin-left: 230px">标题</span>
           <span style="margin-left: 270px">作者</span>
           <span style="margin-left: 90px">发布时间</span>
           <span style="margin-left: 155px">操作</span>
           <span style="margin-left: 40px">
               <select id="personals" onchange="x()">
                    <option >干些什么</option>
                    <option value="1">查看文章</option>
                    <option value="2">发布文章</option>
                    <option value="3">查看已发文章</option>
                    <option value="4">查看收藏的文章</option>
               </select>
           </span>
       </div>

       <div class="informa">
          <div class="allbookss">
              <c:forEach var="ArticlesPojo" items="${books}">
                  <ul>
                      <li style="margin-left: 30px"><a href="javascript:;">${ArticlesPojo.hot}</a></li>
                      <li title="${ArticlesPojo.title}"><a  href="${pageContext.request.contextPath}/community/readtext?name=${ArticlesPojo.name}" class="tils">${ArticlesPojo.title}</a></li>
                      <li>${ArticlesPojo.author}</li>
                      <li>${ArticlesPojo.times}</li>
                      <li>
                          <a  style="color: ${ArticlesPojo.upcolor}" href="${pageContext.request.contextPath}/community/operations?name=${ArticlesPojo.name}&type=up" class="icom" style="color: ${ArticlesPojo.upcolor}">:${ArticlesPojo.up}</a>
                          <a  style="color: ${ArticlesPojo.lowcolor}" href="${pageContext.request.contextPath}/community/operations?name=${ArticlesPojo.name}&type=low" class="icom">:${ArticlesPojo.low}</a>
                          <a  style="color: ${ArticlesPojo.collectioncolor}" href="${pageContext.request.contextPath}/community/operations?name=${ArticlesPojo.name}&type=collections" class="icom"> :${ArticlesPojo.collection}</a>
                          <a  href="${pageContext.request.contextPath}/artice/testDown?name=${ArticlesPojo.name}" class="icom"> :${ArticlesPojo.download}</a>
                      </li>
                  </ul>
              </c:forEach>
          </div>
           
          <div class="publishes" style="display: none">

          </div> 
           
           <div class="collectionss" style="display:none;">

           </div>
       </div>



</body>
</html>
