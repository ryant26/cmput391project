<%@ page import="java.sql.*, java.util.*, db.Database" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Login Screen for Radiology Project">
    <meta name="author" content=" Ryan Thornhill">
    <link rel="icon" href="../../favicon.ico">

    <title>Search</title>

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
      <h1>Search Module</h1>
    </div>
    </head>
	<body>

    <%
		String selectString = "select radiology_record.record_id, (first_name || ' ' || last_name) patient_name, doctor_id, radiologist_id, test_type, prescribing_date, test_date, diagnosis, description from radiology_record join persons on person_id = patient_id";

		//use this for final submission
		Database db = new Database();
		Connection m_con = db.getConnection();

		try {
			Statement stmt = m_con.createStatement();
			ResultSet rset = stmt.executeQuery(selectString);

			//test code below
			/*out.println("<table border=1>");
			out.println("<tr>");
			out.println("<th>Record_ID</th>");
			out.println("<th>Patient Name</th>");
			out.println("<th>Doctor_ID</th>");
			out.println("<th>Radiologist_ID</th>");
			out.println("<th>Test Type</th>");
			out.println("<th>Prescribe Date</th>");
			out.println("<th>Test Date</th>");
			out.println("<th>Diagnosis</th>");
			out.println("<th>Description</th>");
			out.println("<th>Images</th>");
			out.println("</tr>"); 
			while(rset.next()) { 

				out.println("<tr>");
				out.println("<td>"); 
				out.println(rset.getString("record_id"));
				out.println("</td>");
				out.println("<td>"); 
				out.println(rset.getString("patient_name")); 
				out.println("</td>");
				out.println("<td>"); 
				out.println(rset.getString("doctor_id")); 
				out.println("</td>");
				out.println("<td>"); 
				out.println(rset.getString("radiologist_id")); 
				out.println("</td>");
				out.println("<td>"); 
				out.println(rset.getString("test_type")); 
				out.println("</td>");
				out.println("<td>"); 
				out.println(rset.getString("prescribing_date")); 
				out.println("</td>");
				out.println("<td>"); 
				out.println(rset.getString("test_date")); 
				out.println("</td>");
				out.println("<td>"); 
				out.println(rset.getString("diagnosis")); 
				out.println("</td>");
				out.println("<td>"); 
				out.println(rset.getString("description")); 
				out.println("</td>");
				// Get the thumbnail images
				try {
					String sql_images = "select image_id from pacs_images where record_id = " + rset.getObject("record_id");
					Statement stmt_images = m_con.createStatement();
				 	ResultSet rset_images = stmt_images.executeQuery(sql_images);
					String image_id;

					out.println("<td>");
					while (rset_images != null && rset_images.next()) {
						image_id = (rset_images.getObject(1)).toString();
						// specify the servlet when thumbnail is clicked
						out.println("<a href=\"/cmput391project/GetOnePic?regular" + image_id + "\" target=" + "_blank" + ">");
						// display the thumbnail
						out.println("<img src=\"/cmput391project1/GetOnePic?thumbnail" + image_id + "\"></a>");
					}
					out.println("</td>");
					rset_images.close();
				
				} catch (Exception e) {
					out.println(e.getMessage());
				} finally {
					db.close();
				}
				out.println("</tr>"); 
        	} 
			out.println("</table>");
        	*/stmt.close();     
          
	%>

    <form name=queryData method=post action=searchModule.jsp> 

      <!--Every time you add or update data you need to update the index. <br>
      <input type=submit name="updateIndex" value="Update Index">
    	<br>
    	<br>
    	<br>
    -->
    
	
	<div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">Search Area</h3>
      </div>
      <div class="panel-body">
        <form class="form-search form-inline">
            <div class="form-group">
                <input type="text" id="diagnosis" name="keyword" class="form-control diagnosis-field" placeholder="Keyword">
            </div>
            <div class="form-group">
                <label for="start-date">Start:</label>
                <input type="date" id="start-date" name="startdate" class="form-control date-field" placeholder="Start Date">
            </div>
            <div class="form-group">
                <label for="end-date">End:</label>
                <input type="date" id="end-date" name="enddate" class="form-control date-field" placeholder="Start Date">
            </div>
             <div class="checkbox">
				<label>
				  <input type="checkbox" name="order" value="Y"> Order By Date
				</label>
			</div>
            <button name="search" type="submit" value="Search" class="btn btn-primary">Search</button>
        </form>
      </div>
    </div>
      
	<%
		if (request.getParameter("search") != null) {
			Statement doSearch;
			String startdate, enddate, keyword;
			boolean hasDate = false;
			boolean hasKeyword = false;
			boolean hasSecurity = false;
		
			//default search string
			String searchStr1 = "SELECT ";
			String searchStr2 = "diagnosis, description, (first_name || ' ' || last_name) patient_name, test_date, record_id FROM radiology_record join persons on person_id = patient_id WHERE ";
			String searchStr3 = " order by rank desc";

			if(!((startdate = request.getParameter("startdate")).equals(""))) {
		  		out.println("<br>");
      	  		out.println("Start Date: " + startdate);
      	  		out.println("<br>");
		  		hasDate = true;
			} else {
		  		startdate = "0000-01-01";
			}

			if(!((enddate = request.getParameter("enddate")).equals(""))) {
		  		out.println("<br>");
      	  		out.println("End Date: " + enddate);
      	  		out.println("<br>");
		 		hasDate = true;
			} else {
		  		enddate = "9999-12-30";
			}
			
            if(!((keyword = request.getParameter("keyword")).equals(""))) {
		  		out.println("<br>");
      	  		out.println("Searching for keyword(s): " + keyword);
      	 		out.println("<br>");
		  		hasKeyword = true;		  
            }

			if ((((String) session.getAttribute("class")).equals("d"))){
				hasSecurity = true;
				searchStr2 += "doctor_id = " + session.getAttribute("p_id");
				if (hasKeyword) {
					searchStr2 += " and (";
				}
			} else if ((((String) session.getAttribute("class")).equals("p"))) {
				hasSecurity = true;
				searchStr2 += "patient_id = " + session.getAttribute("p_id");
				if (hasKeyword) {
					searchStr2 += " and (";
				}
			} else if ((((String) session.getAttribute("class")).equals("r"))) {
				hasSecurity = true;
				searchStr2 += "radiologist_id = " + session.getAttribute("p_id");
				if (hasKeyword) {
					searchStr2 += " and (";
				}
			}

			if (hasDate) {
				searchStr2 += "to_char(test_date, 'YYYY-MM-DD') >= '" + startdate + "' and to_char(test_date, 'YYYY-MM-DD') <= '" + enddate + "'";
				if (hasKeyword) {
					searchStr2 += " and (";
				}
			}

			if (hasKeyword) {
				String[] wordList = keyword.split(" ");	
				int word = 0;
				searchStr1 += "(";
				for (int i = 0; i < wordList.length; i++) {
					searchStr1 += "score(" + Integer.toString(word + 1)	+ ") + score(" + (word + 2) + ")*3+score(" + (word + 3) + ")*6 +score(" + (word + 4)	+ ")*6";
					searchStr2 += "contains(description,'" + "%" + wordList[i]+ "%" +"', " + (word + 1) + ") > 0 or contains(diagnosis,'" + "%" +wordList[i]+ "%" +"',"+ (word + 2) +") > 0 or contains(first_name,'" + "%" + wordList[i] + "%" +"', "+ (word + 3) +") > 0 or contains(last_name,'" + "%" + wordList[i] + "%" + "', "+ (word + 4) +") > 0";

					if (i != wordList.length - 1) {
						searchStr1 += "+ ";
						searchStr2 += " or ";
					}

					word += 4;
				}

				searchStr1 += ")rank, ";
				if (hasSecurity) {
					searchStr2 += ") ";
				}
				if (hasDate) {
					searchStr2 += ") ";
				}
			} else {
				searchStr1 += "(0) rank, ";
			}

			//out.println(searchStr1);		
			//out.println("<br>"+searchStr2);
			
			if (request.getParameter("order")!= null) {
				searchStr3 = " order by test_date, rank";
			}

			if (hasKeyword || hasDate) {
				//TODO: need to do some sort of security check
				
				doSearch = m_con.createStatement();
    			ResultSet rset2 = doSearch.executeQuery(searchStr1 + searchStr2 + searchStr3);
				out.println("<table class = \"table table-bordered\">");
				out.println("<tr>");
				out.println("<th>Patient Name</th>");
				out.println("<th>Diagnosis</th>");
				out.println("<th>Description</th>");
				out.println("<th>Test Date</th>");
				out.println("<th>Rank</th>");
				out.println("<th>Images</th>");
		   		out.println("</tr>");
        		while(rset2.next()) {
					out.println("<tr>");
					out.println("<td>"); 
					out.println(rset2.getString("patient_name"));
					out.println("</td>");
					out.println("<td>"); 
					out.println(rset2.getString("diagnosis"));
					out.println("</td>");
					out.println("<td>"); 
					out.println(rset2.getString("description")); 
					out.println("</td>");
					out.println("<td>"); 
					out.println(rset2.getString("test_date")); 
					out.println("</td>");
					out.println("<td>");
					out.println(rset2.getObject("rank"));
					out.println("</td>");
					
					// Get the thumbnail images
					try {
						String sql_images = "select image_id from pacs_images where record_id = " + rset2.getObject("record_id");
						Statement stmt_images = m_con.createStatement();
					 	ResultSet rset_images = stmt_images.executeQuery(sql_images);
						String image_id;

						out.println("<td>");
						while (rset_images != null && rset_images.next()) {
							image_id = (rset_images.getObject(1)).toString();
							// specify the servlet when thumbnail is clicked
							out.println("<a href=\"/cmput391project/GetOnePic?regular" + image_id + "\" target=" + "_blank" + ">");
							// display the thumbnail
							out.println("<img src=\"/cmput391project/GetOnePic?thumbnail" + image_id + "\"></a>");
						}
						out.println("</td>");
						rset_images.close();

					} catch (Exception e) {
						out.println(e.getMessage());
					}
				
					out.println("</tr>");
				} 
				out.println("</table>");
			} 
			} else {
			  out.println("<br><b>Please enter search conditions</b>");
			}          
          
          m_con.close();
        } catch(SQLException e) {
          out.println("SQLException: " + e.getMessage());
		  m_con.rollback();
        }
      %>
    </form>
  </body>
</html>
