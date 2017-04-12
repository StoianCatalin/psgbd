<?php

include_once('db.php');

session_start();

if (isset($_GET['user_id'])) {
    $id = $_GET['user_id'];
    $stid = oci_parse($conn, "DELETE FROM UTILIZATORI where ID=".$id);
    oci_execute($stid);
    $e = oci_error();
    header('Location: /admin.php');
    die();
}