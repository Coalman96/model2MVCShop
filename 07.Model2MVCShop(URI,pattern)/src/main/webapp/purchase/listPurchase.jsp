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

	function fncGetPurchaseList(currentPage) {
		if (currentPage == undefined) {
			currentPage = 1;
		}
		$('#currentPage').val(currentPage)
	
		$('form').attr("method", "POST").attr("action",
				"/purchase/listPurchase?menu=${param.menu}").submit()
	}


	$(function() {

		$('td.ct_btn01:contains("�˻�")').on('click', function() {

			fncGetPurchaseList(1)

		})

		$(".ct_list_pop td:nth-child(3) a").css("color", "red");

		$(".ct_list_pop:nth-child(even)").css("background-color", "whitesmoke");
		
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
		  
		  console.log(scrollPosition)
		  console.log(scrollHeight)
		  
		  
		// ���� ��ũ�� Ȱ��ȭ ���¿��� ��ũ���� ���� ��ġ�� �����ϸ� �����͸� ������
		  if (infiniteScrollEnabled && (scrollHeight - scrollPosition) / scrollHeight === 0) {
		    infiniteScrollEnabled = false; // �ߺ� ��û�� ���� ���� Ȱ��ȭ ���¸� ��Ȱ��ȭ�� ����
		    loadMoreData();
		  }
		});
	
		
		//admin�� user�� ����
		let menu = "${param.menu}";
		console.log("���� �����ڴ� "+menu)
		//console.log("ajax url�� "+ "/purchase/json/list"+(menu === 'manage' ? 'Sale' : 'Purchase'))
		
	 function loadMoreData() {
		 let searchConditionValue = $('select[name="searchCondition"]').val();
		 let searchKeywordValue = $('input[name="searchKeyword"]').val();
		 let currentPageValue = parseInt($('input[name="currentPage"]').val()); // ���� �� ��������
		 
		 //ordderDate ��¥��ȯ
		 function formatDate(date) {
			  const year = date.getFullYear();
			  const month = String(date.getMonth() + 1).padStart(2, '0');
			  const day = String(date.getDate()).padStart(2, '0');
			  return year+"-"+month+"-"+day;
			}
		 
		 
		// function formatDate(divyDate) {
			  // "00000000"�� "0000-00-00" �������� ����
			 // return divyDate.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			//}
		 
		 currentPageValue++; // 1 ����
		    
		    $('input[name="currentPage"]').val(currentPageValue); // ������Ʈ�� �� ����
		    
		    // ������ ��û�� ������ �����͸� ������.
		    $.ajax({
		      url: "/purchase/json/listPurchase",
		      data: JSON.stringify({ currentPage: currentPageValue,searchKeyword:searchKeywordValue,searchCondition:searchConditionValue }), // ���� ������ ������ ������ ����
		      method:"POST",
		      contentType: "application/json",
		      dataType: "json",
		      success: function(data,status) {
		        // ���������� �����͸� �޾ƿ��� ��, �����͸� ȭ�鿡 �߰�.
		        console.log(currentPageValue)
		        console.log(data.list)
		        let purchaseList = data.list;
		        let resultPage = data.resultPage;
				purchaseList.forEach(function(purchase) {
					  let row = "<tr class='ct_list_pop'>" +
					  "<td align='center' height='80px'><img src="+"/images/uploadFiles/"+purchase.purchaseProd.fileName.replace(',','')+" width='100px' height='100px' /></td>" +
		                "<td></td>" +
		                "<td align='center'><a href='/purchase/getPurchase?tranNo=" + purchase.tranNo + "'>" + purchase.purchaseProd.prodName + "</a></td>" +
		                "<td></td>" +
		                "<td align='left'>" + formatDate(new Date(purchase.orderDate)) + "</td>" +
		                "<td></td>" +
		                "<td align='left'>" + purchase.divyDate.substring(0,10) + "</td>" +
		                "<td></td>" +
		                "<td align='left'>" +
		                (purchase.tranCode.trim() === '1' ? '���ſϷ�' : '') +
		                (purchase.tranCode.trim() === '2' ? '�����' : '') +
		                (purchase.tranCode.trim() === '3' ? '��ۿϷ�' : '') +
		                (purchase.tranCode.trim() === '1' ? "<b data-tranNo='" + purchase.tranNo + "'>����ϱ�</b>" : '') +
		                "</td>" +
		                "<td></td>" +
		                "<td align='left'>" + purchase.prodCount + "��</td>" +
		                "</tr>";
	
					  $("table").eq(4).append(row);
					  $( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
						$("a").css("color" , "red");

						$(".ct_list_pop:nth-child(even)" ).css("background-color" , "whitesmoke");
					}); 
					
				infiniteScrollEnabled = true;
		 },//end of success
		 error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		       }
		
	 })//end of ajax
	
	}//end of loadMoreData
		
	
	//==> Autocomplete
	$('input[name="searchKeyword"]').autocomplete({
	    source: function(request, response) {
	    	let searchConditionValue = $('select[name="searchCondition"]').val();
	        $.ajax({
	            //url: "/purchase/json/list"+(menu === 'manage' ? 'Sale' : 'Purchase'),
	            url: "/purchase/json/listPurchase",
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
		
		
		$('tr.ct_list_pop td b:contains("���ǵ���")').on('click', function() {
	        // ��� ó���� tranNo ���� �����ɴϴ�.
	        let tranNo = $(this).data('tranNo');
	        console.log(tranNo)
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
		
		$('td b:contains("����ϱ�")').on('click', function() {
	        // ��� ó���� tranNo ���� �����ɴϴ�.
	        let tranNo = $(this).data('tranNo');
	        console.log(tranNo)
	        
	        // ������Ʈ�� tranCode ���� �����մϴ� (3�� ���ǵ����� ��Ÿ���ϴ�).
	        let updateTranCode = 2;
	        
	        // Ajax ��û�� �����ϴ�.
	        $.ajax({
	            url: "/purchase/json/updateTranCode/"+tranNo, // ������Ʈ�� ó���� ���� ��������Ʈ URL
	            method: "GET", // GET ��û�� ����մϴ�.
	            data: {
	                tranNo: tranNo,
	                tranCode: updateTranCode
	            },
	            success: function(data) {
	                // ���������� �����Ͱ� ������Ʈ�Ǿ��� �� ������ �ڵ带 ���⿡ �ۼ��մϴ�.
	                
	                $('td b:contains("����ϱ�")').remove();
	                 $("td:contains('����ϱ�')").text("�����");
	                
	                // ���� ���, ȭ�� ������Ʈ �Ǵ� �ٸ� �۾��� ������ �� �ֽ��ϴ�.
	            },
	            error: function(xhr, status, error) {
	                // ��û�� ������ ��� ������ �ڵ带 ���⿡ �ۼ��մϴ�.
	                console.error("��� ������Ʈ ��û ����: " + error);
	            }
	        });
	    });

	})


</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">


		<!-- <form name="detailForm" action="/purchase/listPurchase?menu=${param.menu}" method="post"> -->
		<form name="detailForm">
		<input type="hidden" name="currentPage" value="1" />
			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">${param.menu eq 'manage' ? "��۰���" : "���Ÿ�� ��ȸ"}</td>
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
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��</option>
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
				<c:forEach var="purchase" items="${list}">
					<tr class="ct_list_pop">
						<td align="center"  height="80px">
						<img src="/images/uploadFiles/${purchase.purchaseProd.fileName.replace(',','')}" width="100px" height="100px" />
						</td>
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
						<c:if test="${fn:trim(purchase.tranCode) eq '1' }">
						���ſϷ� ${param.menu eq 'manage' ? "<b 'data-tranNo='purchase.tranNo>����ϱ�</b>" : ""}
						</c:if>
						<c:if test="${fn:trim(purchase.tranCode) eq '2' }">
						����� ${param.menu eq 'search' ? "<b 'data-tranNo='purchase.tranNo>���ǵ���</b>" : ""}
						</c:if> 
						<c:if test="${fn:trim(purchase.tranCode) eq '3' }">��ۿϷ�</c:if> 
						</td>
						<td></td>
						<td align="left">
						${purchase.prodCount}��
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>

	</div>

</body>
</html>