<?php include_once('parts/header.php') ?>
<?php
include_once('functions.php');
checkIfIsAdmin();
include_once('endpoints/db.php');

$rows = array();


?>
    <div class="ui sidebar inverted vertical menu">
        <?php include_once('parts/sidebar.php'); ?>
    </div>
    <div class="pusher">
        <?php include_once('parts/topbar.php') ?>
        <div class="content">
           <div class="card">
               <h2 class="ui center aligned icon header">
                   <i class="child icon"></i>
                   Kimo users
                   <div class="sub header">Kimo is one of the best platform for watching your kids in the world.</div>
               </h2>
               <a href="/admin.php"><button class="ui button blue">User Table</button></a><br /><br />
               <?php
               if (isset($_GET['id1']) && isset($_GET['id2'])) {
                   $stid = oci_parse($conn, "SELECT points.returnDistanceBetweenTwoPoints(".$_GET['id1'].", ".$_GET['id2'].") as distance from dual");
                   try {
                       oci_execute($stid);
                       while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
                           echo $row['DISTANCE'] . " KM";
                       }
                   }catch (Exception $e) {
                       echo '<div class="ui negative message"><i class="close icon"></i><div class="header">We\'re sorry we can\'t apply that discount</div><p>That offer has expired</p></div>';
                   }
               }
               ?>
           </div>
        </div>
        <?php include_once('parts/footer.php') ?>
    </div>
<?php include_once('parts/end.php') ?>