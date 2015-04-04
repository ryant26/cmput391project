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
  		//use this for final submission
		Database db = new Database();
		Connection m_con = db.getConnection();
          
	%>

	<div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Create new Radiology Record: </h3>
          </div>
          <div class="panel-body">
            <form name=queryData method=post action=imageUpload.jsp class="form-search form-horizontal">
                <div class="form-group form-inline">
                    <input type="text" id="newrec_id" name="newrec_id" class="form-control newrec-field" placeholder="Record ID" required autofocus>
                    <input type="text" id="pat_id" name="pat_id" class="form-control patient-field" placeholder="Patient ID" required autofocus>
                    <input type="text" id="pat_id" name="doc_id" class="form-control doctor-field" placeholder="Doctor ID" required autofocus>
                </div>
				<div class="form-group">
                    <input type="text" id="testtype" name="type" class="form-control type-field" placeholder="Test Type" required autofocus>
                </div>
                <div class="form-group form-inline">
                    <label for="pres-date">Prescribe Date:</label>
                    <input type="date" id="start-date" name="presdate" class="form-control date-field" placeholder="Start Date" required autofocus>

                    <label for="test-date">Test Date:</label>
                    <input type="date" id="end-date" name="testdate" class="form-control date-field" placeholder="Start Date" required autofocus>
                </div>
				 </div>
				<div class="form-group">
                    <input type="text" id="diag" name="diag" class="form-control diag-field" placeholder="Diagnosis" required autofocus>
                </div>
				<div class="form-group">
                    <input type="text" id="desc" name="desc" class="form-control desc-field" placeholder="Description" required autofocus>
                </div>

                <button name="newRadioRec" type="submit" class="btn btn-primary">Submit</button>
            </form>
			<form name=queryData method=post action=imageUpload.jsp class="form-search form-horizontal">

          </div>
        </div>

	<div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">Enter Existing Radiology Record: </h3>
      </div>
      <div class="panel-body">
	<form name=queryData2 method=post action=imageUpload.jsp> 
		<div class="form-group form-inline">
            <input type="text" id="rec_id" name="rec_id" class="form-control rec-field" placeholder="Record ID" required autofocus>
        </div>
		<button name="radioRec" type="submit" class="btn btn-primary">Submit</button>
	</form>
	</div>
	</div>
		<%
			if (request.getParameter("radioRec") != null || request.getParameter("newRadioRec") != null) {
				Statement doRRec;
				String rec_id = request.getParameter("rec_id");

				if (request.getParameter("newRadioRec") != null) {
					String newRRec = "insert into radiology_record values (" + request.getParameter("newrec_id") + "," + request.getParameter("pat_id") + "," + request.getParameter("doc_id") + "," + session.getAttribute("p_id") + ", '" + request.getParameter("type") + " ', to_date( '" + request.getParameter("presdate") + " ', 'MM/DD/YYYY ') ,to_date( '" + request.getParameter("testdate") + " ', 'MM/DD/YYYY '), '" + request.getParameter("diag") + " ', '" + request.getParameter("desc") + " ')";

					Statement doNewRRec = m_con.createStatement();
					doNewRRec.executeQuery(newRRec);

					out.println(newRRec);
					rec_id = request.getParameter("newrec_id");
				}

				if (!(rec_id.equals(""))) { 
					String RRecStr1 = "SELECT record_id from radiology_record where record_id = " + rec_id;
				
					doRRec = m_con.createStatement();
					ResultSet rset = doRRec.executeQuery(RRecStr1);

					if (rset.next()) {
		%>
					 	<br>Radiology Record ID: 
						<%out.println(rset.getInt("record_id"));%>
						<br>Please input or select the path of the image.  

						<form name= "upload-image" method= "POST" enctype= "multipart/form-data" action="UploadImage">
						<table>
						<%out.println("<td><input name=\"rec_id\" type=\"hidden\" value=\"" + rec_id + "\" ></td>");%>
						<div class="form-group">
							<input type="file" id="exampleInputFile" name= "file-path" type= "file" size= "30">
						</div>
						
						<tr>
						<td>
						<button name=".submit" type="submit" class="btn btn-primary">Upload</button>
						</td>
						</tr>
						</table>
						</form>
		<%			} else {
						 out.println("<br>Invalid Radiology Record.");
					}
				} 
			}	else {
					 out.println("<br>Please enter a radiology record ID to begin image upload.");
			}
		%>
</body> 
</html>
