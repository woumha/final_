<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page session="false" pageEncoding="UTF-8" %>
<html>
<head>

<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
<link rel="stylesheet" href="/eunji_css/test.css">
		
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	
<style type="text/css">

	@media screen and (max-width: 992px) {
		.container1 div{
			width: 500px;
			justify-content: center;
		}
		
		#slide {
		    width: 800px;
		    height: 350px;
		    padding: 0 10%;
		    justify-content: space-between;
		    align-items: center;
		}	
		
	}	

	tr { display: block; float: left; }
	th, td { display: block; }	
	
	html, body {
		  margin: 0;
		  padding: 0;
		  text-align: center;
	}

	.group:after {
	  content: "";
	  display: table;
	  clear: both;
	}


	#side_wrap{
		display: flex;
	}
	
	#sidebar{
		flex: 1;
	}


	/*--------------------------------------- 상단 카테고리 바------------------------------------- */	
		#mainnav {
		    background: #333;
		    color: #fff;
		    font-weight: bold;
		    text-transform:uppercase;
		    letter-spacing: .05em;
		}
		
		#mainnav #menu {
		    display: none;
		    padding: .8em 1.5em;
		    cursor: pointer;
		}
		
		
		#mainnav ul {
		    display: block;
		    margin: 0;
		    margin-left: 8%;
		    text-align: center;
		}
		
		#mainnav ul li {
		    margin: 0;
		    list-style: none;
		    display: inline-block;
		}
		
		#mainnav ul li a {
		    color: #fff;
		    text-decoration: none;
		    display: inline-block;
		    padding: .9em 1.5em .8em 1.5em;
		}
		
		#mainnav ul li a:hover {
		    color: #000;
		    background: #fc942c;
		}
		
		.content {
			  padding: 1.5em;
		}
		
	
		@media all and (min-width: 768px) and (max-width: 992px) {
		
		}
		
		@media all and (max-width: 767px) {
			
		    #mainnav #menu {
		        display: block;
		    }
		
		    #mainnav ul {
		        display: none;
		        background: #666;
		        padding: 1em;
		        text-align: left;
		    }
		    #mainnav ul li {
		        display: block;
		    }
		
		    #mainnav ul li a {
		        display: block;
		        padding: .75em 1.5em .5em 1.5em;
		    }
		
		}  
		
		#all{
			background-color: #fc942c;
		}
		
      #video_list {
      	display: flex;
      	flex: 3;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		margin-left: 20%;
		margin-top: -235px;
   		}
     	
		video{
			width: 300px;
			height: 171px;
			border-radius: 10px;
		}
		
	#video_view_ctn, #video_title, #video_channel{
		padding-left: 6px;
		padding-top: 2px;
	}
	
     	
   /* --------------------------------------------글자 설정--------------------------------------- */ 
     	 
     	 td{
     	 	font-size: 0.8rem;
     	 }
     	 
     	 #video_title{
     		 font-size: 1rem;
     		 font-weight: bold;
     	 }
     	 
     	 
     /* -----------------------------------------캐러셀 설정------------------------------------------ */  	 
		
		#slide{
			 z-index: 10;
			
		}
		
		#slidebtn_wrap{
			display:flex;
		    width: 1303px;
		    height: 350px;
		    padding: 0 10%;
		    justify-content: space-between;
		    align-items: center;	
		}
		
		#prev{
			background-color: white;
			color: #5c3306;
			border: none;
		}
		
		#prev:hover{
			color: #fc942c;
		}
		
		#prev:focus {
   		 outline: none;
		}
		
		#next:focus {
   		 outline: none;
		}
		
		
		#next:hover{
			color: #fc942c;
		}
		
		#next{
			background-color: white;
			color: #5c3306;
			border: none;
		}
		
		#next i{
			font-size: 50;
		    background-color: white;
		    border: none;
		}
		
		#prev i{
			font-size: 50;
		    background-color: white;
		    border: none;
		}
		
		
		#section {
		  width: 40em;
		  height: 13em;
		  position: relative;
		  margin-top: 4%;
		  margin-left: 21%;
		  text-align: center;
		}	
		
		#section li {
		  width: 600px;
		  height: 320px;
		  background: #333;
		  display: inline-block;
		  -webkit-transition: all .3s ease-in-out;
		  -moz-transition: all .3s ease-in-out;
		  transition: all .3s ease-in-out;
		  overflow: hidden;
		  box-shadow: 0 2px 3px 0;
		  border-radius: 10px;
		}
		
		#section li p {
		  color: white;
		  font-weight: bold;
		  font-size: 5em;
		  text-align: center;
		  margin-top: 1.175em;
		}
		
		.items {
		  position: absolute;
		}
		
		.main-pos {
		  margin-left: 2em !important;
		  z-index: 3000;
		  /*background-image: url('https://dl.dropbox.com/u/32649907/imgs/shadow.png');*/
		}
		
		.left-pos {
		  opacity: .3;
		  margin-left: -17em !important;
		  z-index: 1000;
		  -webkit-transform: scale(.75);
		  -moz-transform: scale(.75);
		  transform: scale(.75);
		}
		
		.back-pos {
		  margin-left: 2em !important;
		  opacity: .05;
		  -webkit-transform: scale(.5);
		  -moz-transform: scale(.5);
		  transform: scale(.5);
		}
		
		.right-pos {
		  opacity: .3;
		  margin-left:  21em !important;
		  z-index: 1000;
		  -webkit-transform: scale(.75);
		  -moz-transform: scale(.75);
		  transform: scale(.75);
		}
		
		section span {
		  position: relative;
		  margin: 0 auto;
		  left: 17em;
		  top: 20em;
		} 
		
		     	
   /* ------------------------------------------------추천 동영상 라벨-------------------------------------------------  */
   
	  button {
	  margin: 20px;
	}
	.custom-btn {
	  width: 130px;
	  height: 40px;
	  color: #fff;
	  border-radius: 5px;
	  padding: 10px 25px;
	  font-family: 'Lato', sans-serif;
	  font-weight: 500;
	  background: transparent;
	  cursor: pointer;
	  transition: all 0.3s ease;
	  position: relative;
	  display: inline-block;
	   box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
	   7px 7px 20px 0px rgba(0,0,0,.1),
	   4px 4px 5px 0px rgba(0,0,0,.1);
	  outline: none;
	}
   
	 .re_btn {
	  margin-left: 20.2%;
   	  margin-top: 10%;
	  background: #333333;
	  border: none;
	  z-index: 1;
	  width: 200px;
	}
	
	.re_btn:after {
	  position: absolute;
	  content: "";
	  width: 0;
	  height: 100%;
	  top: 0;
	  right: 0;
	  z-index: -1;
	  background-color: #fc942c;
	  border-radius: 5px;
	   box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
	   7px 7px 20px 0px rgba(0,0,0,.1),
	   4px 4px 5px 0px rgba(0,0,0,.1);
	  transition: all 0.3s ease;
	}
	.re_btn:hover {
	  color: #fff;
	}
	.re_btn:hover:after {
	  left: 0;
	  width: 100%;
	}
	.re_btn:active {
	  top: 2px;
	}
	   
