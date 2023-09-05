<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:if test="${param.menu eq 'manage'}">
	<title>배송관리</title>
</c:if>
<c:if test="${param.menu eq 'search'}">
	<title>구매 목록조회</title>
</c:if>
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function() {

		$('td.ct_btn01:contains("검색")').on('click', function() {

			fncGetPurchaseList(1)

		})

		$(".ct_list_pop td:nth-child(3)").css("color", "red");

		$(".ct_list_pop:nth-child(even)").css("background-color", "whitesmoke");

	})

	function fncGetPurchaseList(currentPage) {
		if (currentPage == undefined) {
			currentPage = 1;
		}
		$('#currentPage').val(currentPage)

		$('form').attr("method", "POST").attr("action",
				"/purchase/listPurchase?menu=${param.menu}").submit()
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">


		<!-- <form name="detailForm" action="/purchase/listPurchase?menu=${param.menu}" method="post"> -->
		<form name="detailForm">
			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<c:if test="${param.menu eq 'manage'}">
									<td width="93%" class="ct_ttl01">배송관리</td>
								</c:if>
								<c:if test="${param.menu eq 'search'}">
									<td width="93%" class="ct_ttl01">구매 목록조회</td>
								</c:if>
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
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
							<option value="2"
								${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
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
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">회원ID</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">회원명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">전화번호</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">배송현황</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">정보수정</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				<c:set var="i" value="0" />
				<c:forEach var="purchase" items="${list}">
					<c:set var="i" value="${i+1}" />
					<tr class="ct_list_pop">
						<td align="center"><a
							href="/purchase/getPurchase?tranNo=${purchase.tranNo}"><fmt:parseNumber
									var="page"
									value="${(((resultPage.currentPage - 1) / resultPage.pageUnit) * resultPage.pageUnit) * resultPage.pageSize + i}"
									integerOnly="true" />${page}</a></td>
						<td></td>
						<td align="left"><a
							href="/user/getUser?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a>
						</td>
						<td></td>
						<td align="left">${purchase.receiverName}</td>
						<td></td>
						<td align="left">${purchase.receiverPhone}</td>
						<td></td>
						<td align="left">현재 <c:if
								test="${fn:trim(purchase.tranCode) eq '2' }">
					구매완료
				</c:if> <c:if test="${fn:trim(purchase.tranCode) eq '3' }">
					배송중
				</c:if> <c:if test="${fn:trim(purchase.tranCode) eq '4' }">
					배송완료
				</c:if> 상태 입니다.
						</td>
						<td></td>
						<td align="left"><c:if
								test="${fn:trim(purchase.tranCode) eq '2' }">
								<c:if test="${param.menu eq 'manage'}">
									<a
										href="/purchase/updateTranCodeByProd?tranNo=${purchase.tranNo}">배송하기</a>
								</c:if>
							</c:if> <c:if test="${fn:trim(purchase.tranCode) eq '3'}">
								<c:if test="${param.menu eq 'search'}">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}">물건도착</a>
								</c:if>
							</c:if></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="0" /> <jsp:include
							page="../common/pageNavigator.jsp">
							<jsp:param name="file" value="Purchase" />
						</jsp:include></td>
				</tr>
			</table>

			<!--  페이지 Navigator 끝 -->
		</form>

	</div>

</body>
</html>