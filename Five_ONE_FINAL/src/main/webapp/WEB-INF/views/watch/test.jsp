<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<style type="text/css">
/* 네비게이션 CSS */
.video_list_nav{
	position: relative;
	width: 5rem;
	min-width: 3rem;
	margin: 0 auto;
	overflow: hidden;
	float: left;
}
.card_a{
	display: flex;
	justify-content: flex-start;
	flex-direction: row;
}

.nav_item{
	position: absolute;
	left: 0;
	top: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 1rem;

}

.video_list_wrap{
}
</style>
</head>
<body>
			<div class="video_list_wrap card_c">
				<div>
					<div class="video_list_nav">
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
$(function () {
	let bannerList = $('.nav_item');
	let listWidth = Math.floor(bannerList.outerWidth()); // 아이템 넓이 42
	let listCount = bannerList.length; // 리스트 갯수
	let maxX = (listCount - 1) * listWidth; // 오른쪽 끝 좌표 126
	let minX = -1 * listWidth; // 왼쪽 끝 좌표 -42
	
	console.log(listWidth);
	console.log(maxX);
	console.log(minX);
	
	// list 배치
	$.each(bannerList, function (index, item) {
		$(this).css({
			left: index * listWidth,
		})
	});
	
	// click event
	let prevBtn = $('.prev');
	let nextBtn = $('.next');
	let bannerSpeed = 1000;
	let clickSpeed = 300;
	let bannerDirection = 'prev'
	let nowSpeed = bannerSpeed;

	prevBtn.on('click', function () {
			nowSpeed = clickSpeed;
			movePrev();
	});
	nextBtn.on('click', function () {
			nowSpeed = clickSpeed;
			moveNext();
	});


	function movePrev() {
		noClick = true;
		$.each(bannerList, function (index, item) {
			let tempX = $(this).css('left');
			tempX = parseInt(tempX);
			if (tempX <= minX) {
				$(this).css('left', maxX);
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

	function moveNext() {
		noClick = true;
		$.each(bannerList, function (index, item) {
			let tempX = $(this).css('left');
			tempX = parseInt(tempX);
			if (tempX >= maxX) {
				$(this).css('left', minX);
				tempX = minX;
			}else{
				tempX += listWidth;
			}
			$(this).animate({
				left: tempX,
			}, nowSpeed, function () {

			});
		});
	}






});

</script>
</html>