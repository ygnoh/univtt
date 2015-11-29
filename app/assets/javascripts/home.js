// Variables for checking overlap
var lectureSaver = [];
var daySaver = [];
var timeSaver = [];

// Variables for lecture's information
var gradeSaver = [];
var gradeOfLectures = 0;
var numberOfLectures = 0;

$(document).on('ready page:load', function() {
	// Clear all global variables for avoiding unexpected errors
	lectureSaver = [];
	daySaver = [];
	timeSaver = [];
	wishbox = [];
	gradeSaver = [];
	gradeOfLectures = 0;
	numberOfLectures = 0;

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

			gradeOfLectures -= gradeSaver[lectureIndex];
			numberOfLectures--;
			gradeSaver.splice(lectureIndex,1);

			$(this).data('checked','0');
			$(this).css('background-color','');
			$('.'+$(this).prop('id')).remove();

			$('#grade-number-default').html("<span style='color: red;'>"
				+ gradeOfLectures + "</span>학점 / <span style='color: red;'>"
				+ numberOfLectures + "</span>강의");
		}
	});
	
	$("#btn-save").on('click', function(e) {
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

	$('#btn-delete').on('click', function(e) {
		if (confirm("해당 시간표를 삭제합니다.")) {
		} else {
			e.preventDefault();
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

	gradeOfLectures -= gradeSaver[lectureIndex];
	numberOfLectures--;
	gradeSaver.splice(lectureIndex,1);

	$('#' + lecture_id).data('checked','0');
	$('.' + lecture_id).remove();
	$('#' + lecture_id).css('background-color','');

	$('#grade-number-default').html("<span style='color: red;'>"
		+ gradeOfLectures + "</span>학점 / <span style='color: red;'>"
		+ numberOfLectures + "</span>강의");
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

// need to be a different way
function resetAll(){
	lectureSaver = [];
	daySaver = [];
	timeSaver = [];
	wishbox = [];
	gradeSaver = [];
	gradeOfLectures = 0;
	numberOfLectures = 0;
	$('.lecture_select').data('checked','0')
		.css('background-color', '');
	$('#table-grid').empty();
	$('#grade-number-default').html('<span style="color: red;">0</span>학점 / <span style="color: red;">0</span>강의</p>');
	$('#wishlist').empty();
	$('#wishbox-hidden').val(wishbox);
}
