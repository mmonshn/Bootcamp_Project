<?php
    session_start();
    include('sever.php');
    $stuid = $_GET['stuid'];
    echo("stuid = $stuid");
/*
    $sql = "SELECT * FROM watchgradeall WHERE StuID = '63070501068' ORDER BY StuID " ;
    $find = mysqli_query($conn,$sql);
    $result = mysqli_fetch_assoc($find);
*/
    /////////////////////////   1
    
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>grade</title>
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
            <h2>CHECK GRADE</h2>
        </div>

           
                <?php
                    $r=1;
                    $sql = "SELECT * FROM watchgradeall WHERE StuID = '$stuid' ORDER BY StuID " ;
                    $find = mysqli_query($conn,$sql);
                    echo "<table border='1' align='center' class='table table-hover'>";
                    echo "<tr>";
                    echo "<td>"."No."."</td> ";
                    echo "<td>"."RegisID"."</td> ";
                    echo "<td>"."StuID"."</td> ";
                    echo "<td>"."fname"."</td> ";
                    echo "<td>"."year"."</td> ";
                    echo "<td>"."semester"."</td> ";
                    echo "<td>"."SubID"."</td> ";
                    echo "<td>"."SubName"."</td> ";
                    echo "<td>"."Grade"."</td> ";	
                    echo "<td>"."Credit"."</td> ";		
                    echo "<td>"."calegrade"."</td> ";		
                    echo "</tr>";
                    foreach( $find as $row ) {
                    echo "<tr>";
                    echo "<td>" .$r++ ."."."</td> ";
                    echo "<td>" .$row["RegisID"] .  "</td> ";
                    echo "<td>" .$row["StuID"] .  "</td> ";
                    echo "<td>" .$row["fname"] .  "</td> ";
                    echo "<td>" .$row["Years"] .  "</td> ";
                    echo "<td>" .$row["Semester"] .  "</td> ";
                    echo "<td>" .$row["SubID"] .  "</td> ";
                    echo "<td>" .$row["SubName"] .  "</td> ";
                    echo "<td>" .$row["Grade"] .  "</td> ";
                    echo "<td>" .$row["Credit"] .  "</td> ";
                    echo "<td>" .$row["calegrade"]."</td> ";
                    echo "</tr>";
                    }
                    echo "</table>";	      
                ?>
    
    <div class="header">
        <h2> check grade </h2>
    </div>
    <form action="" method="post">
        <div class="input-group">
            <label for="year">year</label>
            <input type="int" name="year">
        </div>
        <div class="input-group">
            <label for="semester">semester</label>
            <input type="int" name="semester">
        </div>
        <div class="input-group">
            <button type="submit" name="checkgrade" class ="btn">checkgrade</button>
        </div>
    </form>
            <?php
            if (isset($_POST['checkgrade'])){

                $year = mysqli_real_escape_string($conn,$_POST['year']);
                $semester = mysqli_real_escape_string($conn,$_POST['semester']);
                echo("year = $year");
                echo("semester = $semester");
                if(!empty($year)&&!empty($semester)){
                    $r=1;
                    $sql = "SELECT * FROM watchgradeall WHERE StuID = '$stuid' AND Years = '$year' AND Semester = '$semester' ORDER BY StuID " ;
                    $find = mysqli_query($conn,$sql);
                        echo "<table border='1' align='center' class='table table-hover'>";
                        echo "<tr>";
                        echo "<td>"."No."."</td> ";
                        echo "<td>"."RegisID"."</td> ";
                        echo "<td>"."StuID"."</td> ";
                        echo "<td>"."fname"."</td> ";
                        echo "<td>"."year"."</td> ";
                        echo "<td>"."semester"."</td> ";
                        echo "<td>"."SubID"."</td> ";
                        echo "<td>"."SubName"."</td> ";
                        echo "<td>"."Grade"."</td> ";	
                        echo "<td>"."Credit"."</td> ";		
                        echo "<td>"."calegrade"."</td> ";		
                        echo "</tr>";
                        foreach( $find as $row ) {
                        echo "<tr>";
                        echo "<td>" .$r++ ."."."</td> ";
                        echo "<td>" .$row["RegisID"] .  "</td> ";
                        echo "<td>" .$row["StuID"] .  "</td> ";
                        echo "<td>" .$row["fname"] .  "</td> ";
                        echo "<td>" .$row["Years"] .  "</td> ";
                        echo "<td>" .$row["Semester"] .  "</td> ";
                        echo "<td>" .$row["SubID"] .  "</td> ";
                        echo "<td>" .$row["SubName"] .  "</td> ";
                        echo "<td>" .$row["Grade"] .  "</td> ";
                        echo "<td>" .$row["Credit"] .  "</td> ";
                        echo "<td>" .$row["calegrade"]."</td> ";
                        echo "</tr>";
                        }
                        echo "</table>";	
                        echo("").'<br />'."\n";
                    $sqls = "SELECT SUM(calegrade)/SUM(Credit) AS AVERGEGRADE FROM watchgradeall WHERE StuID = '$stuid' AND Years = '$year' AND Semester = '$semester' GROUP BY RegisID " ;
                    $finds = mysqli_query($conn,$sqls);
                    echo "<table border='1' align='center' class='table table-hover'>";
                    echo "<tr>";
                    echo "<td>"."AVERAGE GRADE"."</td> ";		
                    echo "</tr>";
                    foreach( $finds as $row ) {
                    echo "<tr>";
                    echo "<td>" .$row["AVERGEGRADE"] .  "</td> ";
                    echo "</tr>";
                    }
                    echo "</table>";	
                    echo("").'<br />'."\n";
                }   
            }      
            ?>
    
</html>

