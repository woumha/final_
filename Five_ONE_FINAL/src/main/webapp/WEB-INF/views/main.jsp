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

	tr { display: block; float: left; }
	th, td { display: block; }	
	
	html, body {
		  margin: 0;
		  padding: 0;
	}
	
	
	video{
		width: 400px;
	}
	
	#video_list{
		justify-content: center;
	}
	
	.category{
			height: 50px;
			width: 100%;
			background-color: #2d2d2d;
		}

		
	.category ul li {                      
                list-style: none;           
                color: white;                             
                line-height: 30px;     
                display: inline-block;     
                vertical-align: middle;     
                text-align: center;         
         }
         
         
      #video_list {
      	display: flex;
      	flex: 3;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		margin-left: 18%;
     	}
     	
     	
   /* --------------------------------글자 설정------------------------- */ 
     	 
     	 td{
     	 	font-size: 0.8rem;
     	 }
     	 
     	 #video_title{
     		 font-size: 1rem;
     		 font-weight: bold;
     	 }
     	 
     	 
   /* --------------------------------사이드바------------------------- */  	 
   
    :root {
    --nav--width: 92px;

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
	    position: fixed;
	    top: 130px;
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
	}
	
	.nav__icon {
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

<script type="text/javascript">
	
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
	
	
	const linkColor = document.querySelectorAll('.nav__link')
	function colorLink() {
	    linkColor.forEach(l=> l.classList.remove('active'))
	    this.classList.add('active')
	}
	linkColor.forEach(l=> l.addEventListener('click', colorLink))
	
	
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

	<title>MAIN</title>
</head>

<body align="center">

<%-- 검색 필드 include 영역 --%>
<jsp:include page="./include/top_include.jsp"/>


<%-- 카테고리 영역 --%>
	<div id="nav_cate">
        <nav class="category">
           <ul>
           		<li>카테고리 1</li>
           		<li>카테고리 2</li>
           		<li>카테고리 3</li>
           		<li>카테고리 4</li>
           		<li>카테고리 5</li>
           </ul>
		</nav>
	</div>
	

<%-- 사이드바 영역 --%>
	<br> <br>
	<h2>배너 들어갑니다 </h2>
	
	
<%-- 사이드바 영역 --%>
	 <div class="l-navbar" id="navbar">
        <nav class="nav">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                    <a href="#" class="nav__logo">Bedimcode</a>
                </div>
                <div class="nav__list">
                    <a href="#" class="nav__link active">
                        <ion-icon name="home-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">Dashboard</span>
                    </a>
                    <a href="#" class="nav__link">
                        <ion-icon name="chatbubbles-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">Messenger</span>
                    </a>

                    <div href="#" class="nav__link collapse">
                        <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">Projects</span>

                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

                        <ul class="collapse__menu">
                            <a href="#" class="collapse__sublink">Data</a>
                            <a href="#" class="collapse__sublink">Group</a>
                            <a href="#" class="collapse__sublink">Members</a>
                        </ul>
                    </div>

                    <a href="#" class="nav__link">
                        <ion-icon name="pie-chart-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">Analytics</span>
                    </a>

                    <div href="#" class="nav__link collapse">
                        <ion-icon name="people-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">Team</span>

                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

                        <ul class="collapse__menu">
                            <a href="#" class="collapse__sublink">Data</a>
                            <a href="#" class="collapse__sublink">Group</a>
                            <a href="#" class="collapse__sublink">Members</a>
                        </ul>
                    </div>

                    <a href="#" class="nav__link">
                        <ion-icon name="settings-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">Settings</span>
                    </a>
                </div>
                <a href="#" class="nav__link">
                    <ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">Log out</span>
                </a>
            </div>
        </nav>
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


</body>
</html>
