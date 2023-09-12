<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Model2 MVC Shop</title>


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
		
		$("button.btn-secondary").eq(0).on("click", function() {
			
		$("form").attr("method","POST").attr("action","/user/login").submit();
		
		});
		
		$("i.bi-door-open").on("click", function() {
			
			 self.location ="/user/logout"
			
		});
		
	});
</script>

</head>

<header>


	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">환영합니다</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="userId" class="form-label">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId">
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary">로그인</button>
        <button type="button" class="btn btn-primary">회원가입</button>
      </div>
    </div>
  </div>
</div>
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
		<div
			class="container justify-content-center justify-content-md-between">
			<!-- Toggle button -->
			<button class="navbar-toggler border py-1 text-dark" type="button"
				data-mdb-toggle="collapse" data-mdb-target="#navbarLeftAlignExample"
				aria-controls="navbarLeftAlignExample" aria-expanded="false"
				aria-label="Toggle navigation">
				<i class="bi bi-list" style="font-size:23px;"></i>
			</button>

			<!-- Collapsible wrapper -->
			<div class="collapse navbar-collapse" id="navbarLeftAlignExample">
				<!-- Left links -->
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link text-dark"
						aria-current="page" href="#">Home</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">Categories</a>
					</li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">Hot
							offers</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">Gift
							boxes</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">Projects</a>
					</li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">Menu
							item</a></li>
					<li class="nav-item"><a class="nav-link text-dark" href="#">Menu
							name</a></li>
					<!-- Navbar dropdown -->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle text-dark" href="#"
						id="navbarDropdown" role="button" data-mdb-toggle="dropdown"
						aria-expanded="false"> Others </a> <!-- Dropdown menu -->
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">Action</a></li>
							<li><a class="dropdown-item" href="#">Another action</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#">Something else
									here</a></li>
						</ul></li>
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
			<h1>
				Best products & <br /> brands in our store
			</h1>
			<p>Trendy Products, Factory Prices, Excellent Service</p>
			<button type="button" class="btn btn-outline-light">Learn
				more</button>
			<button type="button"
				class="btn btn-light shadow-0 text-primary pt-2 border border-white">
				<span class="pt-1">Purchase now</span>
			</button>
		</div>
	</div>
	<!-- Jumbotron -->
</header>

<frameset rows="80,*" cols="*" frameborder="NO" border="0"
	framespacing="0">

	<frame src="/layout/top.jsp" name="topFrame" scrolling="NO" noresize>

	<frameset rows="*" cols="160,*" framespacing="0" frameborder="NO"
		border="0">
		<frame src="/layout/left.jsp" name="leftFrame" scrolling="NO" noresize>
		<frame src="" name="rightFrame" scrolling="auto">
	</frameset>

</frameset>

<noframes>
	<body>
	</body>
</noframes>

</html>