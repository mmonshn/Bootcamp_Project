<?php 
     session_start();
     include('sever.php');
      function insertRegister(){
         echo(">>>>>>>>>>>>countas dd
         as dasd
         sad sa d == $count");
     }
     
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
     if(isset($_SESSION['reset'])){
         echo ("tesst");
         //echo "<script type='text/javascript'>alert('not found subject');</script>";
     }
     
     if($set = 0){
         $set = 1;
         echo "<script type='text/javascript'>alert('not found subject');</script>";
     }
     
     //header("location: registrationGrade.php");

     echo("stuid = $stuid").'<br />'."\n";
     echo("year = $year").'<br />'."\n";
     echo("semester = $semester").'<br />'."\n";
    $countsub = 0;
    $_SESSION['stuid']=$stuid;
    $_SESSION['year']=$year;
    $_SESSION['semester']=$semester;
    
    
    

    
    

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADD SUBJECT</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css" integrity="sha384-r4NyP46KrjDleawBgD5tp8Y7UzmLA05oM1iAEQ17CSuDqnUK2+k9luXQOfXJCJ4I" crossorigin="anonymous">
</head>
<body>
    
    <a href="registration.php?stuid=<?php echo $stuid; ?>">
    <input type="button" value="back" />
</a>
    <div class="container">
        <div class="display-2 mt-3">ADD SUBJECT</div>
        <hr>
        <form action="registrationGradecheck.php" name="add_name" id="add_name" method="post">
            <div class="table-responsive">
                <table class="table table-bordered" id="dynamic_field">
                    <tr>
                        <td>
                            <input type="varchar" name="subject[]" placeholder="Enter your subject" class="form-control name_list">
                        </td>
                        <td>
                            <input type="varchar" name="sec[]" placeholder="Enter your sec" class="form-control name_list">
                        </td>
                        <td>
                            <button type="button" name="add" id="add" class="btn btn-success">Add More</button>
                        </td>
                    </tr>
                </table>
                <input type="submit" name="check" id="submit" class="btn btn-info" value="check">
                
            </div>
        </form>
        
    </div>
    
    <div class="container">
        <?php
            if (isset($_POST['check'])) {
                            // Counting Number of skills
                            $count = count($_POST['subject']);
                            $subjects = $_POST['subject'];
                            $sec = $_POST['sec'];
                            

                            if ($count > 0) {
                                echo("count = $count    ").'<br />'."\n";
                                for ($i = 0; $i < $count; $i++) {
                                    $find = "SELECT * FROM sub WHERE SubID = '$subjects[$i]'";
                                    $query = mysqli_query($conn,$find);
                                    $result = mysqli_fetch_assoc($query);
                                    if (mysqli_num_rows($query) <1) {//echo("result success").'<br />'."\n";
                                        //
                                        $set = 0;
                                        $_SESSION['reset']='0';
                                        header("location: registrationGrade.php");
                                    }
                                    $CREDIT = $result['Credit'];
                                    $countsub+= (int)$CREDIT;
                                    echo("CREDIT = $CREDIT    ");
                                    echo("subject = $subjects[$i]   ");
                                    echo("sec = $sec[$i]").'<br />'."\n";
                                    
                                }
                                echo (" SUM CREDIT = $countsub").'<br />'."\n";
                                //echo "<script>alert('Skills inserted successfully!')</script>";
                                
                            } else {
                            //echo "<script>alert('Please enter your skills!')</script>";
                            }
                            
                        }
        ?>
        <?php if ($success ='true') : ?>
            <?php if ($countsub<21&&$countsub>0) : ?>
                <div class="success " style = "color : green;">
                    <h3>
                        <?php
                            echo ("STAT  :can submit");
                        ?>
                    </h3>
                    

                    
                        <input type="submit" name="submit" id="submit" class="btn btn-info" value="Submit" <?php
                            if (isset($_POST['submit'])) {
                                // Counting Number of skills
                                echo("stuid = $stuid").'<br />'."\n";
                                echo("year = $year").'<br />'."\n";
                                echo("semester = $semester").'<br />'."\n";
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
                                }*/
                            }
                        ?>>
                    
                    
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
    </div>
   
    

        
    

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js" integrity="sha384-oesi62hOLfzrys4LxRF63OJCXdXDipiYWBnvTl9Y9/TRlw5xlKIEHpNyvvDShgf/" crossorigin="anonymous"></script>
    
    <script>
        $(document).ready(function() {
            let i = 1;
            $('#add').click(function() {
                i++;
                $('#dynamic_field').append('<tr id="row'+i+'"><td><input type="text" name="subject[]" placeholder="Enter your subject" class="form-control name_list"></td><td><input type="varchar" name="sec[]" placeholder="Enter your sec" class="form-control name_list"></td><td><button type="button" name="remove" id="'+i+'" class="btn btn-danger btn_remove">X</button></td></tr>')
            })
            $(document).on('click', '.btn_remove', function() {
                let button_id = $(this).attr('id');
                $('#row'+button_id+'').remove();
            })
        })
    </script>
</body>
</html>



<?php
        $findsub = mysqli_query($conn,"SELECT * FROM sub ");
        $r =1;
        echo "<table border='1' align='center' class='table table-hover'>";
                    echo "<tr>";
                    echo "<td>"."No."."</td> ";
                    echo "<td>"."SubID"."</td> ";
                    echo "<td>"."subname"."</td> ";
                    echo "<td>"."Credit"."</td> ";
                		
                    echo "</tr>";
                    foreach( $findsub as $row ) {
                    echo "<tr>";
                    echo "<td>" .$r++ ."."."</td> ";
                    echo "<td>" .$row["SubID"] .  "</td> ";
                    echo "<td>" .$row["SubName"] .  "</td> ";
                    echo "<td>" .$row["Credit"] .  "</td> ";
                    echo "</tr>";
                    }
                    echo "</table>";	   
?>