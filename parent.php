<?php include_once('parts/header.php') ?>
<?php
include_once('functions.php');
checkIfIsParent();
?>
    <div class="ui sidebar inverted vertical menu">
        <?php include_once('parts/sidebar.php'); ?>
    </div>
    <div class="pusher">
        <?php include_once('parts/topbar.php') ?>
        <div class="content">
            Parent: <?php echo $_SESSION['user']['2']; ?>
        </div>
        <?php include_once('parts/footer.php') ?>
    </div>
<?php include_once('parts/end.php') ?>