<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link rel="stylesheet" href="style.css">
  <title>GPS Replacement</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
</head>
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

  $sql = "SELECT vehicle_name, A.number_plate FROM Vehicle V
  INNER JOIN
  (SELECT vehicle_id, number_plate FROM Supplied_Vehicles WHERE number_plate IN
  (SELECT number_plate FROM Supplied_Vehicles
  WHERE ROUND((CURDATE() - gps_date_purchased) / 365) > gps_health_life)) A
  ON V.vehicle_id = A.vehicle_id;";

  $result = $conn->query($sql);

  if ($result->num_rows > 0) {
    $vehicle_name = array();
    $number_plate = array();

    while ($row = $result->fetch_assoc()) {
      array_push($vehicle_name, $row["vehicle_name"]);
      array_push($number_plate, $row["number_plate"]);

    }
  }

  CloseConn($conn);
  ?>
  <h1 style="text-align: center; margin: 1em 0">List of Cars That Need GPS Replacement</h1>
  <table class="table table-striped" style="margin:auto">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">Vehicle Brand</th>
        <th scope="col">Number Plate</th>
      </tr>
    </thead>
    <tbody>

      <tr>
        <?php
        for ($i = 0; $i < count($vehicle_name); $i++) {
          echo "<tr>";
          echo "<th scope='row'>" . ($i + 1) . "</th>";
          echo "<td>" . $vehicle_name[$i] . "</td>";
          echo "<td>" . $number_plate[$i] . "</td>";
          echo "</tr>";
        }
        ?>
      </tr>
    </tbody>
  </table>

</body>

</html>