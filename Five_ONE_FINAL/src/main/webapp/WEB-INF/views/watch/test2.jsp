<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<style type="text/css">
.video_list_nav{
	width: 50rem;
	min-width: 3rem;
	margin: 0 auto;
	overflow: hidden;
	border: 1px solid red;
	
}
.card_a{
	display: flex;
	justify-content: space-around;
	flex-direction: row;
}

.nav_item{
	left: 0;
	top: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 1rem;

}
</style>
</head>
<body>
			<div class="video_list_wrap card_c">
				<div>
					<div class="video_list_nav card_a">
						<div class="nav_item"><button class="nav_btn" value="all">모두</button></div>
						<div class="nav_item"><button class="nav_btn" value="category">관련 콘텐츠</button></div>
						<div class="nav_item"><button class="nav_btn" value="current">최근 업로드된 동영상</button></div>
						<div class="nav_item"><button class="nav_btn" value="history">감상한 동영상</button></div>
					</div>
				</div>
				<button class="prev" value="이전"></button>
				<button class="next" value="다음"></button>
				
			</div>	
</body>

<script type="text/javascript">

$(document).ready(function(){
	
	let trans = 0;
	
	let bannerList = $('.nav_item');
	let listWidth = Math.floor(bannerList.outerWidth()); // 아이템 넓이 42
	let listCount = bannerList.length; // 리스트 갯수
	let maxX = (listCount - 1) * listWidth; // 오른쪽 끝 좌표 126
	let minX = -1 * listWidth; // 왼쪽 끝 좌표 -42

	
	// item 배치
	$.each(bannerList, function (index, item) {
		$(this).css("transform",  "translateX(" +index * listWidth+ "px)");
		let tempX = $(this).css('transform : translateX');
		console.log('x >>> ' +tempX);
	});
	

	
	function movePrev() {
		noClick = true;
		$.each(bannerList, function (index, item) {
			let tempX = $(this).css('transform');
			tempX = parseInt(tempX);
			if (tempX <= minX) {
				$(this).css('transform', maxX);
				tempX = maxX;
			}else{
				tempX -= listWidth;
			}
			$(this).animate({
				left: tempX,
			}, nowSpeed, function () {
			});
		});
	}
	

	$(".prev").on("click", function(){
		trans += 45;
		$(".nav_item").each(function(){
			$(this).css("transform", "translateX(" +trans+ "px)");
		});
	});
	
	$(".next").on("click", function(){
		trans -= 45;
		$(".nav_item").each(function(){
			$(this).css("transform", "translateX(" +trans+ "px)");
		});
	});
	
});


</script>
</html>