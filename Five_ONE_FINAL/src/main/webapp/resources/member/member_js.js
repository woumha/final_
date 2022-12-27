/* 채널 프사, 배너 배경 색 바꾸는 함수 */

 function changeBackColor(channelcode){
 	switch(channelcode.charAt(3)){
			case "1" :
				$(".channel-backcolor").css("background-color",DarkSalmon);
			break
			
			case "2" :
				$(".channel-backcolor").css("background-color","HotPink");
			break
			
			case "3" :
				$(".channel-backcolor").css("background-color","IndianRed");
			break
			
			case "4" :
				$(".channel-backcolor").css("background-color","lightpink");
			break
			
			case "5" :
				$(".channel-backcolor").css("background-color","Teal");
			break
			
			case "6" :
				$(".channel-backcolor").css("background-color","RoyalBlue");
			break
			
			case "7" :
				$(".channel-backcolor").css("background-color","Turquoise");
			break
			
			case "8" :
				$(".channel-backcolor").css("background-color","MediumPurple");
			break
			
			case "9" :
				$(".channel-backcolor").css("background-color","Wheat");
			break
			
			case "0" :
				$(".channel-backcolor").css("background-color","SeaGreen");
			break
			default:
				$(".channel-backcolor").css("background-color","#fc942c");
			break
		} 
 }
 
 
 /* member-input 클래스를 가진 인풋의 라벨을 플레이스홀더처럼 사용하는 함수 */

	function inputPlaceholder(){
	
		$(".member-input").on('focus', function(){
			$(this).prev('div').addClass('onfocus');
		});
				
		$(".member-input").on('blur', function(){
			if($(this).val() == ''){
				$(this).prev('div').removeClass('onfocus');
				$(this).prev('div').children().eq(0).hide();
				$(this).prev('div').children().eq(1).show();
			}
		});
		
		$(".member-pwd-input").on('focus', function(){
			$(this).parent().prev('div').addClass('onfocus');
		});
				
		$(".member-pwd-input").on('blur', function(){
			if($(this).val() == ''){
				$(this).parent().prev('div').removeClass('onfocus');
				$(this).parent().prev('div').children().eq(0).hide();
				$(this).parent().prev('div').children().eq(1).show();
			}
		});
		
		$(".member-input").focus();
		$(".member-input").blur();
		
		
		$(".member-pwd-input").focus();
		$(".member-pwd-input").blur();
				
	}
	
	/* navi CSS 제어 */
	function naviCSS(){
		$("ul.info-navi>li").on("mouseover", function(){
			$(this).addClass('info-navi-selected');
			$(this).siblings().removeClass('info-navi-selected');
		});
	}

	
	function noCalHolder(){
		$("input[type=date].date-placeholder").on("change", function(){
			if ($(this).val() == ""){
				$(this).addClass("date-empty");
			}else{
				$(this).removeClass("date-empty");
			}
		});
	} 
	
	
	
function getChannelList(code){
	
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	});
	
	console.log('ajax로 보낼 멤버 코드 : '+code);
	
	$.ajax({
		url : '/one/getChannelList.do',
		data: { member_code : code },
		dataType: "html",
		success : function(data) {
			$("#setting-channel-content").empty();
			$("#setting-channel-content").html(data);
		},
		error : function(){
			toastr.error('채널 목록 불러오기 실패!');
		}
	});
	
}



function modalShow(){
	$(".member-modal").fadeIn();
	$(".member-modal").css({
        "top": (($(window).height()-$(".member-modal").outerHeight())/2+$(window).scrollTop())+"px",
        "left": (($(window).width()-$(".member-modal").outerWidth())/2+$(window).scrollLeft())+"px"
     }); 
	$("body").css("overflow","hidden");
}

function modalHide(){
	$(".member-modal").fadeOut();
	$("body").css("overflow","auto");
}

function toastrSetup(){
	toastr.options = {
				  "closeButton": false,
				  "debug": false,
				  "newestOnTop": false,
				  "progressBar": false,
				  "positionClass": "toast-top-center",
				  "preventDuplicates": false,
				  "onclick": null,
				  "showDuration": "300",
				  "hideDuration": "1000",
				  "timeOut": "2000",
				  "extendedTimeOut": "2000",
				  "showEasing": "swing",
				  "hideEasing": "linear",
				  "showMethod": "fadeIn",
				  "hideMethod": "fadeOut"
				}
}




