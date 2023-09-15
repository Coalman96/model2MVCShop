<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="EUC-KR">
<title>Model2 MVC Shop</title>

<!-- jQuery UI CDN(Content Delivery Network) 호스트 사용 -->
<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css"> -->
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
<script type="text/javascript">



	//==> jQuery 적용 추가된 부분
	$(document).ready(function() {

		$("button.btn-primary").eq(0).on("click", function() {
			
			  self.location = "/user/addUser";
			  
		});
		
		
		$("i.bi-door-open").on("click", function() {
			
			 self.location ="/user/logout"
			
		});
		
		//navigation
		$( "li.nav-item:contains('판매상품등록')" ).on("click" , function() {

			self.location ="/product/addProductView"
	 		//loadPage("/product/addProductView", "GET");
	 		
		});
		
		//$( "li.nav-item:contains('개인정보조회')" ).on("click" , function() {

			//self.location ="/user/getUser?userId=${user.userId}";
			
		//});
		
	 	$( "li.nav-item:contains('회원정보조회')" ).on("click" , function() {

	 		self.location ="/user/listUser";
	 		
		}); 
	 	
	 	
	 	$( "li.nav-item:contains('판매상품관리')" ).on("click" , function() {
	 		
	 		self.location ="/product/listProduct?menu=manage";
	 		
		}); 
	 	
	 	$( "li.nav-item:contains('상품검색')" ).on("click" , function() {
	 		
	 		self.location ="/product/listProduct?menu=search";
	 		
		});
	 	
	 	$( "li.nav-item:contains('구매이력조회')" ).on("click" , function() {
	 		
	 		self.location ="/purchase/listPurchase?menu=search";
	 		
		}); 
	 	
	 	$( "li.nav-item:contains('배송관리')" ).on("click" , function() {
	 		
	 		self.location ="/purchase/listPurchase?menu=manage";
	 		
		});
	 	
	 	$( "li.nav-item:contains('최근본상품')" ).on("click" , function() {

	 		history()
	 		
		}); 

		function history(){
			popWin = window.open("/history.jsp", "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}
		

	$('div.logo img').on('click',function(){
		
		
		self.location ="/index.jsp";
		
	})
	
	
	    // 모달 열기 버튼 클릭 시 모달 내용 업데이트
	    $("li.nav-item:contains('개인정보조회')").click(function () {
	        // AJAX 요청을 통해 다른 JSP 페이지 내용을 가져옵니다.
	        $.ajax({
	            url: "/user/getUser?userId=${user.userId}", // 다음 JSP 페이지의 경로
	            success: function (data) {
	                // 모달 내용 업데이트
	                $(".modal-content").html(data);
	            }
	        });
	    });


	 $(document).on("click", "button.btn-outline-primary:contains('확인')", function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('수정')" ).html() );
					    // 이름 유효성 검증
	    var name = $("input[name='userName']").val();
	    if (name == null || name.length < 1) {
	        alert("이름은 반드시 입력하셔야 합니다.");
	        return;
	    }
	
	    // 이메일 유효성 검증
	    var email = $("input[name='email']").val();
	    if (email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)) {
	        alert("이메일 형식이 아닙니다.");
	        return;
	    }
	
	    // 폼 데이터 수집
	    var formData = {
	        userName: name,
	        email: email,
	        userId: $("input[name='userId']").val(),
	        addr: $("input[name='addr']").val()
	    };
	    console.log(formData)
	    var phoneValue = $("option:selected").val() + "-" + $("input[name='phone2']").val() + "-" + $("input[name='phone3']").val();
	    formData.phone = phoneValue;
	
	    // AJAX 요청을 통해 다른 JSP 페이지 내용을 가져옵니다.
	    $.ajax({
	        url: "/user/updateUser", // 다음 JSP 페이지의 경로
	        method: "POST",
	        data: formData, // 수정된 데이터 전송
	        success: function (data) {
	            // 모달 내용 업데이트
	            $(".modal-content").html(data);
	        }
	    });
			//fncUpdateUser();
		 });


	});//end of jQuery
	</script>
<body>
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
<!-- Logo and Login Button Centered -->
<div class="logo col-lg-1 col-sm-4 col-4 d-flex text-left">
        <img src="https://avatars.githubusercontent.com/u/96984831?v=4" height="50" width="50" />
</div>
<!-- Logo and Login Button Centered -->

<!-- Navbar (중앙 정렬 추가) -->
<div class="col-lg-7 col-sm-4 col-4">
    <nav class="navbar navbar-expand-lg">
        <!-- Toggle button -->
        <button class="navbar-toggler mx-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <!-- Collapsible wrapper -->
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
            <!-- Left links -->
<ul class="navbar-nav me-auto mb-2 mb-lg-0 mx-auto">
    <li class="nav-item">
        <a class="nav-link" href="#">상품검색</a>
    </li>
    <c:if test="${ ! empty user }">
        <li class="nav-item" data-toggle="modal" data-target="#myModal">
            <a class="nav-link" href="#">개인정보조회</a>
        </li>
    </c:if>
    <c:if test="${user.role == 'admin'}">
        <li class="nav-item">
            <a class="nav-link" href="#">회원정보조회</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">판매상품등록</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">판매상품관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">배송관리</a>
        </li>
    </c:if>
    <c:if test="${user.role == 'user'}">
        <li class="nav-item">
            <a class="nav-link" href="#">구매이력조회</a>
        </li>
    </c:if>
</ul>
            <!-- Left links -->
        </div>
    </nav>
</div>
<!-- Navbar (중앙 정렬 추가) -->

<!-- Right elements -->
<div class="d-flex order-lg-last col-lg-2 col-sm-4 col-4 text-end justify-content-end pt-2">
    <div class="flex-center">
        <c:if test="${ empty user }">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                <i class="bi bi-person-circle" style="font-size: 25px;"></i>
            </button>
        </c:if>
        <c:if test="${ ! empty user }">
            <i class="bi bi-door-open" style="font-size:25px; font-style:normal;">Logout</i>
        </c:if>
    </div>
</div>
<!-- Right elements -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
            <!-- 모달 내용 표시 -->
        </div>
    </div>
</div>
			</div>
		</div>
	</div>
	<!-- Jumbotron -->
</header>
</body>
</html>
