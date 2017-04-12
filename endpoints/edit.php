<?php

include_once('db.php');

session_start();

$id = htmlentities($_POST['id']);
$name = htmlentities($_POST['name']);

$facebook = htmlentities($_POST['facebook']);
$type = ($_POST['type']);
var_dump($id);
$stid = oci_parse($conn, "UPDATE utilizatori SET name='".$name."', facebook='".$facebook."', type='".$type."' where ID=".$id);
oci_execute($stid);

if (isset($_POST['password'])) {
    $password = $_POST['password'];
    $stid = oci_parse($conn, "UPDATE utilizatori SET password='".md5($password)."'");
    oci_execute($stid);
}
$e = oci_error();
if ($e) {
    header('Content-Type: application/json;charset=utf-8');
    echo json_encode($e);
}
else {
    header('Content-Type: application/json;charset=utf-8');
    echo json_encode("Success!");
}