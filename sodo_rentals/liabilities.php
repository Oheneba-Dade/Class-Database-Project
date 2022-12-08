<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link rel="stylesheet" href="style.css">
  <title>Sodo Rentals Liabilities</title>
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

  $sql = "SELECT number_plate, COUNT(*) AS repair_count FROM Serviced_Vehicles
  WHERE reason_for_service NOT IN ('general checkup')
  GROUP BY number_plate;
  ";

  $result = $conn->query($sql);

  if ($result->num_rows > 0) {
    $number_plate = array();
    $repair_count = array();

    while ($row = $result->fetch_assoc()) {
      array_push($number_plate, $row["number_plate"]);
      array_push($repair_count, $row["repair_count"]);
    }
  }
  CloseConn($conn);
  ?>
  <h1 style="text-align: center; margin: 1em 0">Faulty Cars Report</h1>
  <table class="table table-striped" style="margin:auto">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">Number Plate</th>
        <th scope="col">Number of Repairs</th>
      </tr>
    </thead>
    <tbody>

      <tr>
        <?php
        for ($i = 0; $i < count($number_plate); $i++) {
          echo "<tr>";
          echo "<th scope='row'>" . ($i + 1) . "</th>";
          echo "<td>" . $number_plate[$i] . "</td>";
          echo "<td>" . $repair_count[$i] . "</td>";
          echo "</tr>";
        }
        ?>
      </tr>
    </tbody>
  </table>


</body>

</html>