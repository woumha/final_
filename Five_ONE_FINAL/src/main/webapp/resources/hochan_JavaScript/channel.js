/**
 * 
 */
 


$(function() {
	$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded;charset=UTF-8", //한글처리
			type: "post"
	});
	
	$("#video_upload_btn").on("click", function() {
    	$("div.modal").modal({
       	 	href: "movie_upload.jsp"
   	 	});
	});
	
	
	
});