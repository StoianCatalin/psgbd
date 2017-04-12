/**
 * Created by Andreea on 3/11/2017.
 */
//Login page
$('.open-menu').click(function() {
    $('.ui.sidebar').sidebar('setting', 'transition', 'scale down').sidebar('toggle');
});
$('.logout').dropdown();
$('.ui.negative.message').hide();

$(document).on('click', '.loginButton', function() {
    var email = $('#email').val();
    var password = $('#password').val();
    $.post('/endpoints/login.php', {email: email, password: password}, function(response) {
        if (response.status == 'success')
            window.location.reload();
        else {
            $('#email').val('');
            $('#password').val('');
            //$('.ui.negative.message .header').html(response);
            $('.ui.negative.message').show();
            setTimeout(function() {
                $('.ui.negative.message').hide();
            }, 4000);
        }
    })
});

$(document).on('click', '.addUser', function() {
    var mydate = new Date($('#data_nastere').val());
    var str = mydate.getFullYear() + "-" + mydate.getMonth() + "-" + ("0" + mydate.getDay()).slice(-2);
    var body = {
        name: $('#name').val(),
        email: $('#email').val(),
        password: $('#password').val(),
        facebook: $('#facebook').val(),
        data_nastere: $('#data_nastere').val(),
        type: $('#type').val()
    }
    if ($('#password').val() == $('#confirm_password').val())
        $.post('/endpoints/add.php', body, function(response) {
            window.location.reload();
        });
});

$(document).on('click', '.saveUser', function() {
    var mydate = new Date($('#data_nastere').val());
    var str = mydate.getFullYear() + "-" + mydate.getMonth() + "-" + ("0" + mydate.getDay()).slice(-2);
    var body = {
        id: $('#id').val(),
        name: $('#name').val(),
        facebook: $('#facebook').val(),
        type: $('#type').val()
    };
    if ($('#password').val() == $('#confirm_password').val() && $('#password').val() != "")
        body.password = $('#password').val();

        $.post('/endpoints/edit.php', body, function(response) {
            window.location.reload();
        });
});

$(document).on('click', '.searchButton', function() {
    var query = $('#search').val();
    window.location.href='/admin.php?search=' + query;
});