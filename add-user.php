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
               <a href="/admin.php"><button class="ui button blue">User Table</button></a>
               <form class="ui form">
                   <div class="field">
                       <label>Name</label>
                       <input type="text" name="name" id="name">
                   </div>
                   <div class="field">
                       <label>Email</label>
                       <input type="email" name="email" id="email">
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
                       <input type="text" name="facebook" id="facebook">
                   </div>
                   <div class="field">
                       <label>Data nastere</label>
                       <input type="date" name="data_nastere" id="data_nastere">
                   </div>
                   <div class="field">
                       <label>Type</label>
                       <select class="ui fluid dropdown" name="type" id="type">
                           <option value="0">Admin</option>
                           <option value="1">Parent</option>
                           <option value="2">Child</option>
                       </select>
                   </div>
                   <div class="field">
                       <div class="ui button blue addUser">Save</div>
                   </div>
               </form>
           </div>
        </div>
        <?php include_once('parts/footer.php') ?>
    </div>
<?php include_once('parts/end.php') ?>