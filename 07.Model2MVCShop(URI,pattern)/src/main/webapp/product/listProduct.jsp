<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- jQuery UI CDN(Content Delivery Network) ȣ��Ʈ ��� -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
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
		// ���� ������ ��ȣ�� ���� ��ũ�� Ȱ��ȭ ���θ� �����ϴ� ����
		let currentPage = 1;
		let infiniteScrollEnabled = true;
		
		
		
		// ��ũ�� �̺�Ʈ �ڵ鷯
		window.addEventListener("scroll", function() {
			// ��ũ�ѹ� ��ġ
		  let scrollHeight = document.documentElement.scrollHeight;
		  let scrollPosition = window.innerHeight + window.scrollY;

		// ���� ��ũ�� Ȱ��ȭ ���¿��� ��ũ���� ���� ��ġ�� �����ϸ� �����͸� ������
		  if (infiniteScrollEnabled && (scrollHeight - scrollPosition) / scrollHeight === 0) {
		    infiniteScrollEnabled = false; // �ߺ� ��û�� ���� ���� Ȱ��ȭ ���¸� ��Ȱ��ȭ�� ����
		    loadMoreData();
		  }
		});
	
	 function loadMoreData() {
		 let searchConditionValue = $('select[name="searchCondition"]').val();
		 let searchKeywordValue = $('input[name="searchKeyword"]').val();
		 let currentPageValue = parseInt($('input[name="currentPage"]').val()); // ���� �� ��������
		 	
		 function formatDate(manuDate) {
			  // "00000000"�� "0000-00-00" �������� ����
			  return manuDate.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			}
		 
		 currentPageValue++; // 1 ����
		    
		    $('input[name="currentPage"]').val(currentPageValue); // ������Ʈ�� �� ����
		    
		    // ������ ��û�� ������ �����͸� ������.
		    $.ajax({
		      url: "/product/json/listProduct",
		      data: JSON.stringify({ currentPage: currentPageValue,searchKeyword:searchKeywordValue,searchCondition:searchConditionValue }), // ���� ������ ������ ������ ����
		      method:"POST",
		      contentType: "application/json",
		      dataType: "json",
		      success: function(data,status) {
		        // ���������� �����͸� �޾ƿ��� ��, �����͸� ȭ�鿡 �߰�.
		        let prodList = data.list;
		        let resultPage = data.resultPage;
				console.log(searchConditionValue)
				prodList.forEach(function(product) {
					  let row = "<tr class='ct_list_pop'>" 
				     			+"<td align='center' height='80px'><img src="+"/images/uploadFiles/"+product.fileName.replace(',','')+" width='100px' height='100px' /></td>"
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
				      			+"<td align='left'>"+(product.prodCount > 0 ? "�Ǹ���" : "��� ����")+"</td>"
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
	                searchKeyword: request.term, // ���� �Էµ� �˻���
	                searchCondition: searchConditionValue
	            }),
	            method: "POST",
	            contentType: "application/json",
	            dataType: "json",
	            success: function (data) {
	            	let resultList = data.resultList; // resultList�� ���� ���信�� ����

	                // �ߺ� ���� ���� �߰�
	                let uniqueResults = [];
	                $.each(resultList, function(index, item) {
	                	//inArray������� �ߺ�������
	                    if ($.inArray(item, uniqueResults) === -1) {
	                        uniqueResults.push(item);
	                    }
	                });

	                response(uniqueResults); // �ߺ��� ���ŵ� ����� �ڵ��ϼ��� ���
	                console.log(data);
	            }//end of success
	        });//end of ajax
	    }
	});//end of Autocomplete
	
	$('td.ct_btn01:contains("�˻�")').on('click',function(){
		
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
		<td colspan="11" >��ü  ${resultPage.totalCount} �Ǽ�</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">�̸�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��<br>
		${param.menu eq 'search' ? '<h7>(��ǰ�� click:������)</h7>' : '<h7>(��ǰ�� click:����)</h7>'}</td>
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
		<c:forEach var="product" items="${list}">
				<tr class="ct_list_pop">
					<td align="center" height="80px">
					<img src="/images/uploadFiles/${product.fileName.replace(',','')}" width="100px" height="100px" />
					</td>
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
						${product.prodCount > 0 ? '�Ǹ���' : '��� ����'}
					</td>
					<td></td>	
				</tr>
		</c:forEach>
</table>
</form>

</div>
</body>
</html>
