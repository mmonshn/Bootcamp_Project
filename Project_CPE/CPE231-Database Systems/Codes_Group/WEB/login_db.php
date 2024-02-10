<?php
    session_start();
    include('sever.php');

    $errors = array();

    if(isset($_POST['login_user'])){
        $username = mysqli_real_escape_string($conn,$_POST['username']);
        $password = mysqli_real_escape_string($conn,$_POST['password']);
        //echo("username = $username").'<br />'."\n";
        //echo("password = $password").'<br />'."\n";
        if(empty($username)){
            array_push($error,"username is requried"); //echo("error = 1").'<br />'."\n";
        }
        else if(empty($password)){
            array_push($error,"password is required");//echo("error = 2").'<br />'."\n";
        }
        else{
            //echo("result = 1").'<br />'."\n";
            //$password = md5($password);
            $query = "SELECT * FROM student WHERE Email = '$username' AND Pass = '$password' ";
            $result = mysqli_query($conn, $query);
            $count = mysqli_num_rows($result);
            //echo("row count = $count").'<br />'."\n";
           
            if (mysqli_num_rows($result) == 1) {//echo("result success").'<br />'."\n";
                $_SESSION['username'] = $username;
                $_SESSION['success'] = "Your are now logged in";
                header("location: index.php");
            }
            else {
                $query = "SELECT * FROM professor WHERE Email = '$username' AND Pass = '$password' ";
                $results = mysqli_query($conn, $query);
                $counts = mysqli_num_rows($results);
                if (mysqli_num_rows($results) == 1) {//echo("result success").'<br />'."\n";
                    $_SESSION['username'] = $username;
                    $_SESSION['success'] = "Your are now logged in";
                    header("location: index2.php");
                }
                else {//echo("error = 3").'<br />'."\n";
                    array_push($errors, "Wrong Username or Password");
                    $_SESSION['error'] = "Wrong Username or Password!";
                    header("location: login.php");
                }
            } 
            
        }
    }

?>
