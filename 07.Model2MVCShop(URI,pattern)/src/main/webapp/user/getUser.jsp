<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>ȸ��������ȸ</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
	<script type="text/javascript">
		
		//==> �߰��Ⱥκ� : "����" "Ȯ��"  Event ���� �� ó��
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			// $( "button.btn-outline-secondary:contains('Ȯ��')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('Ȯ��')" ).html() );
				//history.go(-1);
			//});
			
			 $( "button.btn-outline-primary:contains('����')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('����')" ).html() );
					//self.location = "/user/updateUser?userId=${user.userId}"
				 // AJAX ��û�� ���� �ٸ� JSP ������ ������ �����ɴϴ�.
			        $.ajax({
			            url: "/user/updateUser?userId=${user.userId}", // ���� JSP �������� ���
			            success: function (data) {
			                // ��� ���� ������Ʈ
			                $(".modal-content").html(data);
			            }
			        });
				});
		});
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<section style="background-color: #f4f5f7; width:800px; height:550px;">
  <div class="container py-3 w-800" style="height: 400px;">
    <div class="row d-flex justify-content-center align-items-center h-100 text-dark">
      <div class="col col-lg-6 mb-4 mb-lg-0 w-100 h-80">
        <div class="card mb-3 h-100" style="border-radius: .5rem; height:430px;">
          <div class="row g-0">
            <div class="col-md-4 gradient-custom text-center text-white d-flex align-items-center flex-column p-4 justify-content-center"
              style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
             <img src="https://opgg-com-image.akamaized.net/attach/images/20200513062114.1056898.jpg" alt="��" style="width:100px; height:100px; border-radius: 50%;">
              <h5 class="text-dark">${user.userName}</h5>
              <p class="text-dark">���� ${user.role}</p>
            </div>
            <div class="col-md-8">
              <div class="card-body p-4">
                <h6>${user.userId}���� ����</h6>
                <hr class="mt-0 mb-4">
                <div class="row pt-1">
                  <div class="col-6 mb-3">
                    <h6>�̸���</h6>
                    <p class="text-muted">${user.email}</p>
                  </div>
                  <div class="col-6 mb-3">
                    <h6>��ȭ��ȣ</h6>
                    <p class="text-muted">${ !empty user.phone ? user.phone : ''}</p>
                  </div>
                  <div class="col-6 mb-3">
                    <h6>�ּ�</h6>
                    <p class="text-muted">${user.addr}</p>
                  </div>
                  <div class="col-6 mb-3">
                    <h6>��������</h6>
                    <p class="text-muted">${user.regDate}</p>
                </div>
              </div>

            </div>
          </div>
        </div>

      </div>
    </div>

  </div>

  </div>
  <div class="d-flex justify-content-center align-items-center gap-5">
    <button type="button" class="btn btn-outline-primary px-6">����</button>
<!-- <button type="button" class="btn btn-outline-secondary px-6">Ȯ��</button> -->
</div>
</section>
<!-- 

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">ȸ��������ȸ</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			���̵� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId}</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			�̸� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userName}</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">�ּ�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.addr}</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">�޴���ȭ��ȣ</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${ !empty user.phone ? user.phone : ''}	</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">�̸��� </td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.email}</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">��������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.regDate}</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">

						 ����
					</td>
					<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
					<td width="30"></td>					
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
					
						Ȯ��
					</td>
					<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
 -->
</body>

</html>