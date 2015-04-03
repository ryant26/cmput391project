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
      <h1>Add Person</h1>
    </div>
    </head>
    <body>
        <div class="panel panel-default">
          <div class="panel-body">
            <form class="form-horizontal" id="addPersonForm" action="AddNewEntries">
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-1 control-label">First Name:</label>
                <div class="col-sm-11">
                  <input type="text" class="form-control" id="firstname" name="firstname" placeholder="First Name" required autofocus>
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-1 control-label">Last Name:</label>
                <div class="col-sm-11">
                  <input type="lastname" class="form-control" id="lastname" name="lastname" placeholder="Last Name" required autofocus>
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-1 control-label">Address:</label>
                <div class="col-sm-11">
                  <input type="text" class="form-control" id="address" name="address" placeholder="Address" required autofocus>
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-1 control-label">Person ID:</label>
                <div class="col-sm-11">
                  <input type="text" class="form-control" id="personid" name="personid" placeholder="Person ID" required autofocus>
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-1 control-label">Email:</label>
                <div class="col-sm-11">
                    <input type="email" id="email" name="email" class="form-control" placeholder="Email" required autofocus>
                </div>
              </div>
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-1 control-label">Phone:</label>
                <div class="col-sm-11">
                  <input type="text" class="form-control" id="phone" name="phone" placeholder="Phone" required autofocus>
                </div>
              </div>
              <div class="col-sm-offset-1 col-sm-10">
                <button type="submit" class="btn btn-default">Submit</button>
              </div>
              <div class="col-sm-offset-1 col-sm-10">
                  <div class="col-sm-11" id="result"></div>
              </div>
            </form>
            
            <script>
                $( "#addPersonForm" ).submit(function( event ) {
                    event.preventDefault();

                    var $form = $(this),
                    firstnamej = $form.find( "input[name='firstname']").val(),
                    lastnamej = $form.find( "input[name='lastname']").val(),
                    addressj = $form.find( "input[name='address']").val(),
                    personidj = $form.find( "input[name='personid']").val(),
                    emailj = $form.find( "input[name='email']").val(),
                    phonej = $form.find( "input[name='phone']").val(),
                    url = $form.attr( "action" );

                    //send
                    var posting = $.post(url, {
                        firstname: firstnamej,
                        lastname: lastnamej,
                        address: addressj,
                        personid: personidj,
                        email: emailj,
                        phone: phonej,
                        type: "person"
                    });

                    //get results
                    posting.fail(function (data) {
                        $("#result").empty().append( "<div class=\"alert alert-danger\" role=\"alert\">" + data.responseText +"</div>" );
                    });

                    //get results
                    posting.done(function (data) {
                        $("#result").empty().append( "<div class=\"alert alert-success\" role=\"alert\">" + data +"</div>" );
                    });

                });
            </script>
          </div>
        </div>
    </body>
</html>
