<%--
  Created by IntelliJ IDEA.
  User: 温黎明
  Date: 2021/12/8
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/artices.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript">

        window.onload=function () {
            $.ajax({
                url:`${pageContext.request.contextPath}/homepage/dact`,
                success:function(data) {
                    if(data!="0"){
                        window.location.href=data;
                    }
                }
            })

            $("#uploads").hide();
        }

          function x() {
               var p = $("#sele option:selected").val();
               if(p!=undefined){
                   $("#textar").css("font-size",""+p+"");
               }
          }

          function p() {
              var p = $("#cols option:selected").val();
              if(p!=undefined){
                  $("#textar").css("color",""+p+"");
              }
          }

           $(function () {
               $(".uporwrite #s1").click(function () {
                   $("#uploads").hide();
                   $("#write").show();
                   $("#s1").css("background-color","white");
                   $("#s2").css("background-color","#e67689")
               })

               $(".uporwrite #s2").click(function () {
                   $("#uploads").show();
                   $("#write").hide();
                   $("#s2").css("background-color","white");
                   $("#s1").css("background-color","#e67689")
               })
           })

    </script>
</head>
<body>
    <div class="uporwrite">
        <span id="s1">输入文本</span>
        <span id="s2">上传文本</span>
    </div>
    <div style="margin-left: 400px;" id="write">
        <select id="sele" onchange="x()" style="margin-right: 50px">
            <option>设置字体大小</option>
            <option value="10">10</option>
            <option value="15">15</option>
            <option value="20">20</option>
            <option value="25">25</option>
        </select>

        <select id="cols" onchange="p()">
            <option>设置字体颜色</option>
            <option value="black">黑色</option>
            <option value="red">红色</option>
            <option value="yellow">黄色</option>
            <option value="green">绿色</option>
        </select>
        <br>
        <form action="${pageContext.request.contextPath}/artice/writetext" method="post">
            <input name="titl" type="text" placeholder="请输入标题" maxlength="20" style="height: 40px;width: 1200px;margin-bottom: 30px">
            <textarea name="filetxt" class="arct" maxlength="15000" id="textar" style="resize: none;border: none;outline: none;margin-bottom: 10px"></textarea><br>
            <input type="submit" style="width: 1200px;height: 40px" id="sub">
        </form>
    </div>

    <div id="uploads" style="margin-left: 400px;">
        <form action="${pageContext.request.contextPath}/artice/upload" method="post" enctype="multipart/form-data">
            <input name="titls" type="text" placeholder="请输入标题" maxlength="20" style="height: 40px;width: 1200px;margin-top: 15px">
            <br>
            <input type="file"  name="files" style="margin-left: 500px;margin-top: 20px;margin-bottom: 15px" id="fi"><br>
            <input type="submit" style="width: 1200px;height: 40px" id="subss">
        </form>
    </div>

</body>
</html>
