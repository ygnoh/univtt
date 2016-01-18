$(document).on('ready page:load', function() {
	$('#school_select').change( function() {
		$.ajax({
			url: window.location.origin + '/classroom/update_building',
			dataType: 'script',
			data: $('#school_select').serialize()
		});
	})
	
	$('#now').on('click', function() {
		if ( $(this).is(':checked') ) {
			$('#day_select, #start_time, #end_time').prop('disabled', true);
		} else {
			$('#day_select, #start_time, #end_time').prop('disabled', false);
		}
	})
})

function searchClassroom() {
	if ($('#school_select').val() == 10000) {
		alert("천천히 학교부터 선택해주세요!");
		return false;
	};
	if ( ($('#start_time').val() > $('#end_time').val()) ||
		($('#start_time').val() == '' && $('#end_time').val() != '') ||
		($('#start_time').val() != '' && $('#end_time').val() == '') ){
		alert("시간이 잘 못 지정되었어요.");
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
	$('#classroom').css("display", "block");
	$.ajax({
		url: window.location.origin + '/classroom/update_classroom',
		dataType: "script",
		data: DATA
	});
	return false;
}