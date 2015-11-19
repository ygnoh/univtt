$(document).on('ready page:load', function() {
	$('#school_select').change( function() {
		$.ajax({
			url: window.location.origin + '/classroom/update_building',
			dataType: 'script',
			data: $('#school_select').serialize()
		});
	})
})

function searchClassroom() {
	if ( ($('#start_time').val() > $('#end_time').val()) ||
		($('#start_time').val() == '' && $('#end_time').val() != '') ||
		($('#start_time').val() != '' && $('#end_time').val() == '') ){
		alert("시간이 잘못 지정되었어요.");
		return false;
	};
	var DATA = { building_id: $('#building_select').val() };
	if ($('#now').prop('checked')) {
		DATA["now"] = true;
	} else {
		if (!$('#now').prop('checked')) {
			DATA["day"] = $('#day_select').val();
			if (!($('#start_time').val() == "" || $('#end_time').val() == "")) {
				DATA["starttime"] = $('#start_time').val().replace(":","");
				DATA["endtime"] = $('#end_time').val().replace(":","");
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
