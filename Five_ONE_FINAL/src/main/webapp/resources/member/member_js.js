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
		
		$(".member-input").focus();
		$(".member-input").blur();
		
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