function handle_no_ean(url) {
	$("#input").show().focus().attr("placeholder", "Tracking-Code");
	$("#input_form").submit(function() {
		$.post(url, {
			ean : $("#input").val()
		}).done(function(data) {
			if (data == "OK") {
				location.reload();
			} else {
				alert(data);
			}
		}).fail(function() {
			alert("error");
		});
	});
}

function upload_screen() {
	$("#upload").hide();
	$("#wait").show();
}
