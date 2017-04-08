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
        if (response)
            window.location.reload();
        else {
            $('#email').val('');
            $('#password').val('');
            $('.ui.negative.message').show();
            setTimeout(function() {
                $('.ui.negative.message').hide();
            }, 2000);
        }
    })
});