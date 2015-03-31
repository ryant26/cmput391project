<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Main Menu">
    <meta name="author" content=" Ryan Thornhill">
    <link rel="icon" href="../../favicon.ico">

    <title>Signin</title>

    <!-- Bootstrap core CSS -->
    <link href="./dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <link href="./dist/css/bootstrap-theme.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./resc/menu.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>
    <script src="./dist/js/bootstrap.min.js"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
   <body>
        <div class="form-menu">
            <h2 class="form-heading">Main Menu:</h2>
            <div class="list-group">
                <%
                String userClass = (String) session.getAttribute("class");
                try{
                    if (userClass.equals("a")){ %>

                        <a href="#" class="list-group-item">User Managment</a>
                        <a href="#" class="list-group-item">Report Generation</a>
                        <a href="#" class="list-group-item">Data Analysis</a>
                    
                    <%} else if (userClass.equals("r")){ %>
                        <a href="#" class="list-group-item">Upload Image</a>
                    <%  } %>
                    
                    <a href="#" class="list-group-item">Search Module</a>
                    <a href="#" class="list-group-item">Modify Account</a>        
                    
             <% } catch (NullPointerException e){
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                }
                %>
            </div>
        </div>
    </body>
</html>   