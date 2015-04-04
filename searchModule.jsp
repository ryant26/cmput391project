<%@ page import="java.sql.*, java.util.*, db.Database" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1250">
	<title>Search</title>
	</head>
	<body>
    	<p>Search Module</p>
    <%
  		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";
      
		String m_userName = "aayao"; //supply username
		String m_password = "FGThjklzEX_16"; //supply password

		Connection m_con;
		String selectString = "select radiology_record.record_id, (first_name || ' ' || last_name) patient_name, doctor_id, radiologist_id, test_type, prescribing_date, test_date, diagnosis, description from radiology_record join persons on person_id = patient_id";

		Statement stmt;
      
		try {
      
			Class drvClass = Class.forName(m_driverName);
			DriverManager.registerDriver((Driver)
			drvClass.newInstance());
			m_con = DriverManager.getConnection(m_url, m_userName, m_password);
        
		} catch(Exception e) {      
			out.print("Error displaying data: ");
			out.println(e.getMessage());
			return;
		}

		//use this for final submission
		//Database db = new Database();
		//m_con = db.getConnection();

		try {
			stmt = m_con.createStatement();
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
						out.println("<a href=\"/proj1/GetOnePic?regular" + image_id + "\" target=" + "_blank" + ">");
						// display the thumbnail
						out.println("<img src=\"/proj1/GetOnePic?thumbnail" + image_id + "\"></a>");
					}
					out.println("</td>");
					rset_images.close();
				
				} catch (Exception e) {
					out.println(e.getMessage());
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
    
	<table>
		<tr>
  			<tr>
				<td>Keyword</td>
				<td>
					<input type=text name=keyword>
				</td>
			</tr>
			<tr>
				<td>Start Date (YYYY-MM-DD)</td>
				<td>
					<input type=text name=startdate>
				</td>
				<td>End Date (YYYY-MM-DD)</td>
				<td>
					<input type=text name=enddate>
				</td>
			</tr>
			<tr>
				<td>Order by date?</td>
				<td>
					<input type="checkbox" name="order" value="Y">
				</td>
			</tr>
			<td>
				<input type=submit value="Search" name="search">
			</td>
		</tr>
	</table>
      
	<%
		if (request.getParameter("search") != null) {
			Statement doSearch;
			String startdate, enddate, keyword;
			boolean hasDate = false;
			boolean hasKeyword = false;
		
			//default search string
			String searchStr1 = "SELECT ";
			String searchStr2 = "diagnosis, description, (first_name || ' ' || last_name) patient_name, test_date, record_id FROM radiology_record join persons on person_id = patient_id WHERE ";
			String searchStr3 = " order by rank desc";
          	
			//d for doctor, p for patient?
			/*if ((((String) session.getAttribute("class")).equals("d"))){
				searchStr2 += session.getAttribute("person_id") + "= doctor_id, ";
			} else if ((((String) session.getAttribute("class")).equals("p"))) {
				searchStr2 += session.getAttribute("person_id") + "= patient_id, ";
			}*/	


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
				out.println("<table border=1>");
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