</style>

	<title>MAIN</title>
</head>

<body align="center">

<%-- 검색 필드 include 영역 --%>
<jsp:include page="./include/top_include.jsp"/>

<br>

<%-- 카테고리 영역 --%>

	<nav id="mainnav" class="group">
	    <div id="menu">&#x2261; Menu</div>
	    <ul>
	        <li id="all"><a href="#">전체</a></li>
	        <li><a href="#">음악</a></li>
	        <li><a href="#">게임</a></li>
	        <li><a href="#">요리</a></li>
	        <li><a href="#">스포츠</a></li>
	        <li><a href="#">뉴스</a></li>
	        <li><a href="#">최근에 업로드된 동영상</a></li>
	        <li><a href="#">관심 카테고리 동영상</a></li>
	    </ul>
	</nav>
	 	

<%-- 캐러셀 영역 --%>

<div id="slide_wrap">
	
		<div id="slide"> 
	
		<section id="section">
		  <ul class="carousel">
		    <li class="items main-pos" id="1">
		    <iframe width="600" height="320" src="https://www.youtube.com/embed/D1xoRXtzc8c" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items right-pos" id="2">
		      <iframe width="600" height="320" src="https://www.youtube.com/embed/UFovWG_A_fk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items back-pos" id="3">
		      <iframe width="600" height="320" src="https://www.youtube.com/embed/cnnmNdR2unQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items back-pos" id="4">
		    <iframe width="600" height="320" src="https://www.youtube.com/embed/M0O2YjP7ngw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items back-pos" id="5">
		     <iframe width="600" height="320" src="https://www.youtube.com/embed/Kmgo00avvEw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items back-pos" id="6">
		      <iframe width="600" height="320" src="https://www.youtube.com/embed/4Qry1Osot08" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		    <li class="items left-pos" id="7">
		    <iframe width="600" height="320" src="https://www.youtube.com/embed/I9vK5EVTt0U" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		    </li>
		  </ul>
		  
		  <div id = "slidebtn_wrap">
			<button id="prev"><i class="fa-solid fa-angles-left"></i></button>
			<button id="next"><i class="fa-solid fa-angles-right"></i></button>
		  </div>
		  
	</section>
    </div>
    	
  </div>  
	
	<br>
	
	<div id="re_label">
		<button class="custom-btn re_btn"><i class="fa-solid fa-ranking-star"></i>&nbsp;&nbsp;추천 동영상</button>
	</div>
	
	
