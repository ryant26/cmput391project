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
  </head>
  <body>
  	<%@ page import="java.sql.*, db.Database"%>
  	<h1>User Management</h1>

  	<div role="tabpanel">
	  	
	  	<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#Users" aria-controls="Users" role="tab" data-toggle="tab">Users</a></li>
		  <li role="presentation"><a href="#Persons" role="tab" aria-controls="Persons" data-toggle="tab">Persons</a></li>
		  <li role="presentation"><a href="#Family_doctor" role="tab" aria-controls="Family_doctor" data-toggle="tab">Family_doctor</a></li>
		
		</ul>
		<!-- Tab panes -->

	  <div class="tab-content">
	    <div role="tabpanel" class="tab-pane active" id="Users">
    		<div class="panel panel-default">
			  <div class="panel-body">
			    <div class="container">
				  <table class="table table-hover">
				    <thead>
				      <tr>
				        <th>Username</th>
				        <th>Password</th>
				        <th>Person ID</th>
				        <th>Date Registered</th>
				        <th>Class</th>
				      </tr>
				    </thead>
				    <tbody>
				    	<%
				    		Database db = new Database();
				    		Connection conn = db.getConnection();
				    		String query = "SELECT * FROM users";
				    		ResultSet results = null;
				    		Statement stmt = null;

				    		try{
				    			stmt = conn.createStatement();
				    			results = stmt.executeQuery(query);

				    			while(results.next()){ 
				    			String username = results.getString(1);
				    			String password = results.getString(2);
				    			String id = results.getString(4);
				    			String dateRegistered = results.getString(5);
				    			String pClass = results.getString(3);
				    			String pk = "\"" + id + "\"";
				    											%>
				    				<tr>
								        <td id="username" data-type="text" data-url="#" data-title="Enter Userame" data-pk=<%out.println(pk);%>><%out.println(username);%></td>
								        <td id="password" data-type="text" data-url="#" data-title="Enter Password" data-pk=<%out.println(pk);%>><%out.println(password);%></td>
								        <td><%out.println(id);%></td>
								        <td id="date" data-type="date" data-url="#" data-title="Enter Date" data-pk=<%out.println(pk);%>><%out.println(dateRegistered);%></td>
								        <td id="class" data-type="text" data-url="#" data-title="Enter Class" data-pk=<%out.println(pk);%>><%out.println(pClass);%></td>
								    </tr>
				    		<%  }
				    		} catch (Exception e){
				    			System.out.println("Error getting data for User Table: " + e.getMessage());
				    		}
				    	%>
				    </tbody>
				  </table>
				</div>
			  </div>
			</div>
	    </div>
	    <div role="tabpanel" class="tab-pane" id="Persons">...</div>
	    <div role="tabpanel" class="tab-pane" id="Family_doctor">...</div>
	  </div>
	</div>
  </body>
</html>
