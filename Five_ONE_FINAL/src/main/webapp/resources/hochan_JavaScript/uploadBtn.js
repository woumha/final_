/**
 selecting all required elements
 */
 
 const dragArea = document.querySelector(".drag-area"),
 dragText = dragArea.querySelector("header"),
 button = dragArea.querySelector(".upload_click_btn"),
 input = dragArea.querySelector(".upload_input_file"),
 span = dragArea.querySelector("span"),
 submit_video = dragArea.querySelector(".submit_video"),
 file_div = dragArea.querySelector(".file_div");

 let file; // drop 한 파일의 전역 변수 이름명
 let fileURL; // drop한 파일의 경로
 
 let video; // 영상
 let uploadtitle; // 영상 제목
 let uploadCont; // 영상 설명
 let selectPlayList; // 영상 재생목록
 let selectAn; // 아동용&성인용
 /////////////////////

 //해시태그 변수
let key = false; 
let text = "";
let hashText = [];
/////////////////////
 
 
 button.onclick = () => {
 	input.click();	// 만약 클릭버튼을 클릭했을 때 >> input이 클릭
 }

 // 클릭버튼 눌렀을때
 input.addEventListener("change", function() {
 	file = this.files[0];
 	
 	let fileType = file.type;
 	
 	let vaildExtensions = ["video/quicktime", "video/mp4", "video/wmv", "video/avi", "video/avchd", "video/mpeg-2"]; // 모든 목록
 	
 	 	
 	// 사용자가 vaildExtensions에 있는 이외의 파일을 넣었을때
 	if(vaildExtensions.includes(fileType)) {
		showFile() // calling function
 	} else {
		alert("MOV, MP4, WMV, AVI, AVCHD, mpeg-2 파일을 넣어주세요.");
	}
	
 	//console.log("input =" + input.files[0].name);
 });
 
 // 사용자가 파일을 드래그 했을 때 발생
 dragArea.addEventListener('dragover', (event) => {
 	event.preventDefault();
 	dragArea.classList.add("active");
 	
 	dragText.textContent = "Release to Upload File";
 });
 
 // 사용자가 파일을 드래그 밖으로 뺏을때 했을 때 발생
 dragArea.addEventListener('dragleave', (event) => {
 	event.preventDefault();
 	dragArea.classList.remove("active");
 	
 	
 	dragText.textContent = "Drag & Drop to Upload File";
 });
 
 
 // 사용자가 파일을 넣었을때
 dragArea.addEventListener('drop', (event) => {
 	event.preventDefault(); // 화면에 자동생성 막기
 	 	
 	// 전역변수에 파일 넣기
 	file = event.dataTransfer.files[0];
	let fileType = file.type;
	
	let vaildExtensions = ["video/quicktime", "video/mp4", "video/wmv", "video/avi", "video/avchd", "video/mpeg-2"]; // 모든 목록
	if(vaildExtensions.includes(fileType)) {
	    //DataTransfer로 받아올 수 있음
		const data = event.dataTransfer;
				    
		//* Drag&Drop 된 파일을 input file의 내용으로 교체
		$('#upload_input_file')[0].files = data.files;
		
	 	showFile() // calling function
	} else {
		alert("MOV, MP4, WMV, AVI, AVCHD, mpeg-2 파일을 넣어주세요.");
	}
			
 });
 
 // 파일을 클릭, 드롭 했을때 발생
 function showFile() {
	let fileReader = new FileReader();
    let reader = new FileReader();
    let file_name;

    reader.fileName = file.name;
    

	fileReader.onload = function(e) {
        fileURL  = fileReader.result;
        let videoTag = `<video><source src="${fileURL}"></video>`;
        submit_video.innerHTML = videoTag;
	    
        fileReader.fileName = file.name;
		file_name = e.target.fileName;
	};
	   
    
    let change_img = document.querySelector('.icon_change');
    
    button.type = "hidden";
    //input.type="hidden";
    
    submit_video.style.height='100%';
    submit_video.style.width='100%';
    $(".submit_video").css("padding-top","10%");
			
    fileReader.readAsDataURL(file);
 }
 
 // 업로드 버튼 클릭시@@@@@@@@@@@@@@@@@@@@@@@@
 function getContextPath(){
	let path = location.href.indexOf(location.host)+location.host.length;
	
	return location.href.substring(path, location.href.indexOf('/', path+1));
}

// form 태그 보내는곳@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
$(function() {
	$(".icon_change").on("click", function() {
		$(".upload_input_file").click();
	});
	
	$(".video_upload_btn").on('click', function() {
		if($("#upload_input_file").val().trim() != "") {
			if($("#floatingTextarea2").val().trim() != "") {
				if($("#floatingTextarea3").val().trim() == "") {
					$("#floatingTextarea3").val("null");
				}
				
				let radioOpenId = $('input[name=flexRadioDefault_openClose]:checked').attr("id");
				let radioOpen = $("label[for='" + radioOpenId + "']").text();
				
				let radioAgeId = $("input[name=flexRadioDefault_age]:checked").attr("id");
				let radioAge = $("label[for='" + radioAgeId + "']").text();
				
				$("#selectOpen").val(radioOpen);
				$("#selectAge").val(radioAge);
				
				
				let bundle = $("#bundleCheck option:selected").text();
				let bundleTag = `<input type="hidden" name="bundleText" value=${bundle}>`;
				$(".bundleDiv").append(bundleTag);
				//$(".bundleDiv").html(bundleTag);
				
				$("#send_form").submit();
			} else {
				alert("제목을 입력 안하셨어요 :)");
			}	
		} else {
			alert("영상을 넣어주세요 :)");
		}
	});
});

// 영상 업로드 자바스크립트 끝

// 이미지 업로드 스크립트 시작
const touchImg = document.querySelector(".touch_img"),
imgBtnTag = touchImg.querySelector(".start_img_btn");
imgInputTag = touchImg.querySelector(".input_start_img"),
imgIcon = touchImg.querySelector(".icon_img");

imgBtnTag.onclick = () => {
	imgInputTag.click();
}

imgInputTag.addEventListener("change", function() {
	file = this.files[0];
 	
 	let fileType = file.type;
 	console.log(fileType);
 	//let vaildExtensions = ["video/quicktime", "video/mp4", "video/wmv", "video/avi", "video/avchd", "video/mpeg-2"]; // 모든 목록
 	
 	showFile2() // calling function 	
});

// 파일을 클릭, 업로드 했을때 발생
 function showFile2() {
	let fileReader = new FileReader();
    let reader = new FileReader();

    reader.fileName = file.name;
    
	fileReader.onload = function() {
        fileURL  = fileReader.result;
        let imgTag = `<img src="${fileURL}" class="save_img" />`;
     	imgIcon.innerHTML = imgTag;
	    
        fileReader.fileName = file.name;
	};
			
    fileReader.readAsDataURL(file);
 }

 
// 이미지 업로드 스크립트 시작
 