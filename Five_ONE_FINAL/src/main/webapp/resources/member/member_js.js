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
	
	
	/* setting 페이지 navi css 제어*/
	
	function naviCss(){
		if ($(location).attr('pathname').indexOf('setting_profile.do') >= 0) {
			$("ul.info-navi").children('li').eq(0).css('border', '4px solid #fc942c');
			$("ul.info-navi").children('li').eq(0).css('background-color', '#fc942c');
			$("ul.info-navi").children('li').eq(0).css('font-weight', 'bold');
			$("ul.info-navi").children('li').eq(0).css('color', 'white');
		}else if ($(location).attr('pathname').indexOf('setting_channel.do') >= 0) {
			$("ul.info-navi").children('li').eq(1).css('border', '4px solid #fc942c');
			$("ul.info-navi").children('li').eq(1).css('background-color', '#fc942c');
			$("ul.info-navi").children('li').eq(1).css('font-weight', 'bold');
			$("ul.info-navi").children('li').eq(1).css('color', 'white');
		}else if ($(location).attr('pathname').indexOf('setting_protect.do') >= 0) {
			$("ul.info-navi").children('li').eq(2).css('border', '4px solid #fc942c');
			$("ul.info-navi").children('li').eq(2).css('background-color', '#fc942c');
			$("ul.info-navi").children('li').eq(2).css('font-weight', 'bold');
			$("ul.info-navi").children('li').eq(2).css('color', 'white');
		}else if ($(location).attr('pathname').indexOf('vidividi_premium.do') >= 0) {
			$("ul.info-navi").children('li').eq(3).css('border', '4px solid #fc942c');
			$("ul.info-navi").children('li').eq(3).css('background-color', '#fc942c');
			$("ul.info-navi").children('li').eq(3).css('font-weight', 'bold');
			$("ul.info-navi").children('li').eq(3).css('color', 'white');
		}
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
	
	