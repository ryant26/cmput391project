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
                    <input type="date" id="start-date" name="startdate" class="form-control date-field" placeholder="Start Date" required autofocus>
                </div>
                <div class="form-group">
                    <label for="end-date">End:</label>
                    <input type="date" id="end-date" name="enddate" class="form-control date-field" placeholder="Start Date" required autofocus>
                </div>
                <button name="bSubmit" type="submit" class="btn btn-primary">Search</button>
            </form>
          </div>
        </div>
        <%@ page import="java.sql.*, db.Database"%>
                <%
                    if (request.getParameter("bSubmit") != null){
                        String diagnosis = request.getParameter("diagnosis").trim();
                        String startDate = request.getParameter("startdate").trim();
                        String endDate = request.getParameter("enddate").trim();
                        System.out.println("DEBUG start date :" + startDate);
                        System.out.println("DEBUG end date :" + endDate);

                        Database db = new Database();
                        Connection conn = db.getConnection();
                        String query = " SELECT p.last_name, p.first_name, p.address, p.phone, r.test_date " +
                        "FROM persons p, radiology_record r " +
                        "WHERE p.person_id = r.patient_id " +
                        "AND '" + diagnosis + "' = r.diagnosis " +
                        "AND r.test_date between to_date('" + startDate +"', 'YYYY-MM-DD') " +
                        "AND to_date('" + endDate +"', 'YYYY-MM-DD') " +
                        "ORDER BY p.last_name";

                        try{
                            Statement stmt = conn.createStatement();
                            ResultSet results = stmt.executeQuery(query); %>
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <table class="table table-striped"> 
                                        <thead>
                                          <tr>
                                            <th>Last Name</th>
                                            <th>First Name</th>
                                            <th>Address</th>
                                            <th>Phone Mumber</th>
                                            <th>Test Date</th>
                                          </tr>
                                        </thead> 
                                        <tbody><%
                            while (results.next()){
                                String lastname = results.getString(1);
                                String firstname = results.getString(2);
                                String address = results.getString(3);
                                String phonenumber = results.getString(4);
                                String testdate = results.getString(5);
                                %>
                                <tr>
                                    <td id="lastname"><%out.println(lastname);%></td>
                                    <td id="firstname"><%out.println(firstname);%></td>
                                    <td id="address"><%out.println(address);%></td>
                                    <td id="phonenumber"><%out.println(phonenumber);%></td>
                                    <td id="testdate"><%out.println(testdate);%></td>
                                </tr>
                                <%
                            }
                            %>          </tbody>
                                    </table>
                                </div>
                            </div> <%
                        } catch (Exception e){
                            System.out.println("Error In report: " + e.getMessage());
                        } finally {
                            db.close();
                        }
                    }
                %>
        
    </body>
</html>