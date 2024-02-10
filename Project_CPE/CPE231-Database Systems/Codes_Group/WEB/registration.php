 
<?php 
    session_start();
    include('sever.php');
    $stuid = $_GET['stuid'];
    echo("stuid = $stuid").'<br />'."\n";

    if (isset($_POST['submit'])) {
        // Counting Number of subjects
        //$count = count($_POST['subject']);
        //$subjects = $_POST['subject'];
        //$sec = $_POST['sec'];
        //$RegisID = 29;
       /* if($count>1){
             for($i=0 ;$i<$count ; $i++){
               $sql = mysqli_query($conn,"INSERT INTO registration_grade(RegisID,SubID,Sec) VALUE ('$RegisID','$subjects[$i]','$sec[$i]')");
            }
        }*/
        
        
        $year = mysqli_real_escape_string($conn,$_POST['year']);
        $semester = mysqli_real_escape_string($conn,$_POST['semester']);
        
        if(!empty($year)AND!empty($semester)){
           
            //echo("stuid = $year").'<br />'."\n";
            //echo("stuid = $semester").'<br />'."\n";

            $query = "SELECT * FROM registration WHERE Years = '$year' AND Semester ='$semester' AND StuID='$stuid' ";
            $result = mysqli_query($conn,$query);

            if(mysqli_num_rows($result) ==1){
                echo "<script type='text/javascript'>alert('year and semester have exists');</script>";
            }else{
                 $_SESSION['stuid']=$stuid;
                $_SESSION['year']=$year;
                $_SESSION['semester']=$semester;
                header("location: registrationGrade.php");
            }

            
        }
    
    }
    
    
/*
        if ($count > 1) {
            for ($i = 0; $i < $count; $i++) {
                if (trim($_POST['skill'][$i]) != '') {
                    $sql = mysqli_query($dbcon, "INSERT INTO tblskills(skill) VALUES('$skills[$i]')");
                }
            }
            echo "<script>alert('Skills inserted successfully!')</script>";
        } else {
            echo "<script>alert('Please enter your skills!')</script>";
        }
    }
*/
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamically Add / Remove with PHP & jQuery</title>

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
                    <li><a href="index.php?stuid=<?php echo $stuid; ?>">Home</a></li>
                    <li><a href="grade.php?stuid=<?php echo $stuid; ?>">grade</a></li>
                    <li><a href="registration.php?stuid=<?php echo $stuid; ?>">registration</a></li>
                    <li><a href="timetable.php?stuid=<?php echo $stuid; ?>">class</a></li>
                </ul>
            </nav>

 <script src="script.js"></script>
    <div class="header">
        <h2>Registration</h2>
    </div>
    <div class="container">
        <div class="display-2 mt-3"></div>
        <hr>
        <form action="" method="post">
            <div class="input-group">
                <label>year</label>
                <input type="varchar" name="year">
            </div>
            <div class="input-group">
                <label>semester</label>
                <input type="varchar" name="semester">
            </div><input type="submit" name="submit" id="submit" class="btn btn-info" value="get subject">
            </div>
        </form>
    </div>

</body>
</html>

