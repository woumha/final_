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

	@media screen and (max-width: 1000px) {
		.container1 div{
			width: 350px;
			justify-content: center;
		}
	}
		
	

	tr { display: block; float: left; }
	th, td { display: block; }	
	
	html, body {
		  margin: 0;
		  padding: 0;
		  text-align: center;
	}

	.category{
			height: 50px;
			width: 100%;
			background-color: #e78111;
		    padding-top: 10px;
		    box-shadow: 2px 2px 2px gray;
		    text-align: center;
		}

		
	.category ul li {                      
            list-style: none;           
            color: white;                             
            ine-height: 30px;     
            display: inline-block;     
            vertical-align: middle;  
   			padding-left: 10px;     
   			padding-right: 10px;
   			padding-top: 3px;
   			padding-bottom: 3px;
   			border-radius: 15px;
   			margin-right: 20px;
      }
      
      .category ul li:hover{
     
      	   background-color:white;
      	   color: #e78111;
      	   font-weight: bold;
     }
        
      #video_list {
      	display: flex;
      	flex: 3;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		margin-left: 20%;
		margin-top: 0;
     }
     	
	
		video{
			width: 400px;
		}
     	
     	
   /* --------------------------------글자 설정------------------------- */ 
     	 
     	 td{
     	 	font-size: 0.8rem;
     	 }
     	 
     	 #video_title{
     		 font-size: 1rem;
     		 font-weight: bold;
     	 }
     	 
     	 
     /* --------------------------------캐러셀 설정------------------------- */  	 
		
		#slidebtn_wrap{
			display:flex;
		    width: 1303px;
		    height: 280px;
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
			color: #e78111;;
		}
		
		#next:hover{
			color: #e78111;;
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
		
		
		section {
		  width: 40em;
		  height: 13em;
		  position: relative;
		  margin-top: 4%;
		  margin-left: 21%;
		  text-align: center;
		}	
		
		section li {
		  width: 600px;
		  height: 280px;
		  background: #333;
		  display: inline-block;
		  -webkit-transition: all .3s ease-in-out;
		  -moz-transition: all .3s ease-in-out;
		  transition: all .3s ease-in-out;
		  overflow: hidden;
		}
		
		section li p {
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
		
		     	 
     	 
   /* --------------------------------사이드바------------------------- */  	 
   
     :root {
    --nav--width: 102px;

    /* Colores */
    --first-color: #e78111;
    --bg-color: white;
    --sub-color: #b6cefc;
    --white-color: #5c3306;

    /* Fuente y tipografia */
    --body-font: 'Poppins', sans-serif;
    --normal-font-size: 1rem;
    --small-font-size: .875rem;

    /* z index */
    --z-fixed: 100;
	}
	
	/* BASE */
	*, ::before, ::after {
	    box-sizing: border-box;
	}
	
	body {
	    position: relative;
	    margin: 0;
	    padding: 2rem 0 0 6.75rem;
	    font-family: var(--body-font);
	    font-size: var(--normal-font-size);
	    transition: .5s;
	}
	
	h1 {
	    margin: 0;
	}
	
	ul {
	    margin: 0;
	    padding: 0;
	    list-style: none;
	}
	
	a {
	    text-decoration: none;
	}
	
	/* l NAV */
	.l-navbar {
	    position: absolute;
	    top: 165px;
	    left: 0;
	    width: var(--nav--width);
	    height: 100vh;
	    background-color: var(--bg-color);
	    color: var(--white-color);
	    padding: 1.5rem 1.5rem 2rem;
	    transition: .5s;
	    z-index: var(--z-fixed);
	}
	
	/* NAV */
	.nav {
	    height: 100%;
	    display: flex;
	    flex-direction: column;
	    justify-content: space-between;
	    overflow: hidden;
	}
	
	.nav__brand {
	    display: grid;
	    grid-template-columns: max-content max-content;
	    justify-content: space-between;
	    align-items: center;
	    margin-bottom: 2rem;
	}
	
	.nav__logo:hover{
		color: #e78111;
		text-decoration: none;
	}
	
	.nav__toggle {
	    font-size: 1.25rem;
	    padding: .75rem;
	    cursor: pointer;
	}
	
	.nav__logo {
	    color: var(--white-color);
	    font-weight: 600;
	}
	
	.nav__link {
	    display: grid;
	    grid-template-columns: max-content max-content;
	    align-items: center;
	    column-gap: .75rem;
	    padding: .75rem;
	    color: var(--white-color);
	    border-radius: .5rem;
	    margin-bottom: 1rem;
	    transition: .3s;
	    cursor: pointer;
	}
	
	.nav__link:hover {
	    background-color: var(--first-color);
	    text-decoration: none;
	    color: white;
	}
	
	.nav__icon {
	    font-size: 1.25rem;
	}
	
	 i {
		 font-size: 1.25rem;
	}
	
	.nav_name {
	    font-size: var(--small-font-size);
	}
	
	/* Expander menu */
	.expander {
	    width: calc(var(--nav--width) + 9.25rem);
	}
	
	/* Add padding body*/
	.body-pd {
	    padding: 2rem 0 0 16rem;
	}
	
	/* Active links menu */
	.active {
	    background-color: var(--first-color);
	}
	
	/* COLLAPSE */
	.collapse {
	    grid-template-columns: 20px max-content 1fr;
	}
	
	.collapse__link {
	    justify-self: flex-end;
	    transition: .5;
	}
	
	.collapse__menu {
	    display: none;
	    padding: .75rem 2.25rem;
	}
	
	.collapse__sublink {
	    color: var(--sub-color);
	    font-size: var(--small-font-size);
	}
	
	.collapse__sublink:hover {
	    color: var(--white-color);
	}
	
	/* Show collapse */
	.showCollapse {
	    display: block;
	}
	
	/* Rotate icon */
	.rotate {
	    transform: rotate(180deg);
	    transition: .5s;
	}
   
</style>

	<title>MAIN</title>
</head>

<body align="center">

<%-- 검색 필드 include 영역 --%>
<jsp:include page="./include/top_include.jsp"/>

<br>

<%-- 카테고리 영역 --%>
 	<div id="nav_cate">
        <nav class="category">
           <ul>
           		<li>전체</li>
           		<li>게임</li>
           		<li>요리</li>
           		<li>교육</li>
           		<li>스포츠</li>
           		<li>뉴스</li>
           		<li>독서</li>
           		<li>음악</li>
           		<li>최근에 업로드된 동영상</li>
           		<li>관심 카테고리 동영상</li>
           </ul>
		</nav>
	</div>
	 

<%-- 캐러셀 영역 --%>

<div id="slide_wrap">
	
		<div id="slide"> 
	
		<section>
		  <ul class="carousel">
		    <li class="items main-pos" id="1"><p>1</p></li>
		    <li class="items right-pos" id="2">
		      <img src="http://farm9.staticflickr.com/8337/8234123289_2b23aeaf06.jpg" />
		    </li>
		    <li class="items back-pos" id="3">
		      <img src="http://farm9.staticflickr.com/8337/8234711202_831b23a2b7.jpg"/>
		    </li>
		    <li class="items back-pos" id="4"><iframe width="500" height="281" src="https://www.youtube.com/embed/szIEr2F61DU" frameborder="0" allowfullscreen></iframe></li>
		    <li class="items back-pos" id="5">
		      <iframe src="https://player.vimeo.com/video/19464611" width="600" height="280" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>
		    </li>
		    <li class="items back-pos" id="6">
		      <img src="http://woofie2.pixiq.com/files/cache/20030323_img_7465_3072_x_2048_619x413.jpg" />
		    </li>
		    <li class="items left-pos" id="7"><img src="http://www.mishes.com/wp-content/uploads/2011/12/FlickrMonday07.jpg"/>
		    </li>
		  </ul>
		  
		  <div id = "slidebtn_wrap">
			<button id="prev"><i class="fa-solid fa-angles-left"></i></button>
			<button id="next"><i class="fa-solid fa-angles-right"></i></button>
			</div>
		  
		<!--   <input type="button" value="Prev" id="prev"> -->
		<!--   <input type="button" value="Next" id="next"> -->
	</section>
    </div>
    	
  </div>  
	
<%-- 동영상 리스트 영역 --%>

	<div id = "video_list">  
	
		 <table cellspacing="0">
		 	<c:set var="list" value="${video_list }" />
	     	 <c:if test="${!empty list }">
				 <c:forEach items="${list }" var="dto">
				 
			        <tr>
			          <td colspan="1">
			          <video src="https://blog.kakaocdn.net/dn/bzobdO/btrSnWRB7qk/LAZKJtMKBI4JPkLJwSKCKK/1234.mp4?attach=1&knm=tfile.mp4" controls></video></td>
			          <td id = "video_title">${dto.getVideo_title() }</td>
			          <td>영상 업로더 이름 </td>
			          <td>조회수: ${dto.getVideo_view_cnt() }   &nbsp; &nbsp; ${dto.getVideo_regdate() }</td>
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
	 <div class="l-navbar" id="navbar">
        <nav class="nav">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                    <a href="#" class="nav__logo"><i class="fa-solid fa-carrot"></i>&nbsp;VIDIVIDI</a>
                </div>
                <div class="nav__list">
                    <a href="#" class="nav__link active">
                        <ion-icon name="home-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name"> &nbsp; Home</span>
                    </a>
                    <a href="#" class="nav__link">
                        <i class="fa-solid fa-stamp"></i>
                        <span class="nav_name"> &nbsp;  구독</span>
                    </a>

                    <a href="#" class="nav__link">
                        <i class="fa-solid fa-eye"></i>
                        <span class="nav_name"> &nbsp;  시청 기록</span>
                    </a>
                    
                     <a href="#" class="nav__link">
	                    <i class="fa-brands fa-gratipay"></i>
	                    <span class="nav_name"> &nbsp; 좋아요 표시한 동영상</span>
               		 </a>
               		 
               		 <a href="#" class="nav__link">
	                    <i class="fa-solid fa-clock"></i>
	                    <span class="nav_name"> &nbsp; 나중에 볼 동영상</span>
               		 </a>
               		 
               		 <a href="#" class="nav__link">
	                    <i class="fa-solid fa-circle-user"></i>
	                    <span class="nav_name"> &nbsp; 내 동영상</span>
               		 </a>
               		 
               		 <hr>
               		 
               		 <a href="#" class="nav__link">
	                    <i class="fa-solid fa-gear"></i>
	                    <span class="nav_name"> &nbsp; 설정 </span>
               		 </a>
               		 
               		 <a href="#" class="nav__link">
	                    <i class="fa-solid fa-flag"></i></i>
	                    <span class="nav_name"> &nbsp; 고객센터 </span>
               		 </a>
               		 
                </div>
            </div>
        </nav>
    </div>	


</body>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script>
		    /* EXPANDER MENU */
		const showMenu = (toggleId, navbarId, bodyId) => {
		    const toggle = document.getElementById(toggleId),
		    navbar = document.getElementById(navbarId),
		    bodypadding = document.getElementById(bodyId)
		
		    if( toggle && navbar ) {
		        toggle.addEventListener('click', ()=>{
		            navbar.classList.toggle('expander');
		
		            bodypadding.classList.toggle('body-pd')
		        })
		    }
		}
		
		showMenu('nav-toggle', 'navbar', 'body-pd')
		
		/* LINK ACTIVE */
		const linkColor = document.querySelectorAll('.nav__link')
		function colorLink() {
		    linkColor.forEach(l=> l.classList.remove('active'))
		    this.classList.add('active')
		}
		linkColor.forEach(l=> l.addEventListener('click', colorLink))
		
		/* COLLAPSE MENU */
		const linkCollapse = document.getElementsByClassName('collapse__link')
		var i
		
		for(i=0;i<linkCollapse.length;i++) {
		    linkCollapse[i].addEventListener('click', function(){
		        const collapseMenu = this.nextElementSibling
		        collapseMenu.classList.toggle('showCollapse')
		
		        const rotate = collapseMenu.previousElementSibling
		        rotate.classList.toggle('rotate')
		    });
		}
		

	</script>
	
	<script type="text/javascript">
	
	
	/* 캐러셀 js  */

	
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


/*  스크롤 어쩌고 */

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
