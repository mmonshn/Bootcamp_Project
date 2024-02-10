<?php
    session_start();
    include('sever.php');
    $stuid = $_GET['stuid'];
    echo("stuid = $stuid");

?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>timetable</title>

        <link rel="stylesheet" href="style.css">
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
        <style>
            label {
                display: inline-block;
                width: 80px;
                margin-bottom: 10px;
            }
        </style>
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
                <button type="submit" name="submit" class ="btn">Summit</button>
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
    $sql = "SELECT * FROM watchinfoclass WHERE StuID = '$stuid' AND Years = '$year' AND Semester = '$semester' 
    ORDER BY CASE 
    WHEN Dateday = 'Monday' then 1
    WHEN Dateday = 'Tuesday' then 2 
    WHEN Dateday = 'Wednesday' then 3 
    WHEN Dateday = 'Thursday' then 4
    WHEN Dateday = 'Friday' then 5
    ELSE 0 END,Datetime DESC" ;
    $find = mysqli_query($conn,$sql);
    
    echo "<table border='1' align='center' class='table table-hover'>";
    echo "<tr>";
    echo "<td>"."Dateday"."</td> ";
    echo "<td>"."Datetime"."</td> ";
    echo "<td>"."SubID"."</td> ";
    echo "<td>"."SubName"."</td> ";
    echo "<td>"."Sec"."</td> ";
    echo "<td>"."ProID"."</td> ";
    echo "<td>"."RoomName"."</td> ";		
    echo "</tr>";
    foreach( $find as $row ) {
	echo "<tr>";
	echo "<td>" .$row["Dateday"] .  "</td> ";
    echo "<td>" .$row["Datetime"] .  "</td> ";
    echo "<td>" .$row["SubID"] .  "</td> ";
    echo "<td>" .$row["SubName"] .  "</td> ";
    echo "<td>" .$row["Sec"] .  "</td> ";
    echo "<td>" .$row["ProID"] .  "</td> ";
    echo "<td>" .$row["RoomName"] .  "</td> ";
	echo "</tr>";
    }
	echo "</table>";
}}
?>