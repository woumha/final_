/**
 * 
 */
 
 $(function() {
	$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded;charset=UTF-8", //한글처리
			type: "post"
	});
	
	// 프로필 이미지 수정
	$("#profilArea").on("change", function() {
		const code = $("#channelCode").val();
		const img = $("#defaultProfil").val();
		
		const formData = new FormData();
		const currentFile = $("#profilArea")[0].files[0];
		formData.append("profilArea", currentFile);
		
		/*
		for (var key of formData.keys()) {
		  console.log(key);
		}
		for (var value of formData.values()) {
		   console.log(value);
		}
  		*/
  		
		$.ajax({
			url: getContextPath() + "/imageChange.do?channelCode=" + code + "&imgPath=" + img,
			type: "POST",
			data: formData,
			datatype: 'text',
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			success: function(response) {
				let fileReader = new FileReader();
			    let reader = new FileReader();
			
			    reader.fileName = currentFile.name; // 파일 정보.name(이름)
				
				fileReader.onload = function() {
					let fileURL = fileReader.result;
					$(".imgSrc").attr("src", fileURL);
				}
				
				fileReader.readAsDataURL(file);
			},
			error: function() {
				console.log('프로필 변경 실패');
			}
		});
	});
	
	$("#bannerArea").on("change", function() {
		const code = $("#channelCode").val();
		const banner = $("#defaultBanner").val();
		
		const formData = new FormData();
		const currentFile = $("#bannerArea")[0].files[0];
		formData.append("bannerArea", currentFile);
		
		/*
		for (var key of formData.keys()) {
		  console.log(key);
		}
		for (var value of formData.values()) {
		   console.log(value);
		}
  		*/
  		
		$.ajax({
			url: getContextPath() + "/bannerChange.do?channelCode=" + code + "&imgPath=" + banner,
			type: "POST",
			data: formData,
			datatype: 'text',
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			success: function(response) {
				let fileReader = new FileReader();
			    let reader = new FileReader();
			
			    reader.fileName = currentFile.name; // 파일 정보.name(이름)
				
				fileReader.onload = function() {
					let fileURL = fileReader.result;
					$(".bannerSrc").attr("src", fileURL);
				}
				
				fileReader.readAsDataURL(file);
			},
			error: function() {
				console.log('배너 변경 실패');
			}
		});
	});
	
	
	$(".nameAreaBtn").on("click", function() {
		if(!($(".nameAreaText").val().trim() == "")) {
			const name = $(".nameAreaText").val().trim();
			const channelCode = $("#channelCode").val().trim();
			
			$.ajax({
				url: getContextPath() + "/channelNameChange.do",
				data: {
					"channelProfile": name,
					"channelCode": channelCode
				},
				datatype: 'text',
				success: function(data) {
					alert('수정 완료');
					$(".nameAreaText").attr("placeholder", data);
					$(".nameAreaText").val("");
				},
				error: function() {
					alert('수정 오류');
					location.reload();
				}
			});
					
		} else {
			alert('채널 이름을 작성해주세요');
		}
	});
	
	$(".contAreaBtn").on("click", function() {
		const area = $("#contAreaText").val();
		const channelCode = $("#channelCode").val().trim();
		
		if(!(area.trim() == "")) {
			$.ajax({
				url: getContextPath() + "/channelContChange.do",
				data: {
					"channelProfile": area,
					"channelCode": channelCode
				},
				datatype: "text",
				success: function(data) {
					alert('수정 완료');
					$(".contAreaText").val(data);
				},
				error: function() {
					alert('수정 오류');
					location.reload();
				}
			});
		} else {
			alert('설명란에 내용을 입력해주세요');
		}
	})
});

function profilBtn() {
	if(!(confirm('이미지를 수정하시면 기존에 사용하시는 프로필를 사용하실 수 없습니다.'))) {
		
	} else {
		$("#profilArea").click();	
	}
}

function bannerBtn() {
	if(!(confirm('배너를 수정하시면 기존에 사용하시는 배너를 사용하실 수 없습니다.'))) {
		
	} else {
		$("#bannerArea").click();	
	}
}

// 경로===================================
function getContextPath(){
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}