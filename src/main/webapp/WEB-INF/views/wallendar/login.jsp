<%@include file="../includes/header.jsp"%>

<div class="container">
	<!-- Outer Row -->
	<div class="row justify-content-center">

		<div class="col-xl-8 col-lg-8 col-md-8">

			<div class="card o-hidden border-0 shadow-lg my-5">
				<div class="card-body p-0">
					<!-- Nested Row within Card Body -->
					<div class="col-xl-8 col-lg-8 m-auto">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">
									Welcome TO
									<br>
									WALLENDAR!
								</h1>
							</div>
							<div class="form-group">
								<input type="email" class="form-control form-control-user" id="inputEmail" aria-describedby="emailHelp" placeholder="Enter Email Address...">
							</div>
							<div class="form-group">
								<input type="password" class="form-control form-control-user" id="inputPassword" placeholder="Password">
							</div>
							<div class="form-group">
								<div id="failed"></div>
							</div>
							<button class="btn btn-secondary btn-user btn-block" id="loginbtn">Login</button>
							<hr>
							<div class="text-center">
								<a class="small" href="/register">Create an Account!</a>
							</div>
							<div class="text-center">
								<a class="small" href="/verify">Forgot Password?</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		if (sessionStorage.getItem("loginuser")) {
			window.location.href = "/calendar/" + sessionStorage.getItem("loginuser");
		}
	});

	$('#loginbtn').on('click', function() {
		var data = new Object();
		data.email = $('#inputEmail').val();
		data.password = $('#inputPassword').val();

		$.ajax({
			url : "/user/login",
			contentType : "application/json",
			data : JSON.stringify(data),
			type : "POST",
			async : false,
			success : function(result) {
				if (result) {
					sessionStorage.setItem("loginuser", result.usertag);
					if (result.profileimg) {
						sessionStorage.setItem("userimg", result.profileimg);
					}
					window.location.href = "/calendar/" + result.usertag;
				} else {
					alert("Invalid Email or Password");
				}
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	});

	$('#inputEmail, #inputPassword').keypress(function(event) {
		if (event.which == 13) {
			$('#loginbtn').click();
			return false;
		}
	});
</script>

<%@include file="../includes/footer.jsp"%>