<?php 	
    function OpenConn()
    {
		$servername = "localhost";
		$username = "root";
		$password = "";
		$dbname = "sodo_rentals";

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);
		
	// Check connection
	if ($conn->connect_error) 
	{
	  die("Connection failed: " . $conn->connect_error);
	}
    return $conn;

    }
    
    function CloseConn($conn)
    {
        $conn -> close();
    }
    
?> 