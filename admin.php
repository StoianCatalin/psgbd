<?php include_once('parts/header.php') ?>
<?php
include_once('functions.php');
checkIfIsAdmin();
include_once('endpoints/db.php');
$page = isset($_GET['page']) ? $_GET['page'] : 1;
$limit = 20;
if (isset($_GET['search']))
    $stid = oci_parse($conn, "SELECT * FROM (SELECT a.*, rownum r__ FROM (SELECT * FROM UTILIZATORI where name like '%".htmlentities($_GET['search'])."%' or email like '%".htmlentities($_GET['search'])."%' or facebook like '%".htmlentities($_GET['search'])."%' ORDER BY ID ASC) a WHERE rownum < ((".$page." * ".$limit." + 1))) WHERE r__ >= ((".$page." - 1000) * ".$limit." + 1)");
else
    $stid = oci_parse($conn, "SELECT * FROM (SELECT a.*, rownum r__ FROM (SELECT * FROM UTILIZATORI ORDER BY ID ASC) a WHERE rownum < ((".$page." * ".$limit." + 1))) WHERE r__ >= ((".$page." - 1000) * ".$limit." + 1)");
oci_execute($stid);

$rows = array();

while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
   array_push($rows, $row);
}

if (!isset($_GET['search']))
    $stid = oci_parse($conn, "SELECT count(*) as nr FROM utilizatori");
else
    $stid = oci_parse($conn, "SELECT count(*) as nr FROM utilizatori where name like '%".htmlentities($_GET['search'])."%' or email like '%".htmlentities($_GET['search'])."%' or facebook like '%".htmlentities($_GET['search'])."%'");
oci_execute($stid);

$count = 0;
while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
    $count = $row['NR'];
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
               <div class="ui icon input">
                   <input type="text" placeholder="Search..." id="search">
                   <i class="search icon"></i>
               </div>
               <button class="ui button blue searchButton">Search</button>
               <br /><br />
               <a href="/add-user.php"><button class="ui button blue">Add user</button></a>
               <table class="ui striped table">
                   <thead>
                   <tr>
                       <th>ID</th>
                       <th>Name</th>
                       <th>E-mail</th>
                       <th>Birth Date</th>
                       <th>Facebook</th>
                       <th>Actions</th>
                   </tr>
                   </thead>
                   <tbody>
                   <?php
                   $pagination = array_slice($rows, ($page - 1) * $limit, $limit);
                        foreach ($pagination  as $row) {
                            echo '<tr>';
                            echo '<td>'.$row['ID'].'</td>';
                            echo '<td>'.$row['NAME'].'</td>';
                            echo '<td>'.$row['EMAIL'].'</td>';
                            echo '<td>'.$row['BIRTHDATE'].'</td>';
                            echo '<td>'.$row['FACEBOOK'].'</td>';
                            echo '<td><a href="/edit-user.php?user_id='.$row['ID'].'"><button class="ui icon button green"><i class="edit icon"></i></button></a><a href="/endpoints/delete.php?user_id='.$row['ID'].'"><button class="ui icon button red"><i class="remove icon"></i></button></a></td>';
                            echo '</tr>';
                        }
                   ?>
                   </tbody>
                   <tfoot>
                   <tr><th colspan="5">
                           <div class="ui right floated pagination menu">
                               <a href="/admin.php?page=1<?php echo isset($_GET['search']) ? '&search='.$_GET['search'] : '' ?>" class="item">First Page</a>
                               <?php
                               for ($i = $page - 5 > 0 ? $page - 5 : 1; $i < ($page + 5 > $count/$limit ? $count/$limit : $page+5) + 1; $i++ ) {
                                   echo '<a href="/admin.php?page='.$i.(isset($_GET['search']) ? '&search='.$_GET['search'] : '').'" class="item">'.$i.'</a>';
                               }
                               ?>
                               <a href="/admin.php?page=<?php echo ($page + 5 > $count/$limit ? $count/$limit : $page+5) + 1 ?><?php isset($_GET['search']) ? '&search='.$_GET['search'] : '' ?>" class="item">Last Page</a>
                           </div>
                       </th>
                   </tr></tfoot>
               </table>
           </div>
        </div>
        <?php include_once('parts/footer.php') ?>
    </div>
<?php include_once('parts/end.php') ?>