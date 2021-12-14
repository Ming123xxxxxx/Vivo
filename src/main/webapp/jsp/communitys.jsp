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
        }
    </script>
</head>
<body>

       <div class="top_bar">
           <a href="${pageContext.request.contextPath}/homepage/index">   <span style="background-color: #09a8e7;">主页</span>    </a>
           <a href="${pageContext.request.contextPath}/atcenter/pinformation.action">    <span style="background-color:green;">账户</span>  </a>
       </div>

       <div class="options">
           <span style="margin-left: 600px">标题</span>
           <span style="margin-left: 330px">作者</span>
           <span style="margin-left: 180px">发布时间</span>
           <span style="margin-left: 200px">操作</span>
           <span style="margin-left: 250px">
                  <select>
                    <option>条件选择</option>
                    <option>按热度降序</option>
                    <option>按热度升序</option>
                    <option>按时间降序</option>
                    <option>按时间升序</option>
                    <option>按点赞数降序</option>
                    <option>按点赞数升序</option>
                </select>
            </span>
           <span style="margin-left: 50px">
               <select id="personals" onchange="x()">
                    <option >干些什么</option>
                    <option value="1">发布文章</option>
                    <option value="2">查看已发文章</option>
                    <option value="3">修改文章</option>
                    <option value="4">删除文章</option>
                    <option value="5">查看收藏的文章</option>
               </select>
           </span>
       </div>

       <div class="informa">
           <c:forEach var="ArticlesPojo" items="${books}">
               <ul>
                   <li><a  href="javascript:;" class="tils">${ArticlesPojo.title}</a></li>
                   <li>${ArticlesPojo.author}</li>
                   <li>${ArticlesPojo.times}</li>
                   <li>
                       <a href="${pageContext.request.contextPath}/admin/forcuoff?account=${ArticlesPojo.name}" class="icom"></a>
                       <a href="${pageContext.request.contextPath}/admin/forcuoff?account=${ArticlesPojo.name}" class="icom"></a>
                       <a href="${pageContext.request.contextPath}/admin/delus?account=${ArticlesPojo.name}" class="icom"> </a>
                       <a href="${pageContext.request.contextPath}/admin/delus?account=${ArticlesPojo.name}" class="icom"> </a>
                   </li>
               </ul>
           </c:forEach>
       </div>



</body>
</html>
