var wishbox = [];

$(document).on('ready page:load', function() {
	// Make wishbox contents
	$(".recommend #lecture-container-body").on('click', '.lecture_select', function() {
		if ($(this).data('checked') == '0') {
			if (wishbox.length >= 15) {
				alert("강의는 최대 15개까지만 담을 수 있어요.");
			} else {
				$.ajax({
					url: window.location.origin + '/recommend/update_wishbox',
					dataType: "script",
					data: {
						lecture_id: $(this).prop('id')
					}
				});
			}
		} else {
			wishbox.splice(jQuery.inArray(parseInt($(this).prop('id')),wishbox),1);
			$('#wishbox-hidden').val(wishbox);

			$(this).data('checked','0');
			$(this).css('background-color','');
			$('.'+$(this).prop('id')).remove();
		}
	});

	$('#wishlist').on('click', '.xbtn', function() {
		var lecture_id = parseInt($(this).parent().prop('class').split(' ')[0]);

		wishbox.splice(jQuery.inArray(lecture_id,wishbox), 1);
		$('#wishbox-hidden').val(wishbox);
		
		$('#' + lecture_id).data('checked','0');
		$('.' + lecture_id).remove();
		$('#' + lecture_id).css('background-color','');
	});

	$('#btn-recommend').on('click', function(e) {
		if (wishbox.length == 0) {
			alert("강의를 먼저 선택해주세요.");
			e.preventDefault();
		} else {
			if (confirm("해당 강의들로 추천해드릴까요?")) {
				if ($('#grade_restrict_over').val() > $('#grade_restrict_less').val()) {
					alert("학점 범위를 확인해주세요.");
					e.preventDefault();
				}
			} else {
				e.preventDefault();
			}
		}
	});

	$("#btn-save-recommend").on('click', function(e) {
		if (confirm("저장할까요?")) {
		} else {
			e.preventDefault();
		}
	});

	$('#recommend-option').on('click', function() {
		if ($(this).is(':checked')) {
			$('#option-container-body').css("display", "block");
		} else {
			$('#option-container-body').css("display", "none");
		}
	});
});
