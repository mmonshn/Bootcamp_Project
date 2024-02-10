<?php
session_start();
include('sever.php');
        $countsub = 0;
        if(isset($_SESSION['stuid'])){
            $stuid = $_SESSION['stuid'];
            $getstuid = $stuid;  
        }else{
            $stuid = $getstuid;
        }
        if(isset($_SESSION['year'])){
             $year = $_SESSION['year'];
             $getyear = $year;
        }else{
            $year = $getyear;
        }
        if(isset($_SESSION['semester'])) {
            $semester = $_SESSION['semester'];
            $getsemester = $semester;
        }else{
            $semester = $getsemester;
        }
        $_SESSION['stuid']=$stuid;
    $_SESSION['year']=$year;
    $_SESSION['semester']=$semester;
        echo("stuid = $stuid").'<br />'."\n";
     echo("year = $year").'<br />'."\n";
     echo("semester = $semester").'<br />'."\n";
            if (isset($_POST['check'])) {
                            // Counting Number of skills
                            $count = count($_POST['subject']);
                            $subjects = $_POST['subject'];
                            $sec = $_POST['sec'];
                           /* $_SESSION['subject'] = $subject;
                            $_SESSION['sec'] =$sec;
                            $_SESSION['count'] = $count;*/
                            

                            if ($count > 0) {
                                for ($i = 0; $i < $count; $i++) {
                                    $find = "SELECT * FROM subclass WHERE SubID = '$subjects[$i]' AND Sec ='$sec[$i]'";
                                    $query = mysqli_query($conn,$find);
                                    $result = mysqli_fetch_assoc($query);
                                    if (mysqli_num_rows($query) <1) {//echo("result success").'<br />'."\n";
                                        //
                                        //$CREDIT = $result['Credit'];
                                        $set = 0;
                                        $_SESSION['reset']='0';
                                        echo "<script type='text/javascript'>alert('not found subject');</script>";
                                        header("location: registrationGrade.php");
                                    }
                                    $CREDIT = $result['Credit'];
                                    $countsub+= (int)$CREDIT;
                    
                                    
                                    echo("check CREDIT = $CREDIT    ");
                                    echo("check subject = $subjects[$i]   ");
                                    echo("checksec = $sec[$i]").'<br />'."\n";
                                    
                                }
                                    
                                    $insert = mysqli_query($conn,"INSERT INTO registration(StuID,Years,Semester) VALUES('$stuid','$year','$semester')");
                                    $query = "SELECT * FROM find_max_regisid" ;
                                        $queryregis = mysqli_query($conn,$query);
                                        $regisID = mysqli_fetch_assoc($queryregis);
                                        $trueregis = $regisID['MAX(RegisID)'];
                                        //echo(">>>>>>>>>>>>> RegisIDmax = $trueregis");
                                    for ($i = 0; $i < $count; $i++) {
                                        //$testsub = $subjects[$i];echo("testsubject = $testsub   ");
                                       // $testsec = $sec[$i];echo("testsec = $testsec").'<br />'."\n";
                                        $test = "INSERT INTO registration_grade(RegisID,SubID,Sec) VALUES('$trueregis','$subjects[$i]','$sec[$i]')";
                                         mysqli_query($conn,$test);
                                    
                                     }
                                    echo (" SUM CREDIT = $countsub").'<br />'."\n";
                                    echo "<script>alert('subject inserted successfully!')</script>";
                                    header("location: index.php");
                            } else {
                            //echo "<script>alert('Please enter your skills!')</script>";
                            }
                        }
                        /*if (isset($_POST['submit'])) {
                            // Counting Number of skills
                            
                           // $count = count($_SESSION['subject']);
                            $subject = $_SESSION['subject'];
                            //$count = count($subject);
                            $sec = $_SESSION['sec'] ;
                            
                            echo("count = $count").'<br />'."\n";
                            echo("stuid = $stuid").'<br />'."\n";
                            echo("year = $year").'<br />'."\n";
                            echo("semester = $semester").'<br />'."\n";
                            
                            for ($i = 0; $i < $count; $i++){
                                echo("CREDIT = $CREDIT    ");
                                    echo("subject = $subjects[$i]   ");
                                    echo("sec = $sec[$i]").'<br />'."\n";
                            }*/
                            //echo("count = $count").'<br />'."\n";
                            /*
                            if ($count > 0) {
                                $insert = mysqli_query($conn,"INSERT INTO registration(StuID,Years,Semester) VALUES('$stuid','$year','$semester')");
                                for ($i = 0; $i < $count; $i++) {
                                        $sql = mysqli_query($conn, "INSERT INTO registrationGrade(SubID,Sec) VALUES('$subject[$i]',$sec[$i])");
                                    
                                }
                                echo "<script>alert('Skills inserted successfully!')</script>";
                            } else {
                                echo "<script>alert('Please enter your skills!')</script>";
                            }}*/
                        
        ?>

        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>checkregis</title>
            <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        </head>
        <body>
        <div class="container">
        <a href="registrationGrade.php">
    <input type="button" value="back" />
        
        <?php if ($success ='true') : ?>
            <?php if ($countsub<21&&$countsub>0) : ?>
                <div class="success " style = "color : green;">
                    <h3>
                        <?php
                            echo ("STAT  :can submit");
                        ?>
                    </h3>   
                </div>
                <div class="container">
        <form action="" name="add_name" id="add_name" method="post">
        <input type="submit" name="submit" id="submit" class="btn btn-info" value="Submit">
        </form>  
        </div>
            <?php endif ?>
            <?php if ($countsub>=21||$countsub<=0) : ?>
                <div class="error" style = "color : red;">
                    <h3>
                        <?php
                        echo ("STAT  :can not submit credit >20 or credit<1");
                        ?>
                    </h3>
                </div>
            <?php endif ?>
        <?php endif ?>
        

    </div><script src="script.js"></script>
        </body>
        </html>