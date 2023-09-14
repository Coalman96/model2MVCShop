<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Model2 MVC Shop</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- jQuery UI CDN(Content Delivery Network) 호스트 사용 -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
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
	//loadPage("/product/listProduct?menu=search", "GET");
	function loadPage(modulePath, method) {
		// Ajax를 사용하여 모듈 로드
		$.ajax({
			url : modulePath,
			type : method,
			success : function(data) {
				// 모듈 로드 성공 시 컨테이너 업데이트
				$("#bottomContent").html(data);
			},
			error : function() {
				// 모듈 로드 실패 시 처리
				$("#bottomContent").html("모듈을 로드하는 데 문제가 발생했습니다.");
			}
		});
	}
</script>
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	<!-- Jumbotron -->
	<div class="bg-primary text-white py-5">
		<div class="container py-5">
			<h1>
				비트캠프 <br /> DevOps 2기
			</h1>
			<p>Mini Project</p>
		</div>
	</div>
	<!-- Jumbotron -->
	<!-- Feature -->
	<section class="mt-5" style="background-color: #f5f5f5;">
		<div class="container text-dark pt-3">
			<header class="pt-4 pb-3">
				<h3>BitCamp</h3>
			</header>

			<div class="row mb-4">
				<div class="col-lg-4 col-md-6">
					<figure class="d-flex align-items-center mb-4">
						<span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
							<i class="bi bi-1-circle-fill"  style="font-size:35px; color: cornflowerblue;"></i>
						</span>
						<figcaption class="info">
							<h6 class="title">당일·새벽·익일 직배송</h6>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit
								sed do eiusmor</p>
						</figcaption>
					</figure>
					<!-- itemside // -->
				</div>
				<!-- col // -->
				<div class="col-lg-4 col-md-6">
					<figure class="d-flex align-items-center mb-4">
						<span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
							<i class="bi bi-2-circle-fill" style="font-size:35px; color: cornflowerblue;"></i>
						</span>
						<figcaption class="info">
							<h6 class="title">자정 전 주문, 새벽에 도착</h6>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit
								sed do eiusmor</p>
						</figcaption>
					</figure>
					<!-- itemside // -->
				</div>
				<!-- col // -->
				<div class="col-lg-4 col-md-6">
					<figure class="d-flex align-items-center mb-4">
						<span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
								<i class="bi bi-3-circle-fill" style="font-size:35px; color: cornflowerblue;"></i>
						</span>
						<figcaption class="info">
							<h6 class="title">해외 직구도 무료배송</h6>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit
								sed do eiusmor</p>
						</figcaption>
					</figure>
					<!-- itemside // -->
				</div>
				<!-- col // -->
				<div class="col-lg-4 col-md-6">
					<figure class="d-flex align-items-center mb-4">
						<span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
							<i class="bi bi-4-circle-fill" style="font-size:35px; color: cornflowerblue;"></i>
						</span>
						<figcaption class="info">
							<h6 class="title">더 좋은 식사의 시작</h6>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit
								sed do eiusmor</p>
						</figcaption>
					</figure>
					<!-- itemside // -->
				</div>
				<!-- col // -->
				<div class="col-lg-4 col-md-6">
					<figure class="d-flex align-items-center mb-4">
						<span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
							<i class="bi bi-5-circle-fill" style="font-size:35px; color: cornflowerblue;"></i>
						</span>
						<figcaption class="info">
							<h6 class="title">알찬 콘텐츠 라인업</h6>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit
								sed do eiusmor</p>
						</figcaption>
					</figure>
					<!-- itemside // -->
				</div>
				<!-- col // -->
				<div class="col-lg-4 col-md-6">
					<figure class="d-flex align-items-center mb-4">
						<span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
							<i class="bi bi-6-circle-fill" style="font-size:35px; color: cornflowerblue;"></i>
						</span>
						<figcaption class="info">
							<h6 class="title">친환경 프레시백으로 배송</h6>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit
								sed do eiusmor</p>
						</figcaption>
					</figure>
					<!-- itemside // -->
				</div>
				<!-- col // -->
			</div>
		</div>
		<!-- container end.// -->
	</section>
	<!-- Feature -->

	<!-- Blog -->
	<section class="mt-5 mb-4">
		<div class="container text-dark">
			<header class="mb-4">
				<h3>News</h3>
			</header>

			<div class="row">
				<div class="col-lg-3 col-md-6 col-sm-6 col-12">
					<article>
						<a href="#" class="img-fluid"> <img class="rounded w-100"
							src="/images/uploadFiles/qqqq.png"
							style="object-fit: cover;" height="160" />
						</a>
						<div class="mt-2 text-muted small d-block mb-1">
							<span> <i class="fa fa-calendar-alt fa-sm"></i> 2023.09.15
							</span> <a href="#"><h6 class="text-dark">DevOps 2기 반장</h6></a>
							<p>"반장으로서 모범을 보이겠습니다."</p>
						</div>
					</article>
				</div>
				<!-- col.// -->
				<div class="col-lg-3 col-md-6 col-sm-6 col-12">
					<article>
						<a href="#" class="img-fluid"> <img class="rounded w-100"
							src="https://bootstrap-ecommerce.com/bootstrap5-ecommerce/images/posts/2.webp"
							style="object-fit: cover;" height="160" />
						</a>
						<div class="mt-2 text-muted small d-block mb-1">
							<span> <i class="fa fa-calendar-alt fa-sm"></i> 2023.09.15
							</span> <a href="#"><h6 class="text-dark">How we handle
									shipping</h6></a>
							<p>When you enter into any new area of science, you almost
								reach</p>
						</div>
					</article>
				</div>
				<!-- col.// -->
				<div class="col-lg-3 col-md-6 col-sm-6 col-12">
					<article>
						<a href="#" class="img-fluid"> <img class="rounded w-100"
							src="https://bootstrap-ecommerce.com/bootstrap5-ecommerce/images/posts/3.webp"
							style="object-fit: cover;" height="160" />
						</a>
						<div class="mt-2 text-muted small d-block mb-1">
							<span> <i class="fa fa-calendar-alt fa-sm"></i> 2023.09.15
							</span> <a href="#"><h6 class="text-dark">How to promote brands</h6></a>
							<p>When you enter into any new area of science, you almost
								reach</p>
						</div>
					</article>
				</div>
				<!-- col.// -->
				<div class="col-lg-3 col-md-6 col-sm-6 col-12">
					<article>
						<a href="#" class="img-fluid"> <img class="rounded w-100"
							src="/images/uploadFiles/rrrr.png"
							style="object-fit: contain;" height="160" />
						</a>
						<div class="mt-2 text-muted small d-block mb-1">
							<span> <i class="fa fa-calendar-alt fa-sm"></i> 2023.09.15
							</span> <a href="#"><h6 class="text-dark">업계 대체불가 최고의 강사님</h6></a>
							<p>"오늘 나의 불행은 언젠가 내가 잘못 보낸 시간의 보복이다"</p>
						</div>
					</article>
				</div>
			</div>
		</div>
	</section>
	<!-- Blog -->

	<!-- <div id="bottomContent"></div> -->
	<div class="container">

		<footer
			class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
			<div class="col-md-4 d-flex align-items-center">
				<a href="/"
					class="mb-3 me-2 mb-md-0 text-body-secondary text-decoration-none lh-1">
					<svg class="bi" width="30" height="24">
						<use xlink:href="#bootstrap" /></svg>
				</a> <span class="mb-3 mb-md-0 text-body-secondary">&copy; 2023
					BitCamp</span>
			</div>

			<p>R.I.P 김찬우</p>
		</footer>
	</div>
</body>
</html>