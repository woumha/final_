/**
 selecting all required elements
 */
 
 const dropArea = document.querySelector(".drag-area"),
 dragText = dropArea.querySelector("header"),
 button = dropArea.querySelector(".upload_click_btn"),
 input_hidden = dropArea.querySelector(".upload_input_btn");
 
 const uploadButton = document.querySelector(".video_upload_btn");
 let file; // drop 한 파일의 전역 변수 이름명
 let fileURL; // drop한 파일의 경로
 
 button.onclick = () => {
 	input_hidden.click();	
 }
 
 // 클릭버튼 눌렀을때
 input_hidden.addEventListener("change", function() {
 	file = this.files[0];
 	showFile() // calling function
 });
 
 // 사용자가 파일을 드래그 했을 때 발생
 dropArea.addEventListener('dragover', (event) => {
 	event.preventDefault();
 	dropArea.classList.add("active");
 	
 	dragText.textContent = "Release to Upload File";
 });
 
 // 사용자가 파일을 드래그 밖으로 뺏을때 했을 때 발생
 /*
	 dropArea.addEventListener('dragleave', (event) => {
	 	event.preventDefault();
	 	dropArea.classList.remove("active");
	 	
	 	
	 	dragText.textContent = "Drag & Drop to Upload File";
	 });
 */
 
 // 사용자가 파일을 넣었을때
 dropArea.addEventListener('drop', (event) => {
 	event.preventDefault();
 	
 	// 전역변수에 파일 넣기
 	file = event.dataTransfer.files[0];
 	showFile() // calling function
 });
 
 function showFile() {
 	let fileType = file.type;
 	
 	let vaildExtensions = ["video/quicktime", "video/mp4", "video/wmv", "video/avi", "video/avchd", "video/mpeg-2"]; // 모든 목록
 	
 	// 사용자가 vaildExtensions에 있는 이외의 파일을 넣었을때
 	if(vaildExtensions.includes(fileType)) {
 		let fileReader = new FileReader();
		console.log(fileReader);
		fileReader.onload = ()=> {
		    fileURL  = fileReader.result;
		    let videoTag = `<video><source src="${fileURL}"></video>`;
			dropArea.innerHTML = videoTag; 
			console.log(fileURL);
			
			let title = document.querySelector(".title_field");
			let title_value = document.querySelector(".upload_input_btn");
			console.log(title_value);
			
		}
	    fileReader.readAsDataURL(file);
 	} else {
 		alert("MOV, MP4, WMV, AVI, AVCHD, mpeg-2 파일을 넣어주세요.");
 	}
 }

 