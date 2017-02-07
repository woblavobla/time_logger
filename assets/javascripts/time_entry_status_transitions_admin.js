/**
 * Created by Andrey Lobanov on 07.02.2017.
 */
$(document).ready(function () {
    $("#project_select").on('change', function (eval) {
        console.log(this.value);
        $.ajax({
            url: 'update_activities',
            method: 'GET',
            dataType: 'script',
            data: {project_id: this.value}
        });
    });
});