$(document).on('ready page:load', function() {
	$("#school_select").change( function() {
		$.ajax({
			url: window.location.origin + '/timetable/update_departments',
			dataType: "script",
			data: $("#school_select").serialize()
		});
		$('#lecture-container-body').empty();
	});
	$("#department_select").change( function() {
		$.ajax({
			url: window.location.origin + '/timetable/update_lectures',
			dataType: "json",
			data: $("#department_select").serialize(),
			success: function(data){
				console.log(data[1]);
				var str = '';
				for(var i = 0; i < data.length; i++) {
					str += '<li>'  
						+ '<span>'+data[i].lecture_name+'<span>' 
						+ '</li>';
				}
				$('#lecture-container-body').html(str);
			}
		});
	});
});
