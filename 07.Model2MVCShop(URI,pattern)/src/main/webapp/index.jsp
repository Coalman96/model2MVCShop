<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Model2 MVC Shop</title>

<style type="text/css">
	
	.bg-primary{
		
		background-image: url("/images/ima112.jpg");
	
	}

</style>
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



	//==> jQuery 적용 추가된 부분
	$(document).ready(function() {

		//$('form[name="detailForm"]').attr("method", "POST").attr("action","/product/listProduct?menu=${param.menu}").submit()


		  
		  // 페이지 로드 함수 호출
		  //loadPage("/user/listUser.jsp");
		
		//==> login Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)


		//==> login Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("td[width='56']:contains('logout')").on("click", function() {
			//Debug..
			//alert(  $( "td[width='56']:contains('logout')" ).html() );
			$(window.parent.document.location).attr("href", "/user/logout");
		});
		
		
		$("button.btn-primary").eq(0).on("click", function() {
			
			  self.location = "/user/addUser";
			  
		});
		
		
		$("i.bi-door-open").on("click", function() {
			
			 self.location ="/user/logout"
			
		});
		
		//navigation
		$( "a.nav-link:contains('개인정보조회')" ).on("click" , function() {

			loadPage("/user/getUser?userId=${user.userId}", "GET");
			console.log("아시발")
		});
		
	 	$( "a.nav-link:contains('회원정보조회')" ).on("click" , function() {

	 		loadPage("/user/listUser" , "GET");
	 		
		}); 
	 	
	 	$( "a.nav-link:contains('판매상품등록')" ).on("click" , function() {

	 		loadPage("../product/addProductView.jsp", "GET");
	 		
		});
	 	
	 	$( "a.nav-link:contains('판매상품관리')" ).on("click" , function() {
	 		
	 		loadPage("/product/listProduct?menu=manage", "GET");
	 		
		}); 
	 	
	 	$( "a.nav-link:contains('상품검색')" ).on("click" , function() {
	 		
	 		loadPage("/product/listProduct?menu=search", "GET");
	 		
		});
	 	
	 	$( "a.nav-link:contains('구매이력조회')" ).on("click" , function() {
	 		
	 		loadPage("/purchase/listPurchase?menu=search", "GET");
	 		
		}); 
	 	
	 	$( "a.nav-link:contains('배송관리')" ).on("click" , function() {
	 		
	 		loadPage("/purchase/listPurchase?menu=manage", "GET");
	 		
		});
	 	
	 	$( "a.nav-link:contains('최근본상품')" ).on("click" , function() {

	 		history()
	 		
		}); 
	 	
		$('td.ct_btn01:contains("검색")').on('click',function(){
			
			console.log("하 시발")
			fncGetProductList(1)
			
		})
	 	
		function history(){
			popWin = window.open("/history.jsp", "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}
		//기존 listProduct 부분
		function fncGetProductList(currentPage) {
			
			if (currentPage == undefined) {
				currentPage = 1;
			}
		
			$('#currentPage').val(currentPage)
		
			loadPage("/product/listProduct?menu=${param.menu}", "POST")

		
		}
		//if($(window).height() == $(document).height()){
	    	
	    	//loadMoreData()
	    	
	   // }	
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
				console.log(searchConditionValue)
				prodList.forEach(function(product) {
					  let row = "<tr class='ct_list_pop'>" 
				     			+"<td align='center' height='80px'><img src="+"/images/uploadFiles/"+product.fileName+" width='100px' height='100px' /></td>"
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

<header>


	<!-- Modal -->
	<form action="/user/login" method="POST"> 
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">환영합니다</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
          <div class="mb-3">
            <label for="userId" class="form-label">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId">
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password">
          </div>
        
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-secondary">로그인</button>
        <button type="button" class="btn btn-primary">회원가입</button>
      </div>
      
    </div>
  </div>
</div>
</form>
	<!-- Jumbotron -->
	<div class="text-center bg-white border-bottom">
		<div class="container">
			<div class="row gy-3 d-flex justify-content-between">
				<!-- Left elements -->
				<div class="col-lg-2 col-sm-4 col-4">
					<a href="" target="_blank" class="float-start"> <img
						src="https://avatars.githubusercontent.com/u/96984831?v=4"
						height="50" width="50" />
					</a>
				</div>
				<!-- Left elements -->

				<!-- Right elements -->
				<div class="d-flex order-lg-last col-lg-5 col-sm-8 col-8 text-end justify-content-end align-items-center">
					<div class="flex-end ">
					<c:if test="${ empty user }">
		              <!-- Button trigger modal -->
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#exampleModal">
							<i class="bi bi-person-circle" style="font-size: 25px;"></i>
						</button>
		            </c:if>   
		            <c:if test="${ ! empty user }">
		           <i class="bi bi-door-open" style="font-size:25px; font-style:normal;">Logout</i>
		           </c:if>
					</div>
				</div>
				<!-- Right elements -->


			</div>
		</div>
	</div>
	<!-- Jumbotron -->

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-light bg-white">
		<!-- Container wrapper -->
		<div class="container justify-content-center justify-content-md-between">
			<!-- Toggle button -->
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarLeftAlignExample" aria-controls="navbarLeftAlignExample" aria-expanded="false" aria-label="Toggle navigation">
   			   <span class="navbar-toggler-icon"></span>
   			</button>

			<!-- Collapsible wrapper -->
			<div class="collapse navbar-collapse" id="navbarLeftAlignExample">
				<!-- Left links -->
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link text-dark" href="#">상품검색</a></li>
					<c:if test="${ ! empty user }">
					<li class="nav-item"><a class="nav-link text-dark"
						aria-current="page" href="#">개인정보조회</a></li>
					</li>
					<c:if test="${user.role == 'admin'}">
					<li class="nav-item"><a class="nav-link text-dark" href="#">회원정보조회</a>
					<li class="nav-item"><a class="nav-link text-dark" href="#">판매상품등록</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">판매상품관리</a></li>
					</c:if>
					<c:if test="${user.role == 'user'}">
					<li class="nav-item"><a class="nav-link text-dark" href="#">구매이력조회</a></li>
					</c:if>
					<li class="nav-item"><a class="nav-link text-dark" href="#">배송관리</a></li>
					
					</c:if>
					<!-- Navbar dropdown -->
					<li class="nav-item dropdown">
			          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
			            기타
			          </a>
			          <ul class="dropdown-menu">
			            <li><a class="dropdown-item" href="#">최근 본 상품</a></li>
			            <!-- <li><hr class="dropdown-divider"></li> -->
			          </ul>
			        </li>
				</ul>
				<!-- Left links -->
			</div>
		</div>
		<!-- Container wrapper -->
	</nav>
	<!-- Navbar -->
	<!-- Jumbotron -->
	<div class="bg-primary text-white py-5">
		<div class="container py-5">
			<h1 class="text-black">
				Accelerando
			</h1>
			<p class="text-black">전주식당 수저 상습절도범 김형구</p>
			<button type="button" class="btn btn-outline-light">더보기</button>
			<button type="button"
				class="btn btn-light shadow-0 text-primary pt-2 border border-white">
				<span class="pt-1">신고하기</span>
			</button>
		</div>
	</div>
	<!-- Jumbotron -->
</header>
<!-- <div id="bottomContent">
</div> -->
<section>
<form name="detailForm" >
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
	     <button class="btn btn-outline-info w-50 text-14" type="button">검색</button>
	  </div>
	</div>
  </div>
</nav>

    <div class="row">
    <c:forEach var="product" items="${list}">
      <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
        <div class="card w-100 my-2 shadow-2-strong">
          <img src="/images/uploadFiles/${product.fileName.replace(',','')}" class="card-img-top" style="aspect-ratio: 1 / 1" />
          <div class="card-body d-flex flex-column">
            <h5 class="card-title">GoPro HERO6 4K Action Camera - Black</h5>
            <p class="card-text">${product.price}</p>
            <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
              <a href="#!" class="btn btn-primary shadow-0 me-1">Add to cart</a>
              	<c:if test="${param.menu eq 'manage'}">
					<a href="/product/updateProduct?prodNo=${product.prodNo}&menu='manage'" class="btn btn-light border px-2 pt-2 icon-hover">${product.prodName}</a>
				</c:if>
				<c:if test="${param.menu eq 'search'}">
					<a href="/product/getProduct?prodNo=${product.prodNo}&menu='search'" class="btn btn-light border px-2 pt-2 icon-hover">${product.prodName}</a>
				</c:if>
            </div>
          </div>
        </div>
      </div>
      </c:forEach>
    </div>
  </div>
  </form>
</section>
<!-- Products -->
</html>