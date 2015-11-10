$(document).on('ready page:load', function() {
	$("#school_select").change( function() {
		$.ajax({
			url: window.location.origin + '/timetable/update_departments',
			dataType: "script",
			data: {
				school: $("#school_select").val()
			}
		});
	});
});
