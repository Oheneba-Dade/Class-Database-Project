<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link rel="stylesheet" href="style.css">
  <title>Loyal Customers</title>
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

  $sql = " SELECT concat(first_name, ' ', last_name) AS 'Loyal Customer', COUNT(*) AS number_of_reservations
  FROM Customers 
  INNER JOIN Reservation ON
  Customers.customer_id = Reservation.customer_id
  WHERE CURDATE() - reservation_start_date < 120
  GROUP BY concat(first_name, last_name) ORDER BY number_of_reservations DESC;";

  $result = $conn->query($sql);

  if ($result->num_rows > 0) {
    $customer_name = array();
    $reservation_count = array();
  }

  while ($row = $result->fetch_assoc()) {
    array_push($customer_name, $row['Loyal Customer']);
    array_push($reservation_count, $row['number_of_reservations']);
  }

  CloseConn($conn);
  ?>
  <h1 style="text-align: center; margin: 1em 0">Most Loyal Customers In The Past 4 Months</h1>
  <canvas id="myChart" style="width:100%;max-width:600px;margin:auto"></canvas>

  <script>


    var xValues = <?php

    echo json_encode($customer_name);
    ?>

	var yValues = <?php echo json_encode($reservation_count); ?>;
    var barColors = [];
    //create a random color for each bar from xValues
    for (var i = 0; i < xValues.length; i++) {
      barColors.push("rgb(" + Math.floor(Math.random() * 255) + "," + Math.floor(Math.random() * 255) + "," +
        Math.floor(Math.random() * 255) + ")");
    }

    new Chart("myChart", {
      type: "pie",
      data: {
        labels: xValues,
        datasets: [{
          backgroundColor: barColors,
          data: yValues
        }]
      },
      options: {

        legend: { display: true },
        title: {
          display: true,
          text: "Most Loyal Customers In The Past 4 Months"
        }
      }
    });
  </script>

</body>

</html>