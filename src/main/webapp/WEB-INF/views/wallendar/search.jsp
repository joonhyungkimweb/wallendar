<%@include file="../includes/header.jsp"%>
<h2>SEARCH....</h2>

<div class="pl-5">
	<h5>User</h5>
	<div class="ml-2" id="usertag">No Result</div>
</div>
<hr>
<div class="pl-5">
	<h5>Tags</h5>
	<div class="ml-2" id="tagpost">No Result</div>
	<div class="container-fluid">
		<div class="row row-cols-4 p-3" id="tagrow"></div>
	</div>
</div>


<script charset="utf-8">
	$(document).ready(function() {

		if (!sessionStorage.getItem("loginuser")) {
			window.location.href = "/";
		}

		var url = location.pathname.replace("search", "post");
		var usertag;
		var tagpost;

		$.ajax({
			url : url,
			contentType : "JSON",
			type : "GET",
			async : false,
			success : function(response) {
				usertag = response["usertag"];
				tagpost = response["tagpost"];
			}
		});

		if (usertag.length > 0) {
			$('#usertag').text('').append('<a href="/calendar/'+usertag+'">@' + usertag + '</a>');
		}

		if (tagpost.length > 0) {
			$('#tagpost').text("#" + url.replace("/post/", ""));
		}

		for (var i = 0; i < tagpost.length; i++) {
			$('#tagrow').append('<img class="mb-3 col rounded" id = "thumbnail' + i + '" style="width:100%; background:url(../' + tagpost[i]["pic"] + ') no-repeat center center; background-size:cover; " src = /image/thumbnail.png>');
			$('#thumbnail' + i).attr("data-post", JSON.stringify(tagpost[i]));
		}

		$('.rounded').on('click', function(event) {

			var post = JSON.parse($(event.target).attr("data-post"))

			setReadModal(post);
			$('#readModal').modal("show");
		});

	});
</script>
<%@include file="../includes/footer.jsp"%>