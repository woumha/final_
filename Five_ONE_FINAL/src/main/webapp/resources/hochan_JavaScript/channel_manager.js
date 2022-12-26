/**
 * 
 */
 
const card = document.querySelector(".left_card"),
profilFile = card.querySelector(".profil_input"),
img = card.querySelector(".left_img");

const fileArea = document.querySelector("#file_area");
const inputFile = document.querySelector("#input_file");
const source = document.querySelector(".source_tag");

let file; 
let fileURL;
let defaultProfil;

let loading_playlist = false;


$(function() {
	$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded;charset=UTF-8", //한글처리
			type: "post"
	});
	
	//defaultProfil = profilFile.files[0];
	
	$(".profil_settings").on("click", function() {
		$(".profil_input").click();
	});
	
	profilFile.addEventListener("change", function() {
		file = this.files[0];
		
		let fileType = file.type;
		
		let fileTypeCheck = [];
		
		showFile();
		
	});
	
	$("#file_area").on("click", function() {
		$("#input_file").click();
	});
	
	$("#input_file").on("change", function(e) {
		file = this.files[0];
		
		let vaildExtensions = ["video/quicktime", "video/mp4", "video/wmv", "video/avi", "video/avchd", "video/mpeg-2"]; // 모든 목록
		
		if(vaildExtensions.includes(file.type)) {
			let fileReader = new FileReader();
		    let reader = new FileReader();
		
		    reader.fileName = file.name;
		    
			fileReader.onload = function(e) {
		        fileURL  = fileReader.result;
		        let videoTag = `<video id="upload_file_btn" class="update_modal"><source class="source_tag" src="${fileURL}"></video>`;
			    fileArea.innerHTML = videoTag;
			    
			    
		        //fileReader.fileName = file.name;
				//file_name = e.target.fileName;
			};
			
			 fileReader.readAsDataURL(file);
		} else {
			alert("파일 저장 오류");
		}
	});
	
	// 처음 영상 이름
	const originVideo = $(".video_field").val(); 
	const imgName = $(".img_field").val();
	
	$("#input_file").on("change", function() {
		videoName = $("#input_file").val();
		$(".video_field").val(videoName);
	});
	//.toString().split('/').pop().split('\\').pop()
	// 이미지를 변경했을시
	$("#autoSizingInputGroup").on("change", function() {
		if($("#autoSizingInputGroup").val() != "") {
			let imgName = $("#autoSizingInputGroup").val();
			$(".img_field").val(imgName.toString().split('/').pop().split('\\').pop());	
		} else if($("#autoSizingInputGroup").val() == "") {
			$(".img_field").val("파일을 선택해주세요");
		}
	});
	
	
	// 수정 버튼 클릭시
	$(".up_btn").on("click", function() {
		if($("#exampleDataList").val().trim() != "") {
			if($("#floatingTextarea2").val().trim() == "") {
				$("#floatingTextarea2").val("null");
			}
			
			// 공개 여부
			const radioOpenId = $('input[name=flexRadioDefault_openClose]:checked').attr("id");
			const radioOpen = $("label[for='" + radioOpenId + "']");
			
			// 아동용, 성인용
			const radioAgeId = $('input[name=flexRadioDefault_age]:checked').attr("id");
			const radioAge = $("label[for='" + radioAgeId + "']");
			
			const inputAge = `<input type='hidden' name='select_Age' value='${radioAge}' >`;
			const inputOpen = `<input type='hidden' name='select_openClose' value='${radioOpen}'>`;
			
			const bundle = $("#bundleCheck option:selected").text();
			const bundleTag = `<input type='hidden' name='bundleText' value='${bundle}'>`;
			
			
			$(".age_select").append(inputAge);
			$(".open_check").append(inputOpen);
			$(".bundleDiv").append(bundleTag);
			
			if($("#input_file").val() != "") {
				const vname = $("#input_file").val();	
				$("#video_name").val(vname);
			} else if($("#input_file").val() == "") {
				$("#video_name").val(originVideo);
			} else {
				history.back();
			}
			
			if($("#autoSizingInputGroup").val() != "") { // 빈값이 아니라면
				const iname = $("#autoSizingInputGroup").val();
				$("#img_name").val(iname); // text에 값 넣기
			} else if($(".img_field") == "파일을 선택해주세요") {  // 이미지가 없는 경우, 추가를 안한 경우
				$(".img_field").val("파일을 선택해주세요");
			}
			
			
			console.log($("#video_name").val());
			console.log($(".img_field").val());
			$("#formData").submit();
		} else {
			alert("제목을 입력 안하셨어요 :)");
		}
	});
	
	$(".delicon").hide();
	$(".bDel").on("click", function() {
		$(".delicon").toggle();
	});
});

