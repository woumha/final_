/**
 * 
 */
 


$(function() {
	$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded;charset=UTF-8", //한글처리
			type: "post"
	});
	
	
	
	$("#video_upload_btn").on("click", function() {
		$.ajax({
			url: getContextPath() + "/movie_upload.do",
			data: {
				"code": $("#ownerCode").val(),
				"name": $("#channel_code").val()
			},
			datatype: "html",
			success: function(data) {
				$(".modal-content").html(data);
			},
			error: function() {
				console.log(false);
			}
		});
	});
	
	
	$(".div_upload_btn").on("click", function() {
		$("#video_upload_btn").click();
	});
	
	
});


// 경로
function getContextPath(){
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}
