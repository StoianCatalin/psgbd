<?php

include_once('db.php');

session_start();


if (isset($_POST['email']) && isset($_POST['password'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $stid = oci_parse($conn, "SELECT * FROM utilizatori where password='".md5($password)."' and email='".$email."'");
    oci_execute($stid);

    while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
        $_SESSION['user'] = array($row['ID'], $row['TYPE'], $row['EMAIL'], $row['NAME']);
        header('Content-Type: application/json;charset=utf-8');
        echo json_encode($row);
    }

}