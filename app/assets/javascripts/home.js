// Variables for checking overlap
var lectureSaver = [];
var daySaver = [];
var timeSaver = [];

$(document).on('ready page:load', function() {
	// Clear all global variables for avoiding unexpected errors
	lectureSaver = [];
	daySaver = [];
	timeSaver = [];
	wishbox = [];

	$("#school_select").change( function() {
		// Update department by school
		$.ajax({
			url: window.location.origin + '/timetable/update_departments',
			dataType: "script",
			data: $("#school_select").serialize()
		});
		$('#lecture-container-body').empty();
	
		// Update classification by school
		$.ajax({
			url: window.location.origin + '/timetable/update_classifications',
			dataType: "json",
			data: $("#school_select").serialize(),
			success: function(data){
				var str = '';
				for(var i = 0; i< data.length; i++ ){
					//////////// below input codes must be changed to Ruby
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

	// Update lectures by department
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

	// Update lectures by classification
	$("#classification-container-body").on('change', '.classification_select', function() {
		var URL;
		var DATA = $("#department_select").serialize();

		// When unclick for the last classification
		if ($(".classification_select").serialize() == "") {
			URL = '/timetable/update_lectures_by_department';

			// When click or unclick for classifications
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

	// Make timetable contents
	$(".timetable #lecture-container-body").on('click', '.lecture_select', function() {
		// Check if lectures has been clicked
		if ($(this).data('checked') == '0') {
			$.ajax({
				url: window.location.origin + '/timetable/update_timetable',
				dataType: "script",
				data: {
					lecture_id: $(this).prop('id')
				}
			});
		} else {
			var lecture_id = parseInt($(this).prop('id'));
			var lectureIndex = jQuery.inArray(lecture_id,lectureSaver);
			lectureSaver.splice(lectureIndex,1); // remove lectureSaver[lectureIndex]
			daySaver.splice(lectureIndex,1);
			timeSaver.splice(lectureIndex,1);
			$('#timetable-hidden').val(lectureSaver);

			$(this).data('checked','0');
			$(this).css('background-color','');
			$('.'+$(this).prop('id')).remove();
		}
	});
	
	$('#btn-save').on('click', function(e) {
		if (lectureSaver.length == 0) {
			alert("강의를 먼저 선택해주세요.");
			e.preventDefault();
		} else {
			if (confirm("저장할까요?")) {
			} else {
				e.preventDefault();
			}
		}
	});
});

// When click for removing lectures on the timetable sheet
function removeOnTimetable() {
	//////////////////////////// is this the best way?
	var lecture_id = parseInt($(event.currentTarget).prop('class'));
	var lectureIndex = jQuery.inArray(lecture_id,lectureSaver);

	lectureSaver.splice(lectureIndex,1); // remove lectureSaver[lectureIndex]
	daySaver.splice(lectureIndex,1);
	timeSaver.splice(lectureIndex,1);
	$('#timetable-hidden').val(lectureSaver);

	$('#' + lecture_id).data('checked','0');
	$('.' + lecture_id).remove();
	$('#' + lecture_id).css('background-color','');
}

// For checking overlap
function checkOverlap(dayValue,timeValue) {
	var aim = findArrayIndex(dayValue,daySaver); // For check only about same days
	for ( x in aim ) {
		var from = timeSaver[ aim[x][0] ][ aim[x][1] ][ 0 ];
		var to = timeSaver[ aim[x][0] ][ aim[x][1] ][ 1 ];
		var timeValueFrom = timeValue[ aim[x][2] ][ 0 ];
		var timeValueTo = timeValue[ aim[x][2] ][ 1 ];

		if ( ( from < timeValueFrom && timeValueFrom < to ) // crossing
			|| ( from < timeValueTo && timeValueTo < to ) // crossing
			|| ( timeValueFrom <= from && to <= timeValueTo ) ) { // including
			alert("'" + $('#'+lectureSaver[ aim[x][0] ]).children().html() + "' 강의랑 시간이 겹쳐요.");
			return false; 
		}
	}
	return true;
}

// Only be applicable for 2 dimension array 'saver'
function findArrayIndex(target, saver) {
	var result = [];
	for ( x in target ) {
		for (var i = 0; i < saver.length; i++) {
			for (var j = 0; j < saver[i].length; j++) {
				if (saver[i][j] == target[x]) {
					result.push([i,j,x]);
				}
			}
		}
	} 
	// return target's position formed like [[saverPosition,targetDay],...]
	return result;
}

function getRandColor(){
	var colors = ['DeepSkyBlue','DodgerBlue','HotPink','LightPink','MistyRose','NavajoWhite','PaleVioletRed','Plum','SlateBlue'];
	var rand = Math.floor(Math.random()*(colors.length));
	return colors[rand]
}
