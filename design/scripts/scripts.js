/**
 * Created by Andreea on 3/11/2017.
 */
//Login page
$('.open-menu').click(function() {
    $('.ui.sidebar').sidebar('setting', 'transition', 'scale down').sidebar('toggle');
});
$('.logout').dropdown();


$(document).on('click', '.loginButton', function() {
    var email = $('#email').value();
    var password = $('#password').value();
    console.log(email);
    $.post('/endpoints/login.php', {email: email, password: password}, function(response) {
        console.log(response);
    })
});