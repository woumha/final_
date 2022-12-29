/**
 * 
 */
 
 $(function() {
 	$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded;charset=UTF-8", //한글처리
			type: "post"
	});
	
 	$("#profilArea").on("change", function() {
 		const channelCode = $("#channelCode").val();
 		const img = $("#defaultProfil").val();
 	
 	
 		const file = $("#profilArea")[0].files[0];
 	
 		const formData = new FormData();
 		formData.append("profilArea", file);
 		
 		$.ajax({
 			url: getContextPath() + '/imageChange.do?channelCode='+ channelCode + '&imgPath=' + img,
 			data: formData,
 			dataType: 'text',
 			processData : false,
           	contentType : false,
           	success: function(data) {
           		let fileReader = new FileReader();
    			let reader = new FileReader();
    			
    			 reader.fileName = file.name;
    			 
    			 fileReader.onload = function() {
			        fileURL  = fileReader.result;
			        console.log(fileURL);
			     	$('.imgSrc').attr('src', fileURL);
				    
			        fileReader.fileName = file.name;
				};
				
				 fileReader.readAsDataURL(file);
           	},
           	error: function() {
           		console.log('파일 전송 실패');
           	}
 		});
 	});
 	
 	 $("#bannerArea").on("change", function() {
 		const channelCode = $("#channelCode").val();
 		const banner = $("#defaultBanner").val();
 	
 	
 		const file = $("#bannerArea")[0].files[0];
 	
 		const formData = new FormData();
 		formData.append("bannerArea", file);
 		
 		$.ajax({
 			url: getContextPath() + '/bannerChange.do?channelCode='+ channelCode + '&imgPath=' + banner,
 			data: formData,
 			dataType: 'text',
 			processData : false,
           	contentType : false,
           	success: function(data) {
           		let fileReader = new FileReader();
    			let reader = new FileReader();
    			
    			 reader.fileName = file.name;
    			 
    			 fileReader.onload = function() {
			        fileURL  = fileReader.result;
			        console.log(fileURL);
			     	$('.bannerSrc').attr('src', fileURL);
				    
			        fileReader.fileName = file.name;
				};
				
				 fileReader.readAsDataURL(file);
           	},
           	error: function() {
           		console.log('배너 전송 실패');
           	}
 		});
 	});
 	
 	$('.nameAreaBtn').on('click', function() {
 		let name = $('#areaText').val();
		const channelCode = $('#channelCode').val();
 		
 		$.ajax({
 			url: getContextPath() + 'channelNameChange.do',
 			data: {
 				'channelProfile': name,
 				'channelCode': channelCode
 			},
 			datatype: 'text',
 			success: function(data) {
 				alert('성공');
 				$("#areaText").val("");
 				$("#areaText").attr("placeholder", data);
 			},
 			error: function(){
 				alert('실패');
 			}
 		});
 	});
 });
 
 function profilBtn() {
 	if(!(confirm('프로필 이미지를 수정시 이전 이미지를 선택할 수 없습니다. 그래도 변경 하시겠습니까?'))) {
 	
 	} else {
 		$("#profilArea").click(); 	
 	}
 }
 
 function bannerBtn() {
 	if(!(confirm('프로필 이미지를 수정시 이전 이미지를 선택할 수 없습니다. 그래도 변경 하시겠습니까?'))) {
 	
 	} else {
 		$("#bannerArea").click(); 	
 	}
 }
 
 // 경로
function getContextPath(){
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}