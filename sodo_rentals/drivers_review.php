<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" href="style.css">
	<title>Driver Reviews</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-dark" style="background-color:#933a3b;">
		<a class="navbar-brand" href="index.php">Sodo Car Rentals</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
			aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="drivers_review.php">Driver Reviews</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="gps_replacement.php">GPS Replacement Vehicles</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="loyal_customers.php">Loyal Customers</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="popular_cars.php">Popular Car Brands</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="insurance_check.php">Insurance Check</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="liabilities.php">Liability Vehicles</a>
				</li>
			</ul>
		</div>
	</nav>
	<?php
    include('db_connections.php');

    $conn = OpenConn();

    //write sql
    $sql = "SELECT concat(first_name,' ', last_name) as 'Driver', AVG(Cast(review_score as Float)) as average_rating
	FROM Reservation 
	LEFT OUTER JOIN Employee ON
	Employee.employee_id = Reservation.employee_id
	GROUP BY  concat(first_name, last_name)
	ORDER BY AVG(Cast(review_score as Float)) DESC;";

    //execute sql
    $result = $conn->query($sql);

    //check if any record was found
    if ($result->num_rows > 0) {
	    //create an array
    	$reviews = array();
	    $drivers = array();

	    while ($row = $result->fetch_assoc()) {
		    array_push($reviews, $row["average_rating"]);
		    array_push($drivers, $row["Driver"]);

	    }

    }
    CloseConn($conn);
    ?>
	<h1 style="text-align: center; margin: 1em 0">Ratings of SODO Drivers</h1>
	<canvas id="myChart" style="width:100%;max-width:600px;margin:auto"></canvas>


	<script>


		var xValues = <?php

        echo json_encode($drivers);
        ?>
	
	var yValues = <?php echo json_encode($reviews); ?>;
		var barColors = [];
		//create a random color for each bar from xValues
		for (var i = 0; i < xValues.length; i++) {
			barColors.push("rgb(" + Math.floor(Math.random() * 255) + "," + Math.floor(Math.random() * 255) + "," +
				Math.floor(Math.random() * 255) + ")");
		}

		new Chart("myChart", {
			type: "horizontalBar",
			data: {
				labels: xValues,
				datasets: [{
					backgroundColor: barColors,
					data: yValues
				}]
			},
			options: {
				legend: { display: false },
				title: {
					display: true,
					text: "Average Rating of Drivers"
				}
			}
		});
	</script>
</body>

</html>