<?php

include_once('db.php');

session_start();


if (isset($_POST['email']) && isset($_POST['password'])) {
    $name = htmlentities($_POST['name']);
    $email = htmlentities($_POST['email']);
    $password = $_POST['password'];
    $facebook = htmlentities($_POST['facebook']);
    $data_nastere = ($_POST['data_nastere']);
    $type = ($_POST['type']);
    $stid = oci_parse($conn, "INSERT INTO UTILIZATORI (NAME, EMAIL, PASSWORD, FACEBOOK, TYPE, BIRTHDATE) VALUES('".$name."', '".$email."', '".md5($password)."', '".$facebook."', '".$type."', to_date('".$data_nastere."', 'yyyy-mm-dd'))");
    oci_execute($stid);

    $e = oci_error();
    if ($e) {
        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($e);
    }
    else {
        header('Content-Type: application/json;charset=utf-8');
        echo json_encode("Success!");
    }

}