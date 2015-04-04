<%@ page import="java.sql.*, java.util.*, db.Database" %>
<HTML>
	<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Login Screen for Radiology Project">
    <meta name="author" content=" Ryan Thornhill">
    <link rel="icon" href="../../favicon.ico">

    <title>OLAP</title>

    <!-- Bootstrap core CSS -->
    <link href="./dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <link href="./dist/css/bootstrap-theme.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./resc/olap.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>
    <script src="./dist/js/bootstrap.min.js"></script>
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
      <h1>Data Analysis Module</h1>
    </div>
    </head>
    <BODY> 
		<%
			//only admin can use
			try{
				if (!(((String) session.getAttribute("class")).equals("a"))){
					throw new Exception();
				}
			} catch (Exception e){
				response.sendError(HttpServletResponse.SC_FORBIDDEN);
			}
		%>

		<%
  		/*String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";
      
		String m_userName = "aayao"; //supply username
		String m_password = "FGThjklzEX_16"; //supply password

		Connection m_con;
      
		try {
      
			Class drvClass = Class.forName(m_driverName);
			DriverManager.registerDriver((Driver)
			drvClass.newInstance());
			m_con = DriverManager.getConnection(m_url, m_userName, m_password);
        
		} catch(Exception e) {      
			out.print("Error displaying data: ");
			out.println(e.getMessage());
			return;
		} */

		//use this for final submission
		Database db = new Database();
		Connection m_con = db.getConnection();
          
	%>
	<div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Display # of images for:</h3>
          </div>
          <div class="panel-body">
            <form class="form-search form-horizontal" name="queryData" method="post" action="OLAP.jsp">
                <div class="form-group form-inline">
                 <div class="col-sm-offset-1 col-sm-10">
			      <div class="checkbox">
			        <label>
			          <input type="checkbox" name="patient" value="Y"> Patient
			        </label>
			      </div>
			      <div class="checkbox check-padded">
			        <label>
			          <input type="checkbox" name="testtype" value="Y"> Test Type
			        </label>
			      </div>
            	</div>
            	</div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="start-date">Start:</label>
                    <div class="col-sm-11">
                    	<input type="date" id="start-date" name="startdate" class="form-control date-field" placeholder="Start Date">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="end-date">End:</label>
                    <div class="col-sm-11">
                    	<input type="date" id="end-date" name="enddate" class="form-control date-field" placeholder="Start Date">
                    </div>
                </div>
                <div class="form-group form-inline">
                 <div class="col-sm-offset-1 col-sm-10">
			      <div class="radio">
			        <label>
			          <input type="radio" name="timeHeir" value="1" checked> Weekly
			        </label>
			      </div>
			      <div class="radio check-padded">
			        <label>
			          <input type="radio" name="timeHeir" value="2"> Monthly
			        </label>
			      </div>
			      <div class="radio check-padded">
			        <label>
			          <input type="radio" name="timeHeir" value="3"> Yearly
			        </label>
			      </div>
            	</div>
            	</div>
                <div class="col-sm-offset-1 col-sm-11">
                	<button name="OLAP" type="submit" value="Submit" class="btn btn-primary">Submit</button>
              	</div>
            </form>
          </div>
        </div>
		<%
			if (request.getParameter("OLAP") != null) {
				Statement doOLAP;
				String startdate, enddate;
				boolean hasDate = false;
				boolean hasType = false;
				boolean hasPatient = false;

				String OLAPStr1 = "SELECT ";
				String OLAPStr2 = ", count(i.record_id) as image_count from persons p, radiology_record r, pacs_images i where p.person_id = r.patient_id AND r.record_id = i.record_id ";
				String OLAPStr3 = "group by CUBE(";

				if(!((startdate = request.getParameter("startdate")).equals(""))) {
			  		out.println("<br>");
		  	  		out.println("From: " + startdate);
			  		hasDate = true;
				} else {
			  		startdate = "0000-01-01";
				}

				if(!((enddate = request.getParameter("enddate")).equals(""))) {
			  		out.println("<br>");
		  	  		out.println("To: " + enddate);
		  	  		out.println("<br>");
			 		hasDate = true;
				} else {
			  		enddate = "9999-12-30";
				}
			
				out.println("<br>Organized by: ");

		        if(request.getParameter("patient")!=null) {
					out.println("<br>");
			  		out.println("Patient ");
			  		hasPatient = true;		  
		        }

				if(request.getParameter("testtype")!=null) {
					out.println("<br>");
					out.println("Test Type ");
			  		hasType = true;		  
		        }

				if(hasPatient) {
					OLAPStr1 += "p.person_id, ";
					OLAPStr3 += "p.person_id, ";
				}

				if(hasType) {
					OLAPStr1 += "r.test_type, ";
					OLAPStr3 += "r.test_type, ";
				}

				if(hasDate) {
					OLAPStr2 += "and to_char(r.test_date, 'YYYY-MM-DD') >= '" + startdate + "' and to_char(r.test_date, 'YYYY-MM-DD') <= '" + enddate + "' ";
				}

				out.println("<br><br> Arranged by: ");

				if (request.getParameter("timeHeir").equals("1")) {
					OLAPStr1 += " trunc(r.test_date, 'IW') as test_date ";
					out.println("<br> Week");
				} else if (request.getParameter("timeHeir").equals("2")) {
					OLAPStr1 += " trunc(r.test_date, 'MM') as test_date ";
					out.println("<br> Month");
				} else if (request.getParameter("timeHeir").equals("3")) {
					OLAPStr1 += " trunc(r.test_date, 'IYYY') as test_date ";
					out.println("<br> Year");
				}

				OLAPStr3 += " test_date)";
				
				//out.println("<br>" + OLAPStr1 + OLAPStr2 + OLAPStr3);

				doOLAP = m_con.createStatement();
				ResultSet rset = doOLAP.executeQuery(OLAPStr1 + OLAPStr2 + OLAPStr3);

				out.println("<table border=1>");
				out.println("<tr>");

				if (hasPatient) {
					out.println("<th>Patient ID</th>");
					out.println("<th>Patient Name</th>");
				}

				if (hasType) {
					out.println("<th>Test Type</th>");
				}

				out.println("<th>Test Date</th>");
				out.println("<th>Image Count</th>");
		   		out.println("</tr>");					
					
	    		while(rset.next()) {
					out.println("<tr>");
					if (hasPatient) {
						out.println("<td>"); 
						out.println(rset.getString("person_id")); 
						out.println("</td>");
						
						out.println("<td>"); 
						if(rset.getString("person_id") != null) {
							Statement getPName = m_con.createStatement();
							ResultSet rset2 = getPName.executeQuery("Select (first_name || ' ' || last_name) patient_name from persons where person_id =" + rset.getInt("person_id"));
						
							rset2.next();
							
							out.println(rset2.getString("patient_name"));
							
						} else {
							out.println("null");
						}
						out.println("</td>");						
					}
					if (hasType) {
						out.println("<td>"); 
						out.println(rset.getString("test_type")); 
						out.println("</td>");
					}
					out.println("<td>"); 
					out.println(rset.getString("test_date")); 
					out.println("</td>");
					out.println("<td>");
					out.println(rset.getObject("image_count"));
					out.println("</td>");				
					out.println("</tr>");
				}
				out.println("</table>");
			}

		%>
	
    </BODY> 
</HTML> 
