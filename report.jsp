<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Login Screen for Radiology Project">
    <meta name="author" content=" Ryan Thornhill">
    <link rel="icon" href="../../favicon.ico">

    <title>User Management</title>

    <!-- Bootstrap core CSS -->
    <link href="./dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <link href="./dist/css/bootstrap-theme.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./resc/report.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>
    <script src="./dist/js/bootstrap.min.js"></script>
    <div class="page-header">
      <h1>Report Module</h1>
    </div>
    </head>

    <body>
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Search Area</h3>
          </div>
          <div class="panel-body">
            <form class="form-search form-inline">
                <div class="form-group">
                    <input type="text" id="diagnosis" name="diagnosis" class="form-control diagnosis-field" placeholder="Diagnosis" required autofocus>
                </div>
                <div class="form-group">
                    <label for="start-date">Start:</label>
                    <input type="date" id="start-date" name="startdaate" class="form-control date-field" placeholder="Start Date" required autofocus>
                </div>
                <div class="form-group">
                    <label for="end-date">End:</label>
                    <input type="date" id="end-date" name="enddate" class="form-control date-field" placeholder="Start Date" required autofocus>
                </div>
                <button type="submit" class="btn btn-primary">Search</button>
            </form>
          </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-body">

            </div>
        </div>
    </body>
</html>