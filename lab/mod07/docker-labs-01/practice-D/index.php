<html>
<p>Welcome to simple PHP page</p>
<p>This page will sum up 2 numbers and give you the answer </p> 


<form action="index.php" method="GET">
     Num1: <input type="number" name="num1">
     Num2: <input type="number" name="num2">
     <input type="submit">
</form>

<?php
     $num1 = $_GET["num1"];
     $num2 = $_GET["num2"];
     echo $num1 + $num2;
?>

</html>