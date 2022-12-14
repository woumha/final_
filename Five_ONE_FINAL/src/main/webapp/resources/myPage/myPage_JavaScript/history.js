/* 전체 삭제 모달 */
$('a[href="#history_delete"]').click(function(event) {
 	event.preventDefault();
	$(this).modal({
		fadeDuration: 250
	});
});
	
/* 기록 정지 모달 */
$('a[href="#history_stop"]').click(function(event) {
 	event.preventDefault();
	$(this).modal({
		fadeDuration: 250
	});
});