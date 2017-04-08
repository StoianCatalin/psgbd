<?php include_once('parts/header.php') ?>
<div class="ui sidebar inverted vertical menu">
    <?php include_once('parts/sidebar.php'); ?>
</div>
<div class="pusher">
    <?php include_once('parts/topbar.php') ?>
    <div class="content">
        <div class="card">
            <h2 class="ui center aligned icon header">
                <i class="child icon"></i>
                Welcome to Kimo!
                <div class="sub header">Kimo is one of the best platform for watching your kids in the world.</div>
            </h2>
            <h4>Please choose what are you</h4>
            <div class="ui buttons choose-type">
                <button class="ui green button">I'm child</button>
                <div class="or"></div>
                <button class="ui blue button">I'm parent</button>
            </div>
        </div>
    </div>
    <?php include_once('parts/footer.php') ?>
</div>
<?php include_once('parts/end.php') ?>