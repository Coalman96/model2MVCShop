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
<!-- bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
<script type="text/javascript">
	function fncGetProductList(currentPage) {
		
		if (currentPage == undefined) {
			currentPage = 1;
		}
	
		$('#currentPage').val(currentPage)
	
		//loadPage("/product/listProduct?menu=${param.menu}", "GET")
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

		    console.log($(window).height())
		    console.log(scrollHeight)
		  
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
				console.log(searchConditionValue)
				prodList.forEach(function(product) {
					  let row = "<div class='col-lg-3 col-md-6 col-sm-6 d-flex'>" 
				     			+"<div class='card w-100 my-2 shadow-2-strong'>"
				      			+"<a href='/product/"
				     			if ("${param.menu}" === 'manage') {
				     			row += "updateProduct?prodNo=" + product.prodNo + "&menu=manage";
				    			} else if ("${param.menu}" === 'search') {
					      			row += "getProduct?prodNo=" + product.prodNo + "&menu=search";
					    		}
				     			row += "'>"
				      			+"<img src='/images/uploadFiles/"+product.fileName.replace(',','')+"'"+ "class='card-img-top' style='aspect-ratio: 1 / 1' /></a>"
				      			+"<div class='card-body d-flex flex-column'>"
				      			+"<h5 class='card-title'>"
				    			+"<h5 class='card-title'>"+product.prodName + "</h5>"
				      			+"<p class='card-text'>"+product.price+"<span>"+(product.prodCount > 0 ? '판매중' : '재고 없음')+"</span></p>" 
				      			+"<div class='card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto'>" 
				      			+"<a href='#!' class='btn btn-primary shadow-0 me-1'>Add to cart</a>" 
				      			+"<span class='btn btn-light border px-2 pt-2 icon-hover'>"+product.prodName+"</span>"
				      			+"</div>" 
				      			+"</div>"
				      			+"</div>"
				      			+"</div>";
	
					  $("div.row").eq(2).append(row);
			
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
	
	$('button:contains("검색")').on('click',function(){
		
		
		fncGetProductList(1)
		
	})

	});//end of jQuery
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
 <form name="detailForm" >
<div style="width:98%; margin-left:10px;">
<section>
<input type="hidden" name="currentPage" value="0" />
<input type="hidden" name="menu" value="${param.menu}" />
  <div class="container my-5">
 <nav class="navbar row">
  <div class="container-fluid">
    <h3 class="relative position-relative">${param.menu eq 'manage' ? "상품관리" : "상품목록조회"}</h3>

	<div class="row">
	  <div class="col-4"> <!-- 너비 조절 -->
	    <select class="w-100 form-select" name="searchCondition">
	      <option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
	      <option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
	      <option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
	    </select>
	  </div>
	  <div class="col-8 d-flex"> <!-- 너비 조절 -->
	    <input class="form-control w-100" type="text" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
	     <button class="btn btn-outline-info w-50 text-14" type="submit">검색</button>
	  </div>
	</div>
  </div>
</nav>

    <div class="row">
    <c:forEach var="product" items="${list}">
      <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
        <div class="card w-100 my-2 shadow-2-strong">
        <c:if test="${param.menu eq 'manage'}">
       		<a href="/product/updateProduct?prodNo=${product.prodNo}&menu='manage'" >
        		<img src="/images/uploadFiles/${product.fileName.replace(',','')}" class="card-img-top" style="aspect-ratio: 1 / 1" />
       		</a>
        </c:if>
        <c:if test="${param.menu eq 'search'}">
       		<a href="/product/getProduct?prodNo=${product.prodNo}&menu='search'">
     	  		<img src="/images/uploadFiles/${product.fileName.replace(',','')}" class="card-img-top" style="aspect-ratio: 1 / 1" />
     		</a>
        </c:if>
          <div class="card-body d-flex flex-column">
            <h5 class="card-title">GoPro HERO6 4K Action Camera - Black</h5>
            <p class="card-text">${product.price}</p>
            <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
              <a href="#!" class="btn btn-primary shadow-0 me-1">Add to cart</a>
					<span class="btn btn-light border px-2 pt-2 icon-hover">${product.prodName}</span>
            </div>
          </div>
        </div>
      </div>
      </c:forEach>
    </div>
  </div>

</section>
</div>
  </form>

</body>
</html>
