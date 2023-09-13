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
<!-- jQuery CDN -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

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

		

		  // JavaScript를 사용하여 페이지 로드
		  function loadPage(pageUrl,method) {
		    var xhttp = new XMLHttpRequest();
		    xhttp.onreadystatechange = function() {
		      if (this.readyState == 4 && this.status == 200) {
		        document.getElementById("bottomContent").innerHTML = this.responseText;
		      }
		    };
		    if(method === "GET"){
		    	
		    	xhttp.open("GET", pageUrl, false);
		    	
		    }else if(method === "POST"){
		    	
		    	xhttp.open("POST", pageUrl, false);
		    	
		    }
		    
		    xhttp.send();
		  }
		  loadPage("/user/listUser", "POST");
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

	 		loadPage("/user/listUser");
	 		
		}); 
	 	
	 	$( "a.nav-link:contains('판매상품등록')" ).on("click" , function() {

	 		loadPage("../product/addProductView.jsp", "GET");
	 		
		});
	 	
	 	$( "a.nav-link:contains('판매상품관리')" ).on("click" , function() {
	 		
	 		loadPage("/product/listProduct?menu=manage", "GET");
	 		
		}); 
	 	
	 	$( "a.nav-link:contains('상품검색')" ).on("click" , function() {
	 		
	 		loadPage("/product/listProduct?menu=search");
	 		
		});
	 	
	 	$( "a.nav-link:contains('구매이력조회')" ).on("click" , function() {
	 		
	 		loadPage("/purchase/listPurchase?menu=search");
	 		
		}); 
	 	
	 	$( "a.nav-link:contains('배송관리')" ).on("click" , function() {
	 		
	 		loadPage("/purchase/listPurchase?menu=manage");
	 		
		});
	 	
	 	$( "a.nav-link:contains('최근본상품')" ).on("click" , function() {

	 		history()
	 		
		}); 
	 	
		function history(){
			popWin = window.open("/history.jsp", "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}
		
	});
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
					<li class="nav-item"><a class="nav-link text-dark"
						aria-current="page" href="#">개인정보조회</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">회원정보조회</a>
					</li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">판매상품등록</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">판매상품관리</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">Projects</a>
					</li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">상품검색</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">구매이력조회</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">배송관리</a></li>
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
<div id="bottomContent">
  
                </div>

</html>