function handle_qr_scan(url) {
	$("#input").show().attr("placeholder","QR-Code");
	$("#input_form").submit(function() {
		$.post(url, {
			qr : $("#input").val()
		}).done(function(data) {
			if (data == "OK"){
				location.reload();
			}else{
				alert(data);
			}
		});
	});
}

function handle_no_qr (){
	$("#input").focus();
}
