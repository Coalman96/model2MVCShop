<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

	<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- jQuery UI CDN(Content Delivery Network) 호스트 사용 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script type="text/javascript">

	function fncGetPurchaseList(currentPage) {
		if (currentPage == undefined) {
			currentPage = 1;
		}
		$('#currentPage').val(currentPage)
	
		$('form').attr("method", "POST").attr("action",
				"/purchase/listPurchase?menu=${param.menu}").submit()
	}


	$(function() {

		$('td.ct_btn01:contains("검색")').on('click', function() {

			fncGetPurchaseList(0)

		})

		$(".ct_list_pop td:nth-child(3) a").css("color", "red");

		$(".ct_list_pop:nth-child(even)").css("background-color", "whitesmoke");
		
		if($(window).height() == $(document).height()){
	    	
	    	loadMoreData()
	    	
	    }	
		
		// 현재 페이지 번호와 무한 스크롤 활성화 여부를 저장하는 변수
		//let currentPage = 1;
		let infiniteScrollEnabled = true;
		
		//loadMoreData();
		
		// 스크롤 이벤트 핸들러
		window.addEventListener("scroll", function() {
			// 스크롤바 위치
		  let scrollHeight = document.documentElement.scrollHeight;
		  let scrollPosition = window.innerHeight + window.scrollY;
		  
		  console.log(scrollPosition)
		  console.log(scrollHeight)
		  
		  
		// 무한 스크롤 활성화 상태에서 스크롤이 일정 위치에 도달하면 데이터를 가져옴
		  if (infiniteScrollEnabled && (scrollHeight - scrollPosition) / scrollHeight === 0) {
		    infiniteScrollEnabled = false; // 중복 요청을 막기 위해 활성화 상태를 비활성화로 변경
		    loadMoreData();
		  }
		});
	
		
		//admin과 user의 구분
		let menu = "${param.menu}";
		console.log("현재 접속자는 "+menu)
		//console.log("ajax url은 "+ "/purchase/json/list"+(menu === 'manage' ? 'Sale' : 'Purchase'))
		
	 function loadMoreData() {
		 let searchConditionValue = $('select[name="searchCondition"]').val();
		 let searchKeywordValue = $('input[name="searchKeyword"]').val();
		 let currentPageValue = parseInt($('input[name="currentPage"]').val()); // 현재 값 가져오기
		 
		 //ordderDate 날짜변환
		 function formatDate(date) {
			  const year = date.getFullYear();
			  const month = String(date.getMonth() + 1).padStart(2, '0');
			  const day = String(date.getDate()).padStart(2, '0');
			  return year+"-"+month+"-"+day;
			}
		 
		 
		// function formatDate(divyDate) {
			  // "00000000"을 "0000-00-00" 형식으로 변경
			 // return divyDate.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			//}
		 
		 currentPageValue++; // 1 증가
		    
		    $('input[name="currentPage"]').val(currentPageValue); // 업데이트된 값 설정
		    
		    // 서버에 요청을 보내서 데이터를 가져옴.
		    $.ajax({
		      url: "/purchase/json/listPurchase",
		      data: JSON.stringify({ currentPage: currentPageValue,searchKeyword:searchKeywordValue,searchCondition:searchConditionValue }), // 현재 페이지 정보를 서버에 전달
		      method:"POST",
		      contentType: "application/json",
		      dataType: "json",
		      success: function(data,status) {
		        // 성공적으로 데이터를 받아왔을 때, 데이터를 화면에 추가.
		        let purchaseList = data.list;
		        let resultPage = data.resultPage;
				purchaseList.forEach(function(purchase) {
					  let row = "<tr class='ct_list_pop'>" +
					  "<td align='center' height='80px'><img src="+"/images/uploadFiles/"+purchase.purchaseProd.fileName.split(',')+" width='100px' height='100px' /></td>" +
		                "<td></td>" +
		                "<td align='center'><a href='/purchase/getPurchase?tranNo=" + purchase.tranNo + "'>" + purchase.purchaseProd.prodName + "</a></td>" +
		                "<td></td>" +
		                "<td align='left'>" + formatDate(new Date(purchase.orderDate)) + "</td>" +
		                "<td></td>" +
		                "<td align='left'>" + (purchase.divyDate != undefined ? purchase.divyDate.substring(0,10) : '') + "</td>" +
		                "<td></td>" +
		                "<td align='left'>" +
		                (purchase.tranCode.trim() === '1' ? '구매완료' : '') +
		                (purchase.tranCode.trim() === '2' ? '배송중' : '') +
		                (purchase.tranCode.trim() === '3' ? '배송완료' : '') +
		                (purchase.tranCode.trim() === '1' && menu === 'manage'? "<b data-tranNo='" + purchase.tranNo + "'>배송하기</b>" : '') +
		                (purchase.tranCode.trim() === '2' && menu === 'search'? "<b data-tranNo='" + purchase.tranNo + "'>물건도착</b>" : '') +
		                "</td>" +
		                "<td></td>" +
		                "<td align='left'>" + purchase.prodCount + "개</td>" +
		                "</tr>";
	
					  $("table").eq(4).append(row);
					  $( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
						$("a").css("color" , "red");

						$(".ct_list_pop:nth-child(even)" ).css("background-color" , "whitesmoke");
					}); 
					
				infiniteScrollEnabled = true;
		 },//end of success
		
		
	 })//end of ajax
	
	}//end of loadMoreData
		
	
	//==> Autocomplete
	$('input[name="searchKeyword"]').autocomplete({
	    source: function(request, response) {
	    	let searchConditionValue = $('select[name="searchCondition"]').val();
	        $.ajax({
	            //url: "/purchase/json/list"+(menu === 'manage' ? 'Sale' : 'Purchase'),
	            url: "/purchase/json/listPurchase",
	            data: JSON. stringify({ 
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
	                let uniqueResults = [];
	                $.each(resultList, function(index, item) {
	                	//inArray사용으로 중복값제거
	                    if ($.inArray(item, uniqueResults) === -1) {
	                        uniqueResults.push(item);
	                    }
	                });

	                response(uniqueResults); // 중복이 제거된 결과를 자동완성에 사용
	                console.log(data);
	            }//end of success
	        });//end of ajax
	    }
	});//end of Autocomplete
		
		
	$(document).on('click', 'tr.ct_list_pop td b:contains("물건도착")', function() {
	        // 배송 처리할 tranNo 값을 가져옵니다.
	        let tranNo = $(this).data('tranno');
	        console.log(tranNo)
	        // 업데이트할 tranCode 값을 설정합니다 (2는 배송중을 나타냅니다).
	        let updateTranCode = 3;
	        
	        let target = $(this);
	        
	        // Ajax 요청을 보냅니다.
	        $.ajax({
	            url: "/purchase/json/updateTranCode/"+tranNo+"/"+updateTranCode, // 업데이트를 처리할 서버 엔드포인트 URL
	            method: "GET", // GET 요청을 사용합니다.
	            success: function(data) {
	            	target.parent().text("배송완료");
	            	target.remove();
	            	
	            },
	            error: function(xhr, status, error) {
	                // 요청이 실패한 경우 실행할 코드를 여기에 작성합니다.
	                console.error("배송 업데이트 요청 실패: " + error);
	            }
	        });
	    });
		
	$(document).on('click', 'tr.ct_list_pop td b:contains("배송하기")', function() {
	        // 배송 처리할 tranNo 값을 가져옵니다.
	        let tranNo = $(this).data('tranno');
	        console.log(tranNo)
	        
	        // 업데이트할 tranCode 값을 설정합니다 (3는 물건도착을 나타냅니다).
	        let updateTranCode = 2;
	        
	 	    // 저장한 클릭한 요소를 변수에 저장
	        let target = $(this);

	        
	        // Ajax 요청을 보냅니다.
	        $.ajax({
	        	 url: "/purchase/json/updateTranCode/"+tranNo+"/"+updateTranCode, // 업데이트를 처리할 서버 엔드포인트 URL
	            method: "GET", // GET 요청을 사용합니다.
	            success: function(data) {
	                // 성공적으로 데이터가 업데이트되었을 때 실행할 코드를 여기에 작성합니다.
	                
	                target.parent().text("배송중");
	                target.remove();
	                
	                
	                // 예를 들어, 화면 업데이트 또는 다른 작업을 수행할 수 있습니다.
	            },
	            error: function(xhr, status, error) {
	                // 요청이 실패한 경우 실행할 코드를 여기에 작성합니다.
	                console.error("배송 업데이트 요청 실패: " + error);
	            }
	        });
	    });

	})


</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">


		<!-- <form name="detailForm" action="/purchase/listPurchase?menu=${param.menu}" method="post"> -->
		<form name="detailForm">
		<input type="hidden" name="currentPage" value="1" />
			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">${user.role eq 'admin' ? "배송관리" : "구매목록 조회"}</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37"></td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품명</option>
					</select> <input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : '' }"
						class="ct_input_g" style="width: 200px; height: 19px" /></td>
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
					<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재
						${resultPage.currentPage} 페이지</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="50">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명<br>
					<h7>(상품명 click:상세정보)</h7></td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">주문일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">배송날짜</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">배송현황</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">구매수량</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				<c:forEach var="purchase" items="${list}">
					<tr class="ct_list_pop">
						<td align="center"  height="80px">
						<img src="/images/uploadFiles/${purchase.purchaseProd.fileName.split(',')}" width="100px" height="100px" />
						</td>
						<td></td>
						<td class="ct_list_b" width="150">
						<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">
							${purchase.purchaseProd.prodName}</a>
						</td>
						<td></td>
						<td align="left">${purchase.orderDate}</td>
						<td></td>
						<td align="left">${purchase.divyDate.substring(0,10)}</td>
						<td></td>
						<td align="left">
						<c:if test="${fn:trim(purchase.tranCode) eq '1' }">
						    구매완료
						    <c:choose>
						        <c:when test="${param.menu eq 'manage' }">
						            <b data-tranNo="${purchase.tranNo}">배송하기</b>
						        </c:when>
						        <c:otherwise>
						            <!-- 다른 경우에 대한 처리 -->
						        </c:otherwise>
						    </c:choose>
						</c:if>
						
						<c:if test="${fn:trim(purchase.tranCode) eq '2' }">
						    배송중
						    <c:choose>
						        <c:when test="${param.menu eq 'search' }">
						            <b data-tranNo="${purchase.tranNo}">물건도착</b>
						        </c:when>
						        <c:otherwise>
						            <!-- 다른 경우에 대한 처리 -->
						        </c:otherwise>
						    </c:choose>
						</c:if>
						
						<c:if test="${fn:trim(purchase.tranCode) eq '3' }">
						    배송완료
						</c:if>
						</td>
						<td></td>
						<td align="left">
						${purchase.prodCount}개
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>

	</div>

</body>
</html>