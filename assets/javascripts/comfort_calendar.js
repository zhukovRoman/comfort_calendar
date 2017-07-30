/**
 * Created by zhuk on 30.07.17.
 */
$(function () {
    console.log('lol');

    $("#fill_all_days").on('click', function () {
        var val = $('#def_value').val();
        $('.resources-edit input').val(val);
    });

    $("#fill_all_weekdays").on('click', function () {
        var val = $('#def_value').val();
        $('.resources-edit input[data-weekend-data=false]').val(val);
    });

});


