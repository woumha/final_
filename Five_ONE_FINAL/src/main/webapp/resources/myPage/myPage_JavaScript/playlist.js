/* 전체 삭제 모달 */
$('a[href="#playlist_delete"]').click(function(event) {
 	event.preventDefault();
	$(this).modal({
		fadeDuration: 250
	});
});
	
/* 기록 정지 모달 */
$('a[href="#playlist_stop"]').click(function(event) {
 	event.preventDefault();
	$(this).modal({
		fadeDuration: 250
	});
});

/* 동영상에 마우스 오버시 자동재생 */
$(document).on("mouseover", ".test_video", function(){
	 $(this).get(0).play();
});

$(document).on("mouseout", ".test_video", function(){
	 $(this).get(0).pause();
});	