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

    <title>Signin</title>

    <!-- Bootstrap core CSS -->
    <link href="./dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./resc/signin.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
	<%@ page import="java.sql.*, db.Database"%>
	<%
		if (request.getParameter("submit") != null){
			
			//Get Input
			String username = (request.getParameter("inputUsername")).trim();
      String password = (request.getParameter("inputPassword")).trim();
      
      Connection conn = Database.getConnection();
      String query = "select password, class, person_id from users where user_name = '" + username + "'";
      ResultSet results = null;
      Statement stmt = null;

      String storedPass = "";
      String userClass = "";
      String pID = "";
      try{
        stmt = conn.createStatement();
        results = stmt.executeQuery(query);

        while (results != null && results.next()){
          storedPass = (results.getString(1)).trim();
          userClass = (results.getString(2)).trim();
          pID = (results.getString(3)).trim();
        }
      } catch (Exception e){
          System.out.println("Error In Login: " + e.getMessage());
      } finally {
          Database.close(conn);
      }

      if (password.equals(storedPass)){
        //Account match
        out.println("<p><b>Your Login is Successful! Welcome, "+ username +"</b></p>");
        session.setAttribute("username", username);
        session.setAttribute("class", userClass);
        session.setAttribute("p_id", pID);
        response.setHeader("Refresh", "3;url=menu.jsp");
      } else { %>
        //No account match
        <div class="alert alert-danger alert-dismissible fade in" role="alert">
          <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
          <h4 id="oh-snap!-you-got-an-error!">Oh snap! You got an error!<a class="anchorjs-link" href="#oh-snap!-you-got-an-error!"><span class="anchorjs-icon"></span></a></h4>
          <p>Change this and that and try again. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum.</p>
          <p>
            <button type="button" class="btn btn-danger">Take this action</button>
            <button type="button" class="btn btn-default">Or do this</button>
          </p>
        </div>

     <% }
		}
	%>
    <div class="container">

      <form class="form-signin">
        <h2 class="form-signin-heading">Radiology Login</h2>
        <label for="inputUsername" class="sr-only">Username</label>
        <input type="text" id="inputUsername" class="form-control" placeholder="Email address" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>