/* 카카오 주소 api 팝업 함수 */
function addrSearch() {
	
	 var zipcode = document.getElementById('input-zipcode');
	 var addr1 =  document.getElementById('input-addr1');
	 var addr2 =  document.getElementById('input-addr2');
    
	new daum.Postcode({
        oncomplete: function(data) {
        	zipcode.value = data.zonecode;
            addr1.value = data.roadAddress;
            
            // placeholder css 먹이는 구문..동시에 focus주면 마지막 구문만 적용됨. 왜지?
            zipcode.focus();
            setTimeout(() => {
            	addr1.focus();
            	setTimeout(() => {
					addr2.focus();
				}, 10);
			}, 10);
        }
    }).open();
	
}

/* 아이디, 비밀번호, 이름, 이메일, 전화번호 유효성 확인하는 정규식 */
let idReg = /^[a-zA-Z0-9][a-zA-Z0-9]{3,10}$/; //영대소문, 숫자 4~10글자
let pwdReg = /^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#])[\da-zA-Z!@#]{8,16}$/;
let nameReg = /^[가-힣a-zA-Z]+$/;
let emailReg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
let phoneReg = /^01[0179][0-9]{7,8}$/;


let idOk=false;
let pwdOk=false;
let pwdCheckOk=false;

		
/* 정규식에 부합하는지 확인하는 함수 */
function regCheck(checkType, value){
	let Reg = RegExp(checkType);
	let result = Reg.test(value);
	console.log(value);
	return result;
}

function memberPwdCheck(){
	$("#input-pwd").on('keyup', function(){
		if ($("#input-pwd").val() != ""){
			inputPwd();
			if ($("#input-pwd-confirm").val() != ""){
				inputPwdConfirm();
			}	
		}
	});
		
		
	$("#input-pwd-confirm").on('keyup', function(){
		if ($("#input-pwd").val() != ""){
			inputPwd();
			if ($("#input-pwd-confirm").val() != ""){
				inputPwdConfirm();
			}	
		}
	});
}

function inputPwd() {
	if (!regCheck(pwdReg, $("#input-pwd").val())){
		$("#input-pwd-check").text("영대소문자, 숫자, 특수문자를 모두 포함한 8~16글자를 입력하세요.");
		$("#input-pwd-check").css("color", "red");
		pwdOk=false;
	}else {
		$("#input-pwd-check").text("사용할 수 있는 비밀번호입니다.");
		$("#input-pwd-check").css("color", "green");
		pwdOk=true;
	}
	
	$("#input-pwd-check").show();
	$("#input-pwd-label").hide();
}

function inputPwdConfirm(){
	if ($("#input-pwd").val() == $("#input-pwd-confirm").val()){
		$("#input-pwd-confirm-check").text("비밀번호와 일치합니다.");
		$("#input-pwd-confirm-check").css("color", "green");
		pwdCheckOk=true;
	}else {
		$("#input-pwd-confirm-check").text("비밀번호와 같은 값을 입력하세요.");
		$("#input-pwd-confirm-check").css("color", "red");
		pwdCheckOk=false;
	}	
	
	$("#input-pwd-confirm-check").show();
	$("#input-pwd-confirm-label").hide();
}


function pwdShow(){
	$(".pwd-eye").on("click", function(){
		
		let showIcon = "<i class='bi bi-eye-fill'></i>";
		let hiddenIcon = "<i class='bi bi-eye-slash'></i>";
		
		if ($(this).hasClass('showEye')){
			$(this).empty();
			$(this).html(hiddenIcon);	
			$(this).removeClass('showEye');
			$(this).addClass('hiddenEye');
			$(this).siblings('input').removeClass('password');
			
		}else if ($(this).hasClass('hiddenEye')){
			$(this).empty();
			$(this).html(showIcon);	
			$(this).removeClass('hiddenEye');
			$(this).addClass('showEye');
			$(this).siblings('input').addClass('password');
		}
		
	});
}



/* 인증 시간 카운트 다운 함수*/


function numberPad(n, width) {
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

function authtimer() {
	
	let time = 180000;
	let min = 3;
	let sec = 60;
	
	$("#email-auth-span").text(min+":"+'00');
	
	CountDown = setInterval(function(){
					time = time-1000;
					min = time/(60*1000);
					
					if(sec > 0){
						sec = sec-1;
						$("#email-auth-span").text(Math.floor(min)+ ':' + numberPad(sec, 2));
					}
					if (sec == 0){
						sec = 60;
						$("#email-auth-span").text(Math.floor(min)+ ':' +'00');
					}
				},1000);
	
}
