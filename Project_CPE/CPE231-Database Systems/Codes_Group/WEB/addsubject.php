<?php
    session_start();
    include('sever.php');
    $proid = $_GET['proid'];
    echo("proid = $proid");

?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>addsubject</title>
    
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">

</head>
<body>

            <nav>
                <span class="nav-toggle" id="js-nav-toggle">
                    <i class="fas fa-bars"></i>
                </span>
                <div class="logo">
                    <h1>Registration</h1>
                </div>
                <ul id="js-menu">
                    
                    <li><a href="index2.php?proid=<?php echo $proid; ?>">Home</a></li>
                    <li><a href="countstudent.php?proid=<?php echo $proid; ?>">countstudent</a></li>
                    <li><a href="addsubject.php?proid=<?php echo $proid; ?>">addsubject</a></li>
                    <li><a href="checkstudent.php?proid=<?php echo $proid; ?>">checkstudent</a></li>
                </ul>
            </nav>
            <script src="script.js"></script>
    <div class="header">
        <h2> AddSubject </h2>
    </div>
    <form action="" method="post">
        <div class="input-group">
            <label for="subid">SubID</label>
            <input type="varchar" name="subid">
        </div>
        <div class="input-group">
            <label for="subname">SubName</label>
            <input type="varchar" name="subname">
        </div>
        <div class="input-group">
            <label for="sec">Sec</label>
            <input type="varchar" name="sec">
        </div>
        <div class="input-group">
            <label for="credit">Credit</label>
            <input type="int" name="credit">
        </div>
        <div class="input-group">
            <label for="roomname">RoomName</label>
            <input type="int" name="roomname">
        </div>
        <div class="input-group">
            <button type="submit" name="submit" class ="btn">Submit</button>
        </div>
    </form>
</body>
</html>

<?php
    if (isset($_POST['submit'])){
        $subid = mysqli_real_escape_string($conn,$_POST['subid']);
        $subname = mysqli_real_escape_string($conn,$_POST['subname']);
        $sec = mysqli_real_escape_string($conn,$_POST['sec']);
        $credit = mysqli_real_escape_string($conn,$_POST['credit']);
        $roomname = mysqli_real_escape_string($conn,$_POST['roomname']);
        echo("SubID = $subid ,");
        echo("\n SubName = $subname ,");
        echo("\n Sec = $sec ,");
        echo("\n Credit = $credit ,");
        echo("\n RoomName = $roomname");

        $find = mysqli_query($conn,"SELECT * FROM sub WHERE SubID ='$subid'");
        $findsub = mysqli_fetch_assoc($find);
        if(mysqli_num_rows($find)==0){
            mysqli_query($conn, "INSERT INTO sub (SubID,SubName,Credit) VALUES ('$subid','$subname','$credit')");
        }
        mysqli_query($conn, "INSERT INTO sub_sec_pro (SubID,Sec,ProID) VALUES ('$subid','$sec','$proid')");
        mysqli_query($conn, "INSERT INTO class (SubID,Sec,RoomName) VALUES ('$subid','$sec','$roomname')");
    }
?>