<%-- 동영상 리스트 영역 --%>
	<div id = "video_list">  
		 <!-- 	<h4> 오늘의 추천 동영상 </h4> -->
		 <table cellspacing="0">
		 	<c:set var="list" value="${video_list }" />
	     	 <c:if test="${!empty list }">
				 <c:forEach items="${list }" var="dto">
				 
			        <tr>
			          <td colspan="1">
			          <video src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video></td>
			          <td id = "video_title">${dto.getVideo_title() }</td>
			          <td id ="video_channel">채널명 : ${dto.getChannel_name() }</td>
			          <td id = "video_view_ctn">조회수: ${dto.getVideo_view_cnt() } &nbsp; &nbsp; ${dto.getVideo_regdate() }</td>
			          <td>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>	
			        </tr>
			        
			        <tr>
						<td>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>		        
			        </tr>
					
					<br>
					
			 	</c:forEach>
			 </c:if>
			 
		   <c:if test="${empty list }">
	         <tr>
	            <td colspan="4" align="center">
	               <h3>동영상 리스트가 없습니다.....</h3>
	            </td>
	         </tr>
	      </c:if>
	      
		</table>	
	</div>
	 
	
<%-- 사이드바 영역 --%>
	
	<div id="side_wrap">
		<div id="sidebar">
			<jsp:include page="./include/side_include.jsp"/>
		</div>
	</div>
	
</body>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
		<script>
		//----------------------------------------------------------------------카테고리------------------------------------------------------------------------
			$(document).ready(function() {
			   
		      // JQUERY NAV TOGGLE
		      $('#menu').bind('click',function(event){
		          $('#mainnav ul').slideToggle();
		      });
		
		      $(window).resize(function(){  
		          var w = $(window).width();  
		          if(w > 768) {  
		              $('#mainnav ul').removeAttr('style');  
		          }  
		      });
				
			});

	</script>
	
	<script type="text/javascript">
	
	
	//----------------------------------------------------------------------캐러셀------------------------------------------------------------------------

		
	//slideshow style interval
	var autoSwap = setInterval( swap,3500);
	
	//pause slideshow and reinstantiate on mouseout
	$('ul, span').hover(
	  function () {
	    clearInterval(autoSwap);
	}, 
	  function () {
	   autoSwap = setInterval( swap,3500);
	});
	
	//global variables
	var items = [];
	var startItem = 1;
	var position = 0;
	var itemCount = $('.carousel li.items').length;
	var leftpos = itemCount;
	var resetCount = itemCount;
	
	//unused: gather text inside items class
	$('li.items').each(function(index) {
	    items[index] = $(this).text();
	});
	
	//swap images function
	function swap(action) {
	  var direction = action;
	  
	  //moving carousel backwards
	  if(direction == 'counter-clockwise') {
	    var leftitem = $('.left-pos').attr('id') - 1;
	    if(leftitem == 0) {
	      leftitem = itemCount;
	    }
	    
	    $('.right-pos').removeClass('right-pos').addClass('back-pos');
	    $('.main-pos').removeClass('main-pos').addClass('right-pos');
	    $('.left-pos').removeClass('left-pos').addClass('main-pos');
	    $('#'+leftitem+'').removeClass('back-pos').addClass('left-pos');
	    
	    startItem--;
	    if(startItem < 1) {
	      startItem = itemCount;
	    }
	  }
	  
	  //moving carousel forward
	  if(direction == 'clockwise' || direction == '' || direction == null ) {
	    function pos(positionvalue) {
	      if(positionvalue != 'leftposition') {
	        //increment image list id
	        position++;
	        
	        //if final result is greater than image count, reset position.
	        if((startItem+position) > resetCount) {
	          position = 1-startItem;
	        }
	      }
	    
	      //setting the left positioned item
	      if(positionvalue == 'leftposition') {
	        //left positioned image should always be one left than main positioned image.
	        position = startItem - 1;
	      
	        //reset last image in list to left position if first image is in main position
	        if(position < 1) {
	          position = itemCount;
	        }
	      }
	   
	      return position;
	    }  
	  
	   $('#'+ startItem +'').removeClass('main-pos').addClass('left-pos');
	   $('#'+ (startItem+pos()) +'').removeClass('right-pos').addClass('main-pos');
	   $('#'+ (startItem+pos()) +'').removeClass('back-pos').addClass('right-pos');
	   $('#'+ pos('leftposition') +'').removeClass('left-pos').addClass('back-pos');
	
	    startItem++;
	    position=0;
	    if(startItem > itemCount) {
	      startItem = 1;
	    }
	  }
	}
	
	//next button click function
	$('#next').click(function() {
	  swap('clockwise');
	});
	
	//prev button click function
	$('#prev').click(function() {
	  swap('counter-clockwise');
	});
	
	//if any visible items are clicked
	$('li').click(function() {
	  if($(this).attr('class') == 'items left-pos') {
	     swap('counter-clockwise'); 
	  }
	  else {
	    swap('clockwise'); 
	  }
	});


	//---------------------------------------------------------------------사이드바 스크롤 따라오기 ------------------------------------------------------------------------

		// 기본 위치(top)값
		var floatPosition = parseInt($(".l-navbar").css('top'))

		// scroll 인식
		$(window).scroll(function() {
		  
		    // 현재 스크롤 위치
		    var currentTop = $(window).scrollTop();
		    var bannerTop = currentTop + floatPosition + "px";

		    //이동 애니메이션
		    $(".l-navbar").stop().animate({
		      "top" : bannerTop
		    }, 300);

		}).scroll();
	
	
	</script>



</html>


