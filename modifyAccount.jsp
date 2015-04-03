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

    <title>Modify Account</title>

    <!-- Bootstrap core CSS -->
    <link href="./dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <link href="./dist/css/bootstrap-theme.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./resc/userManagement.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>
    <script src="./dist/js/bootstrap.min.js"></script>

    <!-- Editable tables!!-->
    <link href="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet"/>
	<script src="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/js/bootstrap-editable.min.js"></script>
	<script src="./resc/enableEditable.js"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <a class="navbar-brand" href="menu.jsp">Home</a>
	    </div>

	    <ul class="nav navbar-nav navbar-right">
	        <li><a href="help.html">Help</a></li>
	        <li><a href="Logout">Log out</a></li>
	      </ul>
	  </div><!-- /.container-fluid -->
	</nav>
    <div class="page-header">
      <h1>Modify Account</h1>
    </div>
  </head>
  <body>
  	<%@ page import="java.sql.*, db.Database"%>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">Account information</h3>
      </div>
      <div class="panel-body">
        <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Address</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Password</th>
                      </tr>
                    </thead>
                    <tbody>
                        <%
                            Database db = new Database();
                            Connection conn = db.getConnection();
                            String query = "SELECT * FROM persons where person_id = " +session.getAttribute("p_id");
                            String query2 = "SELECT password FROM users where user_name = '" + session.getAttribute("username") +"'";

                            try{
                                Statement stmt = conn.createStatement();
                                ResultSet results = stmt.executeQuery(query);

                                Statement stmt2 = conn.createStatement();
                                ResultSet results2 = stmt2.executeQuery(query2);

                                while(results.next() && results2.next()){ 
                                String firstname = results.getString(2);
                                String lastname = results.getString(3);
                                String id = results.getString(1);
                                String address = results.getString(4);
                                String email = results.getString(5);
                                String phone = results.getString(6);
                                String pk = "\"" + id + "\"";
                                String password = results2.getString(1);
                                                                %>
                                    <tr>
                                        <td class="editable" id="firstname" data-type="text" data-url="SubmitData" data-title="Enter First Name" data-pk=<%out.println(pk);%>><%out.println(firstname);%></td>
                                        <td class="editable" id="lastname" data-type="text" data-url="SubmitData" data-title="Enter Last Name" data-pk=<%out.println(pk);%>><%out.println(lastname);%></td>
                                        <td class="editable" id="address" data-type="text" data-url="SubmitData" data-title="Enter Address" data-pk=<%out.println(pk);%>><%out.println(address);%></td>
                                        <td class="editable" id="email" data-type="text" data-url="SubmitData" data-title="Enter Email" data-pk=<%out.println(pk);%>><%out.println(email);%></td>
                                        <td class="editable" id="phone" data-type="text" data-url="SubmitData" data-title="Enter Phone Number" data-pk=<%out.println(pk);%>><%out.println(phone);%></td>
                                        <td class="editable" id="password" data-type="text" data-url="SubmitData" data-title="Enter Password" data-pk=<%out.println("\"'"+session.getAttribute("username")+"'\"");%>><%out.println(password);%></td>
                                    </tr>
                            <%  }
                            } catch (Exception e){
                                System.out.println("Error getting data for Persons Table: " + e.getMessage());
                            } finally {
                                db.close();
                            }
                        %>
                    </tbody>
                  </table>
      </div>
    </div>
  </body>
</html>