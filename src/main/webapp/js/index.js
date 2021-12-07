$(function () {

    $(".top_bar_right .admin").hover(function(){
      $(".register_sign").show();
    },function(){
            $(".register_sign").hide();
        }
    );
    $(".register_sign").hover(function(){
            $(".register_sign").show();
        },function(){
            $(".register_sign").hide();
        }
    );
    $(".search input").focus(function(){
        $(".search input").val("");
    })
    $(".carousel .image .list ul li").hover(function(){
        $(this).addClass("back")
        $(".carousel .image .side").fadeIn()
    },function(){
        $(this).removeClass("back")
        $(".carousel .image .side").stop(true).fadeOut(100)
    });
    var i=0;
    $(".carousel .image .images ol li").hover(function(){
        $(".carousel .image .images span li").stop().eq($(this).index()).fadeIn(300).siblings().fadeOut(300);
        $(this).stop().css("background","#d8ecf7").siblings().css("background","#a3a3a3");
        i=$(this).index()-1;
    });
    function e(){
        $(".carousel .image .images span li").stop().eq(i+1).fadeIn(400).siblings().fadeOut(0);
        $(".carousel .image .images ol li").eq(i+1).stop().css("background","#d8ecf7").siblings().css("background","#a3a3a3");
        i++;
        if(i==$(".carousel .image .images ol li").length-1){
            i=-1;
        };
    }
    setInterval(e,3000);
    $(".cooperation li").hover(function(){
        $(".cooperation li div").stop().fadeOut(100);
        $(this).find("div").stop().fadeIn();
    });
    $(".cooperation").hover(function(){},
        function(){
            $(".cooperation li div").stop().fadeOut(100);
        });
// 侧边颜色未完成

    $(window).scroll(function(){
        var bak=new Array("#5abd5a","black","#e67689","#09a8e7","#5abd5a","#c74747","#4cc4b4","black");
        var inde=$(".sidecalssfication li").length;
        var k=$(document).scrollTop();
        var p=0;
        for(p;p<inde;p++){
            if(k>=(p*500+1000)&&k<(p*500+1500)){
                $(".sidebar li").eq(p).css("background",bak[p]).siblings().css("background","#626262");
            }
            if(k>=5000){
                $(".sidebar li").eq(7).css("background",bak[7]).siblings().css("background","#626262");
            }
        }
        if($(document).scrollTop()>=600){
            $(".sidebar").slideDown();
            var i= $(document).scrollTop()+120;
            $(".sidebar").css("top",i);
        }else{
            $(".sidebar").slideUp();
        }
    });
    $(".sidebar li").click(function(){
        var p=$(this).index();
        var hg=$(".sidecalssfication li").eq(p).offset().top-90;
        $("body, html").stop().animate({
            scrollTop:hg
        })
    });
    $(".sidebar span").eq(1).click(function(){
        $("body, html").stop().animate({
            scrollTop:0
        })
    });


});