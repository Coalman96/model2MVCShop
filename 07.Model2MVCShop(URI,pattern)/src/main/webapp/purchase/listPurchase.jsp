<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

	<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- jQuery UI CDN(Content Delivery Network) ȣ��Ʈ ��� -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {

		$('td.ct_btn01:contains("�˻�")').on('click', function() {

			fncGetPurchaseList(1)

		})

		$(".ct_list_pop td:nth-child(3) a").css("color", "red");

		$(".ct_list_pop:nth-child(even)").css("background-color", "whitesmoke");
		
		$('tr.ct_list_pop td b:contains("���ǵ���")').on('click', function() {
	        // ��� ó���� tranNo ���� �����ɴϴ�.
	        let tranNo = $(this).data('tranNo');
	        
	        // ������Ʈ�� tranCode ���� �����մϴ� (2�� ������� ��Ÿ���ϴ�).
	        let updateTranCode = 2;
	        
	        // Ajax ��û�� �����ϴ�.
	        $.ajax({
	            url: "/purchase/json/updateTranCode/2", // ������Ʈ�� ó���� ���� ��������Ʈ URL
	            method: "GET", // GET ��û�� ����մϴ�.
	            data: {
	                tranNo: tranNo,
	                tranCode: updateTranCode
	            },
	            success: function(data) {
	                $('td b:contains("���ǵ���")').remove();
	                 $("td:contains('�����')").text("��ۿϷ�");
	            },
	            error: function(xhr, status, error) {
	                // ��û�� ������ ��� ������ �ڵ带 ���⿡ �ۼ��մϴ�.
	                console.error("��� ������Ʈ ��û ����: " + error);
	            }
	        });
	    });
		
		

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

									<td width="93%" class="ct_ttl01">���� �����ȸ</td>

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
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
							<option value="2"
								${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select> <input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : '' }"
						class="ct_input_g" style="width: 200px; height: 19px" /></td>
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;">�˻�</td>
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
					<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ����
						${resultPage.currentPage} ������</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="50">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ��<br>
					<h7>(��ǰ�� click:������)</h7></td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">�ֹ���</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">��۳�¥</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">�����Ȳ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">���ż���</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				<c:set var="i" value="0" />
				<c:forEach var="purchase" items="${list}">
					<c:set var="i" value="${i+1}" />
					<tr class="ct_list_pop">
						<td align="center"><fmt:parseNumber
									var="page"
									value="${(((resultPage.currentPage - 1) / resultPage.pageUnit) * resultPage.pageUnit) * resultPage.pageSize + i}"
									integerOnly="true" />${page}</td>
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
						<c:if test="${fn:trim(purchase.tranCode) eq '1' }">���ſϷ�</c:if>
						<c:if test="${fn:trim(purchase.tranCode) eq '2' }">�����
						<b>���ǵ���</b></c:if> 
						<c:if test="${fn:trim(purchase.tranCode) eq '3' }">��ۿϷ�</c:if> 
						</td>
						<td></td>
						<td align="left">
						${purchase.prodCount}��
						</td>
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

			<!--  ������ Navigator �� -->
		</form>

	</div>

</body>
</html>