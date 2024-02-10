<?php
    session_start();
    include('sever.php');
    $proid = $_GET['proid'];
    echo("proid = $proid");
  
    $r=1;
    $sql = "SELECT * FROM proteachstcnt WHERE ProID ='$proid'ORDER BY ProID " ;
    $find = mysqli_query($conn,$sql);
    echo "<table border='1' align='center' class='table table-hover'>";
    echo "<tr>";
    echo "<td>"."ProID"."</td> ";
    echo "<td>"."fname"."</td> ";
    echo "<td>"."lname"."</td> ";
    echo "<td>"."Year"."</td> ";
    echo "<td>"."Semester"."</td> ";
    echo "<td>"."SubID"."</td> ";
    echo "<td>"."SubName"."</td> ";
    echo "<td>"."Sec"."</td> ";
    echo "<td>"."CountStudent"."</td> ";		
    echo "</tr>";
    foreach( $find as $row ) {
	echo "<tr>";
    echo "<td>" .$row["ProID"] .  "</td> ";
    echo "<td>" .$row["fname"] .  "</td> ";
    echo "<td>" .$row["lname"] .  "</td> ";
	echo "<td>" .$row["Years"] .  "</td> ";
    echo "<td>" .$row["Semester"] .  "</td> ";
    echo "<td>" .$row["SubID"] .  "</td> ";
    echo "<td>" .$row["SubName"] .  "</td> ";
    echo "<td>" .$row["Sec"] .  "</td> ";
    echo "<td>" .$row["CountStudent"] .  "</td> ";
	echo "</tr>";
    }
	echo "</table>";


?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>countstudent</title>
        <style>
            label {
                display: inline-block;
                width: 80px;
                margin-bottom: 10px;
            }
        </style>
        <<link rel="stylesheet" href="style.css">
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
        <h2> information about us each year/semester </h2>
    </div>
    <form action="" method="post">
        <div class="input-group">
            <label for="year">Year</label>
            <input type="int" name="year">
        </div>
        <div class="input-group">
            <label for="semester">Semester</label>
            <input type="int" name="semester">
        </div>
        <div class="input-group">
            <button type="submit" name="submit" class ="btn">Submit</button>
        </div>
    </form>
</body>
</html>

<?php
    if (isset($_POST['submit'])){

        $year = mysqli_real_escape_string($conn,$_POST['year']);
        $semester = mysqli_real_escape_string($conn,$_POST['semester']);
        echo("Year = $year ,");
        echo("\n Semester = $semester");
        if(!empty($year)&&!empty($semester)){
            $r=1;
            $sql = "SELECT * FROM proteachstcnt WHERE ProID = '$proid' AND Years = '$year' AND Semester = '$semester' ORDER BY ProID " ;
            $find = mysqli_query($conn,$sql);
                echo "<table border='1' align='center' class='table table-hover'>";
                echo "<tr>";
                echo "<td>"."ProID"."</td> ";
                echo "<td>"."fname"."</td> ";
                echo "<td>"."lname"."</td> ";
                echo "<td>"."year"."</td> ";
                echo "<td>"."semester"."</td> ";
                echo "<td>"."SubID"."</td> ";
                echo "<td>"."SubName"."</td> ";
                echo "<td>"."Sec"."</td> ";	
                echo "<td>"."CountStudent"."</td> ";			
                echo "</tr>";
                foreach( $find as $row ) {
                echo "<tr>";
                echo "<td>" .$row["ProID"] .  "</td> ";
                echo "<td>" .$row["fname"] .  "</td> ";
                echo "<td>" .$row["lname"] .  "</td> ";
                echo "<td>" .$row["Years"] .  "</td> ";
                echo "<td>" .$row["Semester"] .  "</td> ";
                echo "<td>" .$row["SubID"] .  "</td> ";
                echo "<td>" .$row["SubName"] .  "</td> ";
                echo "<td>" .$row["Sec"] .  "</td> ";
                echo "<td>" .$row["CountStudent"] .  "</td> ";
                echo "</tr>";
                }
                echo "</table>";
        }
    }
?>