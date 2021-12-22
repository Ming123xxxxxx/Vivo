<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/12/21
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>聊天室</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatrooms.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript">
       $(function () {
           $(".home .inputframe .sub").click(function () {
               var p=$(".home .inputframe .textframe").val()

               $.ajax({
                   url:`${pageContext.request.contextPath}/chartsroom/getchatrecods`,
                   data:{
                       "records":p,
                   },
                   success:function (data) {

                       if(data!=""){
                           $(".home .chatframe").append(
                               "<ul style='text-align:right;display: block;color: red;margin-right: 50px'>"+
                               "<li>"+
                               data+":"+p
                               +"</li>"
                               +"</ul>"
                           )
                       }else {
                           alert("请登录账号");
                       }

                   }
               })
               $(".home .inputframe .textframe").val("")
           })
       })

       setInterval(function xxss(){
           $.ajax({
               url:`${pageContext.request.contextPath}/chartsroom/getallrecords`,
               success:function (data) {
                   if(data!=""){
                       var p=0;
                       console.log("data="+data);
                       for(p;p<data.length;p++){
                           if(data[p].commentcolor=="red"){
                               $(".home .chatframe").append(
                                   "<ul style='text-align:right;display: block;color: red;margin-right: 50px'>"+
                                   "<li>"+
                                   data[p].criticname+":" +data[p].comment
                                   +"</li>"
                                   +"</ul>"
                               )
                           }else{
                               $(".home .chatframe").append(
                                   "<ul style='text-align:left;display: block;color: green;margin-left: 50px'>"+
                                   "<li>"+
                                   data[p].criticname+":" +data[p].comment
                                   +"</li>"
                                   +"</ul>"
                               )
                           }
                       }

                   }
               }
           })
       },1000)
    </script>
</head>
<body>

    <a  href="${pageContext.request.contextPath}/community/into">
        返回社区
    </a>
    <div class="home" style="position: relative">
        <div class="chatframe">
            <c:forEach var="ChatPojo" items="${chats}">
               <c:if test="${ChatPojo.commentcolor.equals('red')}">
                   <ul style="margin-right: 50px;text-align:right;display: block;">
                       <li  style="color: ${ChatPojo.commentcolor}">${ChatPojo.criticname}:${ChatPojo.comment}</li>
                   </ul>
               </c:if>
                <c:if test="${ChatPojo.commentcolor.equals('green')}">
                    <ul style="margin-left: 50px;text-align:left;display: block;">
                        <li style="color: ${ChatPojo.commentcolor}">${ChatPojo.criticname}:${ChatPojo.comment}</li>
                    </ul>
                </c:if>
            </c:forEach>
        </div>

       <div class="inputframe">
           <input type="type" class="textframe">
           <input type="submit" value="提交" class="sub">
       </div>
    </div>

</body>
</html>
