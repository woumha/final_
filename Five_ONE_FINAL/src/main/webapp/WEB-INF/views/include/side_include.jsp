<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>

<style type="text/css">

 :root {
    --nav--width: 100px;

    /* Colores */
    --first-color: #fc942c;
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
		color: #fc942;
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

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


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

	<script type="text/javascript">
	
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


</html>