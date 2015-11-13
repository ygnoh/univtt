var lectureSaver = [];
var daySaver = [];
var timeSaver = [];

$(document).on('ready page:load', function() {
	$("#school_select").change( function() {
		$.ajax({
			url: window.location.origin + '/timetable/update_departments',
			dataType: "script",
			data: $("#school_select").serialize()
		});
		$('#lecture-container-body').empty();
	
		$.ajax({
			url: window.location.origin + '/timetable/update_classifications',
			dataType: "json",
			data: $("#school_select").serialize(),
			success: function(data){
				var str = '';
				for(var i = 0; i< data.length; i++ ){
					// below input codes must be changed to Ruby
					str += '<li>'
						+ '<input type="checkbox" value=' + data[i].id 
						+ ' name="classification[' + data[i].id + ']"'
						+ ' id="classification_' + data[i].id 
						+ '" class="classification_select"/>'
						+ '<label for="classification_'+ data[i].id + '">' + data[i].classification_name
						+ '</label>'
						+ '</li>';
					}
				$('#classification-container-body').html(str);
			}
		});
	});

	$("#department_select").change( function() {
		$('#lecture-container-body').empty();
		$.ajax({
			url: window.location.origin + '/timetable/update_lectures_by_department',
			dataType: "json",
			data: $("#department_select").serialize(),
			success: function(data){
				var str = '';
				for(var i = 0; i < data.length; i++) {
					str += '<li class="lecture_select" id="' + data[i].id + '"' 
						+ 'data-checked="0">'
						+ '<span>' + data[i].lecture_name+'</span>' 
						+ '</li>';
				}
				$('#lecture-container-body').html(str);
			}
		});
	});

	$("#classification-container-body").on('change', '.classification_select', function() {
		var URL;
		var DATA = $("#department_select").serialize();

		if ($(".classification_select").serialize() == "") {
			URL = '/timetable/update_lectures_by_department';
		} else {
			URL = '/timetable/update_lectures_by_classification';
			DATA += "&" + $(".classification_select").serialize();
		}

		$.ajax({
			url: window.location.origin + URL,
			dataType: "json",
			data: DATA,
			success: function(data){
				var str = '';
				for(var i = 0; i < data.length; i++) {
					str += '<li class="lecture_select" id="' + data[i].id + '"'
						+ 'data-checked="0">'
						+ '<span>' + data[i].lecture_name+'</span>'
						+ '</li>';
				}
				$('#lecture-container-body').html(str);
			}
		});
	});

	$("#lecture-container-body").on('click', '.lecture_select', function() {
		if ($(this).data('checked') == '0') {
			$(this).data('checked','1');
			$.ajax({
				url: window.location.origin + '/timetable/update_timetable',
				dataType: "script",
				data: {
					lecture_id: $(this).prop('id')
				}
			});
		} else {
			//console.log(jQuery.inArray(parseInt($(this).prop('id')),lectureSaver));
			$(this).data('checked','0');
			$(this).css('background-color','');
			$('.'+$(this).prop('id')).remove();
		}
	});
});

function removeOnTimetable() {
	// is this the best way?
	var lecture_id = parseInt($(event.currentTarget).prop('class'));
	//console.log(jQuery.inArray(lecture_id,lectureSaver));
	$('#' + lecture_id).data('checked','0');
	$('.' + lecture_id).remove();
	$('#' + lecture_id).css('background-color','');
}
