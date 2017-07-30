/**
 * Created by zhuk on 30.07.17.
 */
$(function () {

    $("#fill_all_days").on('click', function () {
        var val = $('#def_value').val();
        $('.resources-edit input').val(val);
    });

    $("#fill_all_weekdays").on('click', function () {
        var val = $('#def_value').val();
        $('.resources-edit input[data-weekend-data=false]').val(val);
    });

    $(".fill_one_day_of_week").on('click', function () {
        var val = $('#def_value').val();
        var dayOfWeek = $(this).attr('data-week-day-number');
        $('.resources-edit input[data-weekday='+dayOfWeek+']').val(val);
    });

});


