<?php include_once('parts/header.php') ?>
<?php
include_once('functions.php');
checkIfIsAdmin();
include_once('endpoints/db.php');

if (!isset($_GET['user_id'])) {
    header('Location: /admin.php');
    die();
}
$user_id = $_GET['user_id'];

$stid = oci_parse($conn, "SELECT * FROM utilizatori where ID='".$user_id."'");
oci_execute($stid);

$user = [];

while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
    $user = $row;
}

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
               <a href="/admin.php"><button class="ui button blue">User Table</button></a>
               <form class="ui form">
                   <input type="hidden" name="id" id="id" value="<?php echo $user['ID']; ?>" />
                   <div class="field">
                       <label>Name</label>
                       <input type="text" name="name" id="name" value="<?php echo $user['NAME']; ?>">
                   </div>
                   <div class="field">
                       <label>Email</label>
                       <input disabled type="email" name="email" id="email" value="<?php echo $user['EMAIL']; ?>">
                   </div>
                   <div class="field">
                       <label>Password</label>
                       <input type="password" name="email" id="password">
                   </div>
                   <div class="field">
                       <label>Confirm Password</label>
                       <input type="password" name="password" id="confirm_password">
                   </div>
                   <div class="field">
                       <label>Facebook</label>
                       <input type="text" name="facebook" id="facebook" value="<?php echo $user['FACEBOOK']; ?>">
                   </div>
                   <div class="field">
                       <label>Type</label>
                       <select class="ui fluid dropdown" name="type" id="type">
                           <option value="0" <?php if ($user['TYPE'] == 0) echo 'selected';?>>Admin</option>
                           <option value="1" <?php if ($user['TYPE'] == 1) echo 'selected';?>>Parent</option>
                           <option value="2" <?php if ($user['TYPE'] == 2) echo 'selected';?>>Child</option>
                       </select>
                   </div>
                   <div class="field">
                       <div class="ui button blue saveUser">Save</div>
                   </div>
               </form>
           </div>
        </div>
        <?php include_once('parts/footer.php') ?>
    </div>
<?php include_once('parts/end.php') ?>