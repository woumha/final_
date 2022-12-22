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
$(function() {
	$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded;charset=UTF-8", //한글처리
			type: "post"
	});
		
	defaultProfil = profilFile.files[0];
	
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
	
	
	// 수정 버튼 클릭시
	$(".up_btn").on("click", function() {
		if($("#input_file").val().trim() != "") {
			if($("#exampleDataList").val().trim() != "") {
				if($("#floatingTextarea2").val().trim() == "") {
					$("#floatingTextarea2").val("null");
				}
				
				// 공개 여부
				let radioOpenId = $('input[name=flexRadioDefault_openClose]:checked').attr("id");
				let radioOpen = $("label[for='" + radioOpenId + "']");
				
				// 아동용, 성인용
				let radioAgeId = $('input[name=flexRadioDefault_age]:checked').attr("id");
				let radioAge = $("label[for='" + radioAgeId + "']");
				
				const inputAge = `<input `;
				
				$(".age_select").append();
				
			} else {
				alert("제목을 입력 안하셨어요 :)");
			}
		} else {
			alert("영상을 넣어주세요 :)");
		}
	});
	
	
	
	
});

// 경로
function getContextPath(){
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

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
	
	
   //$('#MoaModal .modal-content').load("moaModal?id=");
   //$('#MoaModal').modal();
}