// 경로
function getContextPath(){
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

// 영상 변경시
function showFile() {
	let fileReader = new FileReader();
	let reader = new FileReader();
	
	reader.fileName = file.name;
	
	fileReader.onload = function() {
		fileURL = fileReader.result;
		img.src = fileURL;
	};
	
	fileReader.readAsDataURL(file);
	 
	let inputFile = $(".profil_input");
	let formData = new FormData();
}


// 비디오 수정 함수
function modal(code) {
	$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded;charset=UTF-8", //한글처리
			type: "post"
	});
	
	$.ajax({
		url: getContextPath() + "/video_update_modal.do",
		data: {
			"video_code" : code
		},
		datatype: 'html',
		success: function(data) {
			$(".modal-content").html(data);
		},
		error: function() {
			console.log(false);
		}
	});
}

// 비디오 업로드 함수
function newVideo() {
	$.ajax({
			url: getContextPath() + "/movie_upload.do",
			data: {
				"code": $("#oCc").val(),
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
}

// 재생목록 추가하기
function bundleMake() {
	let bundleName = $(".bundleNameField").val();
	
	$.ajax({
		url : getContextPath() + '/bundleMaking.do',
		data : {
			"code": $("#oCc").val(),
			"bundleN": bundleName
		},
		datatype : 'JSON',
		contentType : "application/json; charset=UTF-8",
		success : function(data) {
			let str = data;
			
			if(str == "[]") {
				loading_playlist = false;
			} else {
				let list = JSON.parse(data);
				let li = "";
				$(list).each(function () {
					li += "<li class='w-100 index'>";
					li += "<input type='hidden' value='"+ this.bundle_code +"'";
					li += "<a href='bundle_video_list' class='nav-link px-0 bundle_text' style='display: inline-block;'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-music-note-list icon black' viewBox='0 0 16 16'><path d='M12 13c0 1.105-1.12 2-2.5 2S7 14.105 7 13s1.12-2 2.5-2 2.5.895 2.5 2z'/><path fill-rule='evenodd' d='M12 3v10h-1V3h1z'/><path d='M11 2.82a1 1 0 0 1 .804-.98l3-.6A1 1 0 0 1 16 2.22V4l-5 1V2.82z'/><path fill-rule='evenodd' d='M0 11.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 1 0 1H.5a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 .5 7H8a.5.5 0 0 1 0 1H.5a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 .5 3H8a.5.5 0 0 1 0 1H.5a.5.5 0 0 1-.5-.5z'/></svg>";
					li += "<span class='d-none d-sm-inline child_bundle'>"+ this.bundle_title +"</span>	</a>";
					li += "<button id='bDelIndex' class='delicon' onclick='bundleDel('"+ this.bundle_code +"')'";
					li += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3' viewBox='0 0 16 16'><path d='M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z'/></svg>";
					li += "</button>"
					li += "</li>";		
				});
				$("#bundleList").append(li);
			}
		},
		error: function() {
			console.log("재생목록 추가 실패");
		}
	});
}

function bundleDel(bundleCode) {	
	
	$.ajax({
		url: getContextPath() + "/BundleDelete.do",
		data: {
			"bundleCode": bundleCode
		},
		success: function(data) {
			if(data > 0) {
				alert('삭제 완료');
				getData();				
			} else {
				alert('삭제 실패');
			}
		},
		error: function() {
			alert('삭제 실패');
		}
	});
	
}

