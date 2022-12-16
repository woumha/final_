/**
 * 
 */
 
const card = document.querySelector(".left_card"),
profilFile = card.querySelector(".profil_input"),
img = card.querySelector(".left_img");
 
let file; 
let fileURL;
let defaultProfil;
$(function() {
	
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
	
	Array.from(inputFile[0].files).map(e => formData.append('file', e));
	
	$.ajax({
		url: getContextPath() + "/channel_profil.do",
		processData: false,
		contentType: false,
		cache: false,
		enctype: "multipart/form-data",
		data: formData,
		success: function() {
			console.log("true");
		},
		error: function(e) {
			console.log("false: " + e);
		}
	});
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
			
			console.log(data);
			$(".modal-content").html(data);
		},
		error: function() {
			console.log(false);
		}
	});
	
	
   //$('#MoaModal .modal-content').load("moaModal?id=");
   //$('#MoaModal').modal();
}