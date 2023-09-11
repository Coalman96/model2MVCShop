<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- jQuery UI CDN(Content Delivery Network) 호스트 사용 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script type="text/javascript">
	function fncGetProductList(currentPage) {
		
		if (currentPage == undefined) {
			currentPage = 1;
		}
	
		$('#currentPage').val(currentPage)
	
		$('form').attr("method", "POST").attr("action",
		"/product/listProduct?menu=${param.menu}").submit()
	
	}

	
	$(function () {
		
	    if($(window).height() == $(document).height()){
	    	
	    	loadMoreData()
	    	
	    }	
		// 현재 페이지 번호와 무한 스크롤 활성화 여부를 저장하는 변수
		let currentPage = 1;
		let infiniteScrollEnabled = true;
		
		
		
		// 스크롤 이벤트 핸들러
		window.addEventListener("scroll", function() {
			// 스크롤바 위치
		  let scrollHeight = document.documentElement.scrollHeight;
		  let scrollPosition = window.innerHeight + window.scrollY;

		// 무한 스크롤 활성화 상태에서 스크롤이 일정 위치에 도달하면 데이터를 가져옴
		  if (infiniteScrollEnabled && (scrollHeight - scrollPosition) / scrollHeight === 0) {
		    infiniteScrollEnabled = false; // 중복 요청을 막기 위해 활성화 상태를 비활성화로 변경
		    loadMoreData();
		  }
		});
	
	 function loadMoreData() {
		 let searchConditionValue = $('select[name="searchCondition"]').val();
		 let searchKeywordValue = $('input[name="searchKeyword"]').val();
		 let currentPageValue = parseInt($('input[name="currentPage"]').val()); // 현재 값 가져오기
		 	
		 function formatDate(manuDate) {
			  // "00000000"을 "0000-00-00" 형식으로 변경
			  return manuDate.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			}
		 
		 currentPageValue++; // 1 증가
		    
		    $('input[name="currentPage"]').val(currentPageValue); // 업데이트된 값 설정
		    
		    // 서버에 요청을 보내서 데이터를 가져옴.
		    $.ajax({
		      url: "/product/json/listProduct",
		      data: JSON.stringify({ currentPage: currentPageValue,searchKeyword:searchKeywordValue,searchCondition:searchConditionValue }), // 현재 페이지 정보를 서버에 전달
		      method:"POST",
		      contentType: "application/json",
		      dataType: "json",
		      success: function(data,status) {
		        // 성공적으로 데이터를 받아왔을 때, 데이터를 화면에 추가.
		        let prodList = data.list;
		        let resultPage = data.resultPage;
		        let i = (resultPage.currentPage - 1) * resultPage.pageSize;
				console.log(searchConditionValue)
				prodList.forEach(function(product) {
					  i++;
					  let row = "<tr class='ct_list_pop'>" 
				     			+"<td align='center' height='80px'>" + i + "</td>"
				      			+"<td></td>"
				      			+"<td align='left'><a href='/product/";
				    			if ("${param.menu}" === 'manage') {
				      			row += "updateProduct?prodNo=" + product.prodNo + "&menu=manage";
				    			} else if ("${param.menu}" === 'search') {
				      			row += "getProduct?prodNo=" + product.prodNo + "&menu=search";
				    			}
				    			row += "'>" + product.prodName + "</a></td>"
				      			+"<td></td>" 
				      			+"<td align='left'>" + product.price + "</td>" 
				      			+"<td></td>" 
				      			+"<td align='left'>" + formatDate(product.manuDate) + "</td>"
				      			+"<td></td>" 
				      			+"<td align='left'>"+(product.prodCount > 0 ? "판매중" : "재고 없음")+"</td>"
				      			+"</tr>";
	
					  $("table").eq(4).append(row);
					  $( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
						$("a").css("color" , "red");

						$(".ct_list_pop:nth-child(even)" ).css("background-color" , "whitesmoke");
					}); 
					
				infiniteScrollEnabled = true;
		 }//end of success
		
	 })//end of ajax
	
	}//end of loadMoreData
	//==> Autocomplete
	$('input[name="searchKeyword"]').autocomplete({
	    source: function(request, response) {
	    	let searchConditionValue = $('select[name="searchCondition"]').val();
	        $.ajax({
	            url: "/product/json/listProduct",
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
	
	$('td.ct_btn01:contains("검색")').on('click',function(){
		
		fncGetProductList(1)
		
	})
	
	  $( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$("a").css("color" , "red");

	$(".ct_list_pop:nth-child(even)" ).css("background-color" , "whitesmoke");
})//end of jQuery
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" >
<input type="hidden" name="currentPage" value="0" />
<input type="hidden" name="menu" value="${param.menu}" />
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					${param.menu eq 'manage' ? "상품관리" : "상품목록조회"}
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
			</select>
			<input type="text" name="searchKeyword"  
						value="${! empty search.searchKeyword ? search.searchKeyword : '' }"
						class="ct_input_g" style="width:200px; height:19px" />
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체  ${resultPage.totalCount} 건수</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명<br>
		${param.menu eq 'search' ? '<h7>(상품명 click:상세정보)</h7>' : '<h7>(상품명 click:수정)</h7>'}</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>
		<td class="ct_line02"></td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0"/>
		<c:forEach var="product" items="${list}">
			<c:set var="i" value="${i+1}"/>
				<tr class="ct_list_pop">
					<td align="center" height="80px"><fmt:parseNumber var="page" value="${(((resultPage.currentPage - 1) / resultPage.pageUnit) * resultPage.pageUnit) * resultPage.pageSize + i}" integerOnly="true"/>${page}</td>
					<td></td>
					<td align="left">
						<c:if test="${param.menu eq 'manage'}">
							<a href="/product/updateProduct?prodNo=${product.prodNo}&menu='manage'">${product.prodName}</a>
						</c:if>
						<c:if test="${param.menu eq 'search'}">
							<a href="/product/getProduct?prodNo=${product.prodNo}&menu='search'">${product.prodName}</a>
						</c:if>
					</td>
					<td></td>
					<td align="left">${product.price}</td>
					<td></td>
					<td align="left">${product.regDate}</td>
					<td></td>
					<td align="left">
						${product.prodCount > 0 ? '판매중' : '재고 없음'}
					</td>
					<td></td>	
				</tr>
		</c:forEach>
</table>
</form>

</div>
</body>
</html>
