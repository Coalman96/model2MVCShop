<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
<%@ page import="java.util.*"  %>
<%@page import="com.model2.mvc.common.util.*"%>
<%@ page import="com.model2.mvc.common.Search" %>
<%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>
<%@ page import="com.model2.mvc.service.domain.*" %>

<%
	List<Product> list=(List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	Search search = (Search)request.getAttribute("search");
	
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
%>
/////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////--%>
<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	

	
	$(function () {

		$('td.ct_btn01:contains("�˻�")').on('click',function(){
			
			fncGetProductList(1)
			
		})

		
	$(".ct_list_pop td:nth-child(3)").css("color" , "red");
							
	$(".ct_list_pop:nth-child(even)").css("background-color" , "whitesmoke");

	})
	
	function fncGetProductList(currentPage) {
	if (currentPage == undefined) {
		currentPage = 1;
	}
	$('#currentPage').val(currentPage)

	$('form').attr("method", "POST").attr("action",
	"/product/listProduct?menu=${param.menu}").submit()
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" >

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
					<%if(request.getParameter("menu").equals("manage")) {%>
						��ǰ����
					<%}else{ %>
						��ǰ�����ȸ
					<%} %>
					/////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>
					${param.menu eq 'manage' ? "��ǰ����" : "��ǰ�����ȸ"}
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
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
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
						�˻�
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
		<%-- 
		<td colspan="11" >��ü  <%= resultPage.getTotalCount() %> �Ǽ�,	���� <%= resultPage.getCurrentPage() %> ������</td>
		--%>
		<td colspan="11" >��ü  ${resultPage.totalCount} �Ǽ�,	���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>
		<td class="ct_line02"></td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
	<% 	
		int no=list.size();
		for(int i=0; i<list.size(); i++) {
			Product vo = (Product)list.get(i);
	%>
	<tr class="ct_list_pop">
		<td align="center"><%=vo.getRownum()%></td>
		<td></td>
		<td align="left">
			<%if(request.getParameter("menu").equals("manage")) {%>
			<a href="/updateProductView.do?prodNo=<%=Integer.toString(vo.getProdNo())%>"><%= vo.getProdName() %></a>
			<%}else{ %>
			<a href="/getProduct.do?prodNo=<%=Integer.toString(vo.getProdNo())%>"><%= vo.getProdName() %></a>
			<%} %>
		</td>
		<td></td>
		<td align="left"><%=vo.getPrice()%></td>
		<td></td>
		<td align="left"><%=vo.getRegDate()%></td>
		<td></td>
		<td align="left">
		
		</td>	
	
	</tr>
	<% } %>/////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>
	<c:set var="i" value="0"/>
		<c:forEach var="product" items="${list}">
			<c:set var="i" value="${i+1}"/>
				<tr class="ct_list_pop">
					<td align="center"><fmt:parseNumber var="page" value="${(((resultPage.currentPage - 1) / resultPage.pageUnit) * resultPage.pageUnit) * resultPage.pageSize + i}" integerOnly="true"/>${page}</td>
					<td></td>
					<td align="left">
						<c:if test="${param.menu eq 'manage'}">
							<a href="/product/updateProduct?prodNo=${product.prodNo}">${product.prodName}</a>
						</c:if>
						<c:if test="${param.menu eq 'search'}">
							<a href="/product/getProduct?prodNo=${product.prodNo}">${product.prodName}</a>
						</c:if>
					</td>
					<td></td>
					<td align="left">${product.price}</td>
					<td></td>
					<td align="left">${product.regDate}</td>
					<td></td>
					<td align="left">
						${product.prodCount > 0 ? '�Ǹ���' : '��� ����'}
					</td>
					<td></td>	
				</tr>
		</c:forEach>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	

</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value="0"/>
			<jsp:include page="../common/pageNavigator.jsp">
				<jsp:param name="file" value="Product" />
			</jsp:include>	
    	</td>
	</tr>
</table>

<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
