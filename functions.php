<?php

function checkIfIsLogged() {
    if (isset($_SESSION['user']) && $_SESSION['user'][1] == 0 ) {
        header('Location: /admin.php');
        die();
    }
    else  if (isset($_SESSION['user']) && $_SESSION['user'][1] == 1 ) {
        header('Location: /parent.php');
        die();
    }
    else  if (isset($_SESSION['user']) && $_SESSION['user'][1] == 2 ) {
        header('Location: /child.php');
        die();
    }
}

function checkIfIsAdmin() {
    echo $_SESSION['user'][1];
    if (!isset($_SESSION['user']) || $_SESSION['user'][1] != 0) {
        header('Location: /index.php');
        die();
    }
}

function checkIfIsChild() {
    if (!isset($_SESSION['user']) || $_SESSION['user'][1] != 2) {
        header('Location: /index.php');
        die();
    }
}
function checkIfIsParent() {
    if (!isset($_SESSION['user']) || $_SESSION['user'][1] != 1) {
        header('Location: /index.php');
        die();
    }
}
