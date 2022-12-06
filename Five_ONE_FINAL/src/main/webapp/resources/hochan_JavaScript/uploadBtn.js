/**
 selecting all required elements
 */
 
 const dropArea = document.querySelector(".drag-area"),
 dragText = dropArea.querySelector("header"),
 button = dropArea.querySelector("button"),
 input = dropArea.querySelector("input");
 let file; // drop 한 파일의 전역 변수 이름명
 
 button.onclick = () => {
 	input.click();	
 }
 
 input.addEventListener("change", function() {
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
 dropArea.addEventListener('dragleave', (event) => {
 	event.preventDefault();
 	dropArea.classList.remove("active");
 	
 	
 	dragText.textContent = "Drag & Drop to Upload File";
 });
 
 // 사용자가 파일을 넣었을때
 dropArea.addEventListener('drop', (event) => {
 	event.preventDefault();
 	console.log("File drop");
 	
 	// 전역변수에 파일 넣기
 	file = event.dataTransfer.files[0];
 	showFile() // calling function
 });
 
 function showFile() {
 	let fileType = file.type;
 	console.log(file);
 	console.log(fileType);
 	
 	let vaildExtensions = ["video/quicktime", "video/mp4", "video/wmv", "video/avi", "video/avchd", "video/mpeg-2"]; // 모든 목록
 	
 	// 사용자가 vaildExtensions에 있는 이외의 파일을 넣었을때
 	if(vaildExtensions.includes(fileType)) {
 		let fileReader = new FileReader();
		console.log(fileReader);
		fileReader.onload = ()=> {
		    let fileURL  = fileReader.result;
		    let videoTag = `<video><source src="${fileURL}"></video>`;
			dropArea.innerHTML = videoTag; 
		}
	    fileReader.readAsDataURL(file);
 	} else {
 		alert("MOV, MP4, WMV, AVI, AVCHD, mpeg-2 파일을 넣어주세요.");
 	}
 }
 
 