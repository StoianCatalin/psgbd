<?php

include_once('db.php');

session_start();


if (isset($_POST['email']) && isset($_POST['password'])) {
    $email = htmlentities(str_replace("'", "", $_POST['email']));
    $password = $_POST['password'];

    $stid = oci_parse($conn, "SELECT userOperations.logIn('".$email."', '".md5($password)."') as status from dual");
    oci_execute($stid);

    while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
        if ($row['STATUS'] == 1) {
            $stid2 = oci_parse($conn, "SELECT * FROM utilizatori where email='".$email."' and password='".md5($password)."'");
            oci_execute($stid2);
            while ($row = oci_fetch_array($stid2, OCI_ASSOC+OCI_RETURN_NULLS)) {
                $_SESSION['user'] = array($row['ID'], $row['TYPE'], $row['EMAIL'], $row['NAME']);
                header('Content-Type: application/json;charset=utf-8');
                echo json_encode(array('status'=>'success'));
            }
        }
        else {
            $e = oci_error();
            header('Content-Type: application/json;charset=utf-8');
            var_dump($e);
        }
    }

}