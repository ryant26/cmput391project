<%@ page import="java.sql.*, java.util.*, db.Database" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Login Screen for Radiology Project">
    <meta name="author" content=" Ryan Thornhill">
    <link rel="icon" href="../../favicon.ico">

    <title>Upload Image</title>

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
      <h1>Uploading Module</h1>
    </div>
    </head>
<body>
	
	<%
	//only radiologist can use
	try{
		if (!(((String) session.getAttribute("class")).equals("r"))){
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
	<form name=queryData method=post action=imageUpload.jsp> 
		Create new Radiology Record: 
		<table>
			
			<tr>
				
					<tr>
					<td>Record ID: </td>					
					<td>
						<input type=text name=rec_id>
					</td>
					<td>Patient ID: </td>
					<td>
						<input type=text name=pat_id>
					</td>
					<td>Doctor ID: </td>
					<td>
						<input type=text name=doc_id>
					</td>
					</tr>

					<tr>
					<td>Test Type: </td>
					<td>
						<input type=text name=type_id>
					</td>
					<td>Prescribing Date: </td>
					<td>
						
						<input type=text name=presdate>
					</td>
					<td>Test Date: </td>
					<td>
						
						<input type=text name=presdate>
					</td>
					</tr>

					<td>Diagnosis: </td>
					<td>
						<input type=text name= diag>
					</td>
					<td>Description: </td>
					<td>
						<input type=text name=desc>
					</td>
	  			<tr>
				<br>
					<td>Enter Existing Radiology Record ID: </td>
					<td>
						<input type=text name=rec_id>
					</td>
				</tr>
					<td>
						<input type=submit value="Submit" name="radioRec">
					</td>
				</tr>
		</table>
	</form>
		<%
			if (request.getParameter("radioRec") != null) {
				Statement doRRec;
				String rec_id;

				if (!(rec_id=request.getParameter("rec_id")).equals("")) { 
					String RRecStr1 = "SELECT record_id from radiology_record where record_id = " + rec_id;
				
					doRRec = m_con.createStatement();
					ResultSet rset = doRRec.executeQuery(RRecStr1);

					if (rset.next()) {
						out.println("<br>Radiology Record ID: ");
						out.println(rset.getInt("record_id"));
						out.println("<br>Please input or select the path of the image.");

						out.println("<form name=\"upload-image\" method=\"POST\" enctype=\"multipart/form-data\" action=\"UploadImage\">");
						out.println("<table>");
						out.println("<tr>");
						out.println("<th>File path: </th>");
						out.println("<td><input name=\"rec_id\" type=\"hidden\" value=\""+rec_id+"\" ></td>");
						out.println("<td><input name=\"file-path\" type=\"file\" size=\"30\" ></td>");
						out.println("</tr>");
						out.println("<tr>");
						out.println("<td ALIGN=CENTER COLSPAN=\"2\"><input type=\"submit\" name=\".submit\" value=\"Upload\"></td>");
						out.println("</tr>");
						out.println("</table>");
						out.println("</form>");
					} else {
						out.println("<br>Invalid Radiology Record.");
					}
				} 
			}	else {
					out.println("<br>Please enter a radiology record ID to begin image upload.");
			}
		%>
</body> 
</html>
