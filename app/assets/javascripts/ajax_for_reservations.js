console.log("hello!");

function unavailable(date) {
	dmy = date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear();
	console.log(dmy);
	return [$.inArray(dmy, unavailableDates) == -1];
}

$(function () {
	
	unavailableDates = [];
	$.ajax({
		url: "/preload",
		data: {"room_id": <%= @room.id %>},
		dataType: "json",
		success: function(data) {
			$.each(data, function(arrID, arrValue) {
				console.log(arrID);
				console.log(arrValue);
				for (var d = new Date(arrValue.start_date); d <= new Date(arrValue.end_date); d.setDate(d.getDate() + 1)) {
					console.log(new Date(arrValue.start_date));
					console.log(d);
					unavailableDates.push($.datepicker.formatDate("d-m-yy", d));
					console.log("unavailableDates:");
					console.log(unavailableDates);
				}
			})
			$("#reservation_start_date").datepicker({
				dateFormat: "dd-mm-yy",
				minDate: 0,
				maxDate: "3m",
				beforeShowDay: unavailable,
				onSelect: function (selected) {
					$("#reservation_end_date").datepicker("option", "minDate", selected);
					$("#reservation_end_date").attr("disabled", false);

					var start_date = $("#reservation_start_date").datepicker("getDate");
					var end_date = $("#reservation_end_date").datepicker("getDate");
					var numDays = (end_date - start_date)/1000/60/60/24 + 1;
					var total = numDays * <%= @room.price %>;

					var input = {
						"start_date": start_date,
						"end_date": end_date,
						"room_id": <%= @room.id %>
					}

					$.ajax({
						url: "/preview",
						data: input,
						success: function(data) {
							console.log("get preview called made")
							if (data.conflict) {
								$("#message").text("This date range is not available");
								$("#preview").hide();
								$("#btn-book").attr("disabled", true);
							} else {
								$("#preview").show();
								$("#btn-book").attr("disabled", false);
								$("#reservation-days").text(numDays);
								$("#reservation-sum").text(total);
								$("#reservation-total").val(total);
							}
						}
					});
				}
			});
			$("#reservation_end_date").datepicker({
				dateFormat: "dd-mm-yy",
				minDate: 0,
				maxDate: "3m",
				beforeShowDay: unavailable,
				onSelect: function (selected) {
					$("#reservation_start_date").datepicker("option", "maxDate", selected);

					var start_date = $("#reservation_start_date").datepicker("getDate");
					var end_date = $("#reservation_end_date").datepicker("getDate");
					var numDays = (end_date - start_date)/1000/60/60/24 + 1;
					var total = numDays * <%= @room.price %>;

					var input = {
						"start_date": start_date,
						"end_date": end_date,
						"room_id": <%= @room.id %>
					}

					$.ajax({
						url: "/preview",
						data: input,
						success: function(data) {
							console.log("get preview called made")
							if (data.conflict) {
								$("#message").text("This date range is not available");
								$("#preview").hide();
								$("#btn-book").attr("disabled", true);
							} else {
								$("#preview").show();
								$("#btn-book").attr("disabled", false);
								$("#reservation-days").text(numDays);
								$("#reservation-sum").text(total);
								$("#reservation-total").val(total);
							}
						}
					});
				}
			});
		}
	});

});
