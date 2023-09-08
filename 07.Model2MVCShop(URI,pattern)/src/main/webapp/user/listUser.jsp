<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">
<title>회원 목록 조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script type="text/javascript">
	
		// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
		function fncGetUserList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/user/listUser").submit();
		}
		

		
		
		//let currentPage = 
		
		//==>"검색" ,  userId link  Event 연결 및 처리
		 $(function() {
			 
				// 현재 페이지 번호와 무한 스크롤 활성화 여부를 저장하는 변수
				var currentPage = 1;
				var infiniteScrollEnabled = true;

				// 스크롤 이벤트 핸들러
				$(window).scroll(function() {
				    // 스크롤바 위치
				    var scrollHeight = $(document).height();
				    var scrollPosition = $(window).height() + $(window).scrollTop();

				    // 무한 스크롤 활성화 상태에서 스크롤이 일정 위치에 도달하면 데이터를 가져옵니다.
				    if (infiniteScrollEnabled && (scrollHeight - scrollPosition) / scrollHeight === 0) {
				        infiniteScrollEnabled = false; // 중복 요청을 막기 위해 활성화 상태를 비활성화로 변경
				        loadMoreData();
				    }
				});	 
			 
		 
			 function loadMoreData() {
			 //$(document).on('click','#sex',function(){
				 let searchConditionValue = $('select[name="searchCondition"]').val();
				 let searchKeywordValue = $('input[name="searchKeyword"]').val();
				 let currentPageValue = parseInt($('input[name="currentPage"]').val()); // 현재 값 가져오기
				    currentPageValue++; // 1 증가
				    $('input[name="currentPage"]').val(currentPageValue); // 업데이트된 값 설정
				    
				    // 서버에 요청을 보내서 데이터를 가져옵니다.
				    $.ajax({
				      url: "/user/json/listUser",
				      data: JSON.stringify({ currentPage: currentPageValue,searchKeyword:searchKeywordValue,searchCondition:searchConditionValue }), // 현재 페이지 정보를 서버에 전달
				      method:"POST",
				      contentType: "application/json",
				      dataType: "json",
				      success: function(data,status) {
				        // 성공적으로 데이터를 받아왔을 때, 데이터를 화면에 추가합니다.
				        var userList = data.list;
				        var resultPage = data.resultPage;
				        var i = (resultPage.currentPage - 1) * resultPage.pageSize;
						console.log(searchConditionValue)
						userList.forEach(function(user) {
							  i++;
							  var row = "<tr class='ct_list_pop'>"
											+"<td align='center'height='80px'>"+i+"</td>"
											+"<td></td>"
											+"<td align='left'>"+user.userId+"</td>"
											+"<td></td>"
											+"<td align='left'>"+user.userName+"</td>"
											+"<td></td>"
											+"<td align='left'>"+user.email+"</td>"
										+"</tr>"
										+"<tr>"
										+"<td id="+"'"+user.userId+"'"+"colspan='11' bgcolor='D6D7D6' height='1'></td>"
									+"</tr>";

							  $("table").eq(4).append(row);
							  $( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
								$("h7").css("color" , "red");
								
								//==> 아래와 같이 정의한 이유는 ??
								$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
							}); 
						
						if (userList.length === 0) {
			                $("#sex").hide();
			            }
						
						infiniteScrollEnabled = true;
				 }//end of success
				 
				 
			 })//end of ajax

			 }
			//==> 검색 Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
			 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
				fncGetUserList(1);
			});
			
			
			//==> userId LINK Event 연결처리
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
			$(document).on('click','.ct_list_pop td:nth-child(3)',function(){
					//alert(  $( this ).text().trim() );
					
					//////////////////////////// 추가 , 변경된 부분 ///////////////////////////////////
					//self.location ="/user/getUser?userId="+$(this).text().trim();
					////////////////////////////////////////////////////////////////////////////////////////////
					var userId = $(this).text().trim();
					$.ajax( 
							{
								url : "/user/json/getUser/"+userId ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {

									//Debug...
									//alert(status);
									//Debug...
									//alert("JSONData : \n"+JSONData);
									
									var displayValue = "<h3>"
																+"아이디 : "+JSONData.userId+"<br/>"
																+"이  름 : "+JSONData.userName+"<br/>"
																+"이메일 : "+JSONData.email+"<br/>"
																+"ROLE : "+JSONData.role+"<br/>"
																+"등록일 : "+JSONData.regDateString+"<br/>"
																+"</h3>";
									//Debug...									
									//alert(displayValue);
									$("h3").remove();
									$( "#"+userId+"" ).html(displayValue);
								}
						});
						////////////////////////////////////////////////////////////////////////////////////////////
					
			});
			
			//==> userId LINK Event End User 에게 보일수 있도록 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			//==> 아래와 같이 정의한 이유는 ??
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
			$('input[name="searchKeyword"]').autocomplete({
			    source: function(request, response) {
			        var searchConditionValue = $('select[name="searchCondition"]').val();
			        $.ajax({
			            url: "/user/json/listUser",
			            data: JSON.stringify({ 
			            	currentPage:0,
			                searchKeyword: request.term, // 현재 입력된 검색어
			                searchCondition: searchConditionValue
			            }),
			            method: "POST",
			            contentType: "application/json",
			            dataType: "json",
			            success: function (data) {
			            	let resultList = data.resultList; // resultList를 서버 응답에서 추출

			                // 중복 제거 로직 추가
			                var uniqueResults = [];
			                $.each(resultList, function(index, item) {
			                	//inArray사용으로 중복값제거
			                    if ($.inArray(item, uniqueResults) === -1) {
			                        uniqueResults.push(item);
			                    }
			                });

			                response(uniqueResults); // 중복이 제거된 결과를 자동완성에 사용
			                console.log(data);
			            }
			        });
			    }
			});
		});
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm">
			<input type="hidden" name="currentPage" value="0" />
			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">회원 목록조회</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
					</select> <input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : ''}"  
						class="ct_input_g" style="width: 200px; height: 20px">
					</td>
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;">검색</td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 ${resultPage.totalCount } 건수, 현재
						${resultPage.currentPage} 페이지</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">회원ID<br> <h7>(id
						click:상세정보)</h7>
					</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">회원명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">이메일</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>

				<c:set var="i" value="0" />
				<c:forEach var="user" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr class="ct_list_pop" >
						<td align="center"height="80px">${ i }</td>
						<td></td>
						<td align="left">${user.userId}</td>
						<td></td>
						<td align="left">${user.userName}</td>
						<td></td>
						<td align="left">${user.email}</td>
					</tr>
					<tr>
						<!-- //////////////////////////// 추가 , 변경된 부분 /////////////////////////////
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			////////////////////////////////////////////////////////////////////////////////////////////  -->
						<td id="${user.userId}" colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>

				</c:forEach>
			</table>
			
		</form>
	</div>

</body>

</html>