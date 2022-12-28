/**
 * 
 */
 
const card = document.querySelector(".left_card");

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
			
			$("#formData").submit();
		} else {
			alert("제목을 입력 안하셨어요 :)");
		}
	});
	
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
function modal(videoCode, channelCode) {
	$.ajaxSetup({
			ContentType: "application/x-www-form-urlencoded;charset=UTF-8", //한글처리
			type: "post"
	});
	
	$.ajax({
		url: getContextPath() + "/video_update_modal.do",
		data: {
			"video_code" : videoCode,
			"channl_code": channelCode
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
	let ownerCode = $("#oCc").val();
	
	
	
	$.ajax({
		url : getContextPath() + '/bundleMaking.do',
		data : {
			"code": ownerCode,
			"bundleN": bundleName
		},
		datatype : 'html',
		success : function(data) {
			let arr = data;
			
			if(arr == "[]") {
				loading_playlist = false;
			} else {
				let list = JSON.parse(data);
				let li = "";
				$(list).each(function () {
					li += "<li class='w-100 index'>";
					li += '<a class="nav-link px-3 bundle_text" style="display: inline-block;" onclick="bundleDetail(&quot;' + this.bundle_code + '&quot;)">';
					li += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-music-note-list icon black' viewBox='0 0 16 16'><path d='M12 13c0 1.105-1.12 2-2.5 2S7 14.105 7 13s1.12-2 2.5-2 2.5.895 2.5 2z'/>";
					li += "<path fill-rule='evenodd' d='M12 3v10h-1V3h1z'/><path d='M11 2.82a1 1 0 0 1 .804-.98l3-.6A1 1 0 0 1 16 2.22V4l-5 1V2.82z'/>";
					li += "<path fill-rule='evenodd' d='M0 11.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 1 0 1H.5a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 .5 7H8a.5.5 0 0 1 0 1H.5a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 .5 3H8a.5.5 0 0 1 0 1H.5a.5.5 0 0 1-.5-.5z'/>";
					li += "</svg>"
					li += "<span class='d-none d-sm-inline child_bundle'>"+ this.bundle_title +"</span>	</a>";
					
					li += '<button id="bDelIndex" class="delicon" onclick="bundleDel(&quot;' + this.bundle_code + '&quot;)">';
					li += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3' viewBox='0 0 16 16'>";
					li += "<path d='M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z'/>";
					li += "</svg>";
					li += "</button>"
					li += "</li>";
				});
				alert('추가 성공');
				$("#bundleList").html(li);
				$(".bundleNameField").val("");
			}
		},
		error: function() {
			console.log("재생목록 추가 실패");
		}
	});
}

// 재생목록 삭제
function bundleDel(bundleCode) {	
	let ownerCode = $("#oCc").val();
	
	$.ajax({
		url: getContextPath() + "/BundleDelete.do",
		data: {
			"bundleCode": bundleCode,
			"ownerCode": ownerCode
		},
		datatype: 'html',
		success: function(data) {
			let arr = data;
			
			if(arr == "[]") {
				loading_playlist = false;
			} else {
				let list = JSON.parse(data);
				let li = "";
				$(list).each(function () {
					li += "<li class='w-100 index'>";
					li += '<a class="nav-link px-3 bundle_text" style="display: inline-block;" onclick="bundleDetail(&quot;' + this.bundle_code + '&quot;)">';
					li += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-music-note-list icon black' viewBox='0 0 16 16'><path d='M12 13c0 1.105-1.12 2-2.5 2S7 14.105 7 13s1.12-2 2.5-2 2.5.895 2.5 2z'/>";
					li += "<path fill-rule='evenodd' d='M12 3v10h-1V3h1z'/><path d='M11 2.82a1 1 0 0 1 .804-.98l3-.6A1 1 0 0 1 16 2.22V4l-5 1V2.82z'/>";
					li += "<path fill-rule='evenodd' d='M0 11.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 1 0 1H.5a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 .5 7H8a.5.5 0 0 1 0 1H.5a.5.5 0 0 1-.5-.5zm0-4A.5.5 0 0 1 .5 3H8a.5.5 0 0 1 0 1H.5a.5.5 0 0 1-.5-.5z'/>";
					li += "</svg>"
					li += "<span class='d-none d-sm-inline child_bundle'>"+ this.bundle_title +"</span>	</a>";
					
					li += '<button id="bDelIndex" class="delicon" onclick="bundleDel(&quot;' + this.bundle_code + '&quot;)">';
					li += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3' viewBox='0 0 16 16'>";
					li += "<path d='M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z'/>";
					li += "</svg>";
					li += "</button>"
					li += "</li>";		
				});
				alert('삭제 완료');
				$("#bundleList").html(li);
			}
		},
		error: function() {
			alert('삭제 실패');
		}
	});
}

function bundleDetail(bundle_code) {
		let code = bundle_code; // 재생목록 코드
		
		$.ajax({
			url: getContextPath() + "/videoListBundle.do",
			data: {
				'bundleCode': code 
			},
			datatype: 'html',
			success: function(data) {
				let check = data;
				
				if(check == "[]") {
					loading_playlist = false;
				} else {
					let list = JSON.parse(data);
					let li = "";
					
					$(list).each(function() {
						li += '<tr onclick="modal(&quot;'+ this.video_code +'&quot;, &quot;'+ $("#oCc").val() +'&quot;)" data-toggle="modal" data-target="#MoaModal">';
						if(this.video_img == undefined) {
							li += '<td><div><video class="show_file"><source src="'+ getContextPath()+'/resources/AllChannel/'+ this.channel_code + '/' + this.video_title +'.mp4"></video></div>';							
						} else if(this.video_img != undefined) {
							li += '<td><div><img clss="show_file" src="' + getContextPath() + '/resources/AllChannel/'+ this.channel_code + '/thumbnail/' + this.video_img + '" style="background-size: cover; width: 80%; height: 80px;"></div></td>';
						}
						
						li += '<td>'+ this.video_title +'</td>';
						if(this.video_open == 1) {
							li += '<td>공개</td>';
						} else if(this.video_open == 0) {
							li += '<td>비공개</td>';
						}
						if(this.video_age == "true") {
							li += '<td>아동용</td>';
						} else {
							li += '<td>성인용</td>';
						}
						li += '<td>'+ this.video_view_cnt +'</td>';
						li += '<td>' + this.video_regdate + '</td>';
						if(this.video_good == 0) {
							li += '<td>' + 0% + '</td>';
						} else {
							let good = this.video_good;
							let bad = this.video_bad;
				
							let answer = (good - bad) / bad;
							li += '<td>' + answer +'</td>';
						}
						li += '<td>';
						li += '<div class="dropdown">';
						li += '<button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">';
						li += ' <i class="bi bi-list-ul"></i>';
						li += '</button>';
						li += '<ul class="dropdown-menu">';						
						li += '<li><a class="dropdown-item" onclick="modal(&quot;'+ this.video_code +'&quot;, &quot;'+ this.channel_code +'&quot;)" data-toggle="modal" data-target="#MoaModal">수정</a></li>';
						li += '<li><a class="dropdown-item" onclick="videoDelete(&quot;' + this.video_cdoe + '&quot;, &quot;' + this.channel_code + '&quot;, &quot' + this.video_title + '&quot;)">삭제</a></li>';
						li += '</ul>';
						li += '</div>';
						li += '</td>';
						li += '</tr>'
					});
					$(".manager_tbody").html(li).trigger("create");
				}
			},
			error: function() {
				alert('불러오기 실패');
			}
		});
		
	}
	
function changeBtn() {
	$("#videoMake").click();
}

function videoDelete(videoCode, channelCode, title) {
	if(!(confirm('영상을 삭제하면 다시 불러올 수 없습니다. 그래도 삭제하시겠습니까?'))) {
		
	} else {
		$.ajax({
		url: getContextPath() + "/videoDelete.do",
		data: {
			"video_code": videoCode,
			"channelCode": channelCode,
			"title": title
		},
		datatype: "json",
		success: function(data) {
			let check = data;
				
				if(check == "[]") {
					loading_playlist = false;
				} else {
					let list = JSON.parse(data);
					let li = "";
					
					$(list).each(function() {
						li += '<tr onclick="modal(&quot;'+ this.video_code +'&quot;, &quot;'+ $("#oCc").val() +'&quot;)" data-toggle="modal" data-target="#MoaModal">';
						if(this.video_img == undefined) {
							li += '<td><div><video class="show_file"><source src="'+ getContextPath()+'/resources/AllChannel/'+ this.channel_code + '/' + this.video_title +'.mp4"></video></div>';							
						} else if(this.video_img != undefined) {
							li += '<td><div><img clss="show_file" src="' + getContextPath() + '/resources/AllChannel/'+ this.channel_code + '/thumbnail/' + this.video_img + '" style="background-size: cover; width: 80%; height: 80px;"></div></td>';
						}
						
						li += '<td>'+ this.video_title +'</td>';
						if(this.video_open == 1) {
							li += '<td>공개</td>';
						} else if(this.video_open == 0) {
							li += '<td>비공개</td>';
						}
						if(this.video_age == "true") {
							li += '<td>아동용</td>';
						} else {
							li += '<td>성인용</td>';
						}
						li += '<td>'+ this.video_view_cnt +'</td>';
						li += '<td>' + this.video_regdate + '</td>';
						if(this.video_good == 0) {
							li += '<td>' + 0% + '</td>';
						} else {
							let good = this.video_good;
							let bad = this.video_bad;
				
							let answer = (good - bad) / bad;
							li += '<td>' + answer +'</td>';
						}
						li += '<td>';
						li += '<div class="dropdown">';
						li += '<button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">';
						li += ' <i class="bi bi-list-ul"></i>';
						li += '</button>';
						li += '<ul class="dropdown-menu">';						
						li += '<li><a class="dropdown-item" onclick="modal(&quot;'+ this.video_code +'&quot;, &quot;'+ this.channel_code +'&quot;)" data-toggle="modal" data-target="#MoaModal">수정</a></li>';
						li += '<li><a class="dropdown-item" onclick="videoDelete(&quot;' + this.video_cdoe + '&quot;, &quot;' + this.channel_code + '&quot;, &quot' + this.video_title + '&quot;)">삭제</a></li>';
						li += '</ul>';
						li += '</div>';
						li += '</td>';
						li += '</tr>'
					});
					$(".manager_tbody").html(li).trigger("create");
				}
		},
		error: function() {
			alert("오류");
		}
	});	
	}
}

function managerModify(channelCode) {
	
	$.ajax({
		url: getContextPath() + "/channelModify.do",
		data: {
			"channelCode": channelCode	
		},
		datatype: "html",
		success: function(data) {
			$(".video_detail_area").html(data);
		},
		error: function() {
			alert('채널 수정 페이지 오류');
			location.reload();
		}
	});
}