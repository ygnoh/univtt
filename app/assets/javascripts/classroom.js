function searchClassroom() {
	var DATA = { building_id: $('#building_select').val() };
	if ($('#now').prop('checked')) {
		DATA["now"] = true;
	} else {
		if (!$('#now').prop('checked')) {
			DATA["day"] = $('#day_select').val();
			if (!($('#start_time').val() == "" || $('#end_time').val() == "")) {
				DATA["starttime"] = parseInt($('#start_time').val().replace(":",""));
				DATA["endtime"] = parseInt($('#end_time').val().replace(":",""));
			}
		}
	}
	$.ajax({
		url: window.location.origin + '/classroom/update_classroom',
		dataType: "script",
		data: DATA
	});
	return false;
}
