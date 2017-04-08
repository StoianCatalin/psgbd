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
                    Ok, here you go...
                    <div class="sub header">Kimo is one of the best platform for watching your kids in the world.</div>
                </h2>
                <form class="ui form">
                    <div class="field">
                        <label>Email</label>
                        <input type="email" name="email">
                    </div>
                    <div class="field">
                        <label>Password</label>
                        <input type="password" name="password">
                    </div>
                    <div class="buttons">
                        <button class="ui button blue" type="submit">Login</button>
                    </div>
                </form>
            </div>
        </div>
        <?php include_once('parts/footer.php') ?>
    </div>
<?php include_once('parts/end.php') ?>