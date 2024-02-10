<?php
    session_start();
    include('sever.php');
    $proid = $_GET['proid'];
    echo("proid = $proid").'<br />'."\n";

    if(isset($_POST['check'])){
        $stuid = mysqli_real_escape_string($conn,$_POST['stuid']);
        $stuidget = $stuid;
        echo ("stuid = $stuid");

        $find = mysqli_query($conn,"SELECT * FROM student WHERE StuID ='$stuid'");
        if(mysqli_num_rows($find)==1){
            $_SESSION['success'] = "student have exists";
        }
        else{
            $_SESSION['nosuccess'] = "student have not exists";
        }
    }
    else{
        $stuidget = "";
        $stuid = $stuidget;
    }

    if(isset($_POST['done'])){
        $delete = mysqli_query($conn,"SELECT * FROM checkstudent WHERE StuID = '$stuid' AND ProID='$proid'");
        $deletefind = mysqli_fetch_assoc($delete);
        $mustdelete = $deletefind['RegisID'];

        $del = mysqli_query($conn,"DELETE FROM registration WHERE RegisID = '$mustdelete'");
        $del2 = mysqli_query($conn,"DELETE FROM registration_grade WHERE RegisID = '$mustdelete'");
    }



?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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
            <div class="header">
        <h2>check student</h2>
    </div>
    <form action="" method="post">
        <div class="input-group">
            <label for="stuid">STUDENT ID</label>
            <input type="varchar" name="stuid">
        </div>
        <div class="input-group">
            <button type="submit" name="check" class ="btn">check</button>
        </div>
        
    </form>
    <form action="" method="post">
       <div class="input-group">
            <button type="submit" name="done" class ="btn">done</button>
        </div>
    </form>

            <script src="script.js"></script> 
</body>
</html>


