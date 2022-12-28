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
	
	
	$(".bundle_Code").each(function() {
		let bundle = $(this).val();
		
		
		$.ajax({
			url: getContextPath() + "/bundleSetList.do",
			data: {
				"bundle_Code": bundle	
			},
			datatype: html,
			success: function(data) {
				let check = data;
				let list = "";
				
				if(check == "[]") {
					loading_playlist = false;
					list += '<div>영상이 없어요</div>';
				} else {
					let div = JSON.parse(data);
					
					$(div).each(function () {
						list += '<div class="col-12 col-sm-6 col-lg-3">';
						list += '<div class="m-1 ratio ratio-4x3">';
						list += '<video class="vicl" id="se-se-one" loop class="embed-responsive-item" controls>';
						list += '<source src="'+ getContextPath() +'/resources/AllChannel/'+ this.channel_code + '/'+ this.video_title + '.mp4" type="video/mp4">';
						list += '</video>';
						list += '</div>';
						list += '<div class="video-title">'+ this.video_title +'</div>';
						list += '<div class="video-up">조회수 '+ this.video_view_cnt + ' · '+ this.video_regdate +'</div>';
						list += '</div>';							
					});
					
					$("."+bundle).append(list);
				}
			},
			error: function() {
				alert('통신 오류');
			}
		});	
	});
	
	
	$(".bundle_bundle_list").each(function() {
		let bundle = $(this).val();
		$.ajax({
			url: getContextPath() + "/bundle_bundle_list.do",
			data: {
				"bundleCode": bundle 
			},
			datatype: "text",
			success: function(data) {
				if(data != "" || data != "null") {
					
					let path = `location.href='${getContextPath()}/watch.do?video_code=${data}&playlist_code=${bundle}'`;					
					$(".b"+bundle).attr('onClick', path);
				}
				
			}
		});
	});
	
	
	$(".subing").hide();
});


// 경로
function getContextPath(){
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

function getBundleVideoList() {
	
}

function insertscribe(ownerCode, memCode) { 
	$.ajax({
		url: getContextPath() + "/subscribe.do",
		data: {
			"ownerCode": ownerCode,
			"memCode": memCode
		},
		datatype: 'text',
		success: function(data) {
			let li = "";
			if(data == "insert") {
				li = `<button type="button" class="btn btn-primary btn-red text-red subing" style="color: red; background-color: #ECE9EF;" onclick="(insertscribe'${ownerCode}', '${memCode}')">구독중</button>`;
			} else if (data == "delete") {
				lt = `<button type="button" class="btn btn-primary btn-dark subed" onclick="insertscribe('${ownerCode}', '${memCode }')">구독</button>`;
			} else {
				alert('스크립트 오류');
				history.back();
			}
			
			$("#subBtn").html(li);
		},
		error: function() {
			alert('구독을 다시 클릭해주세요');
		}
	});
}