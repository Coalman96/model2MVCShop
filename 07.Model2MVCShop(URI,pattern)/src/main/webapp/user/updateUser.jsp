<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>ȸ�� ���� ����</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	$(function() {
		//=====����Code �ּ� ó�� ��  jQuery ���� ======//
		function fncUpdateUser() {

		}

			 $(document).on("click", "button.btn-outline-primary:contains('Ȯ��')", function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('����')" ).html() );
						    // �̸� ��ȿ�� ����
		    var name = $("input[name='userName']").val();
		    if (name == null || name.length < 1) {
		        alert("�̸��� �ݵ�� �Է��ϼž� �մϴ�.");
		        return;
		    }
		
		    // �̸��� ��ȿ�� ����
		    var email = $("input[name='email']").val();
		    if (email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)) {
		        alert("�̸��� ������ �ƴմϴ�.");
		        return;
		    }
		
		    // �� ������ ����
		    var formData = {
		        userName: name,
		        email: email,
		        userId: $("input[name='userId']").val(),
		        addr: $("input[name='addr']").val()
		    };
		    console.log(formData)
		    var phoneValue = $("option:selected").val() + "-" + $("input[name='phone2']").val() + "-" + $("input[name='phone3']").val();
		    formData.phone = phoneValue;
		
		    // AJAX ��û�� ���� �ٸ� JSP ������ ������ �����ɴϴ�.
		    $.ajax({
		        url: "/user/updateUser", // ���� JSP �������� ���
		        method: "POST",
		        data: formData, // ������ ������ ����
		        success: function (data) {
		            // ��� ���� ������Ʈ
		            $(".modal-content").html(data);
		        }
		    });
				//fncUpdateUser();
			 });

			});

		
		 /*============= jQuery ���� �ּ�ó�� =============
		function check_email(frm) {
				var email=document.detailForm.email.value;
			    if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
			    	alert("�̸��� ������ �ƴմϴ�.");
					return false;
			    }
			    return true;
		}========================================	*/
		//==> �߰��Ⱥκ� : "�̸���" ��ȿ��Check  Event ó�� �� ����
		 $(function() {
			 
			 $("input[name='email']").on("change" , function() {
					
				 var email=$("input[name='email']").val();
			    
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
			    	alert("�̸��� ������ �ƴմϴ�.");
			     }
			});
			 
		});	

	
	</script>		
	
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ////////////////// jQuery Event ó���� ����� ///////////////////////// 
<form name="detailForm"  method="post" >
////////////////////////////////////////////////////////////////////////////////////////////////// -->
<section style="background-color: #f4f5f7; width:800px; height:550px;">
<form name="detailForm">

<input type="hidden" name="userId" value="${user.userId }">
<input type="hidden" name="phone" class="ct_input_g"  />

  <div class="container py-3 w-800" style="height: 400px;">
    <div class="row d-flex justify-content-center align-items-center h-100 text-dark">
      <div class="col col-lg-6 mb-4 mb-lg-0 w-100 h-80">
        <div class="card mb-3 h-100" style="border-radius: .5rem; height:430px;">
          <div class="row g-0">
            <div class="col-md-4 gradient-custom text-center text-white d-flex align-items-center flex-column p-4 justify-content-center"
              style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
             <img src="https://opgg-com-image.akamaized.net/attach/images/20200513062114.1056898.jpg" alt="��" style="width:100px; height:100px; border-radius: 50%;">
              <span class="text-dark "><img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />�̸� <input class="w-50" type="text" name="userName" value="${user.userName}"></span>
              
              <p class="text-dark">���� ${user.role}</p>
            </div>
            <div class="col-md-8">
              <div class="card-body p-4">
                <h6>ȸ����������</h6>
                <hr class="mt-0 mb-4">
                <div class="row pt-1">
                  <div class="col-6 mb-3">
                    <h6><img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />�̸���</h6>
                    <input type="text" name="email" value="${user.email}">
                  </div>
                  <div class="col-6 mb-3">
                    <h6>��ȭ��ȣ</h6>
                    <div class="d-flex justify-content-between">
                    <select name="phone1" class="ct_input_g" style="width:50px; height:25px" 
							onChange="document.detailForm.phone2.focus();">
						<option value="010" ${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  } >010</option>
						<option value="011" ${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  } >011</option>
						<option value="016" ${ ! empty user.phone1 && user.phone1 == "016" ? "selected" : ""  } >016</option>
						<option value="018" ${ ! empty user.phone1 && user.phone1 == "018" ? "selected" : ""  } >018</option>
						<option value="019" ${ ! empty user.phone1 && user.phone1 == "019" ? "selected" : ""  } >019</option>
				
					</select>
						<input 	type="text" name="phone2" value="${ ! empty user.phone2 ? user.phone2 : ''}" style="width:70px;">
						<input 	type="text" name="phone3" value="${ ! empty user.phone3 ? user.phone3 : ''}" style="width:70px;">
						</div>  
                  </div>
                  <div class="col-6 mb-3">
                    <h6>�ּ�</h6>
                    <input 	type="text" name="addr" value="${user.addr}">
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
    <button type="button" class="btn btn-outline-primary px-6">Ȯ��</button>
<!-- <button type="button" class="btn btn-outline-secondary px-6">Ȯ��</button> -->
</div>

</form>
</section>
</body>

</html>