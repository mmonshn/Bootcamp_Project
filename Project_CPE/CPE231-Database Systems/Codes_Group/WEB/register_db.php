<?php
session_start();
include('sever.php');

    $errors = array();

    if(isset($_POST['reg_user'])){
        
        $username = mysqli_real_escape_string($conn,$_POST['username']);
        $password = mysqli_real_escape_string($conn,$_POST['password']);
        //check 1
        echo("reg_user isset\n").'<br />'."\n";
        echo("username = $username \n").'<br />'."\n";
        echo("password = $password \n").'<br />'."\n";
        
        $user_check_query = "SELECT * FROM student WHERE Email ='$username' ";
        $query = mysqli_query($conn,$user_check_query);
        $result = mysqli_fetch_assoc($query);
        if(empty($username)){
            array_push($errors,"username is required"); 
           // echo("error = 2").'<br />'."\n";
        }
        else if(empty($password)){
            array_push($errors,"uspassword is required"); 
            //echo("error = 3").'<br />'."\n";
        }
       /* else{
            echo("update successfully");
        }*/
        else if($result){
            if(!$result['Email'] === $username){
                array_push($errors, "username not already exists"); 
                echo("error = 5").'<br />'."\n";
            }
            else {//(count($errors) == 1 )
            //$password_db = md5($password);
            //echo("update success fully").'<br />'."\n";
            $sql = "UPDATE student SET Pass = '$password' WHERE Email = '$username'";
            mysqli_query($conn,$sql);
            
            /*echo "<script>alert('change password succesfully!);</script>";
            echo "<script>window.location.href='login.php'</script>"*/
           
             $_SESSION['username'] = $username;
             $_SESSION['success'] = "you are new password ";
             header('location: login.php');
            }
        }
       
        
         else  {echo("reg_user is not isset\n").'<br />'."\n";}
        
    } 
   
  
    
?>