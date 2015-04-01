<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1250">
	<title>Search</title>
	</head>
	<body>
    
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

		try {
			stmt = m_con.createStatement();
			ResultSet rset = stmt.executeQuery(selectString);
			out.println("<table border=1>");
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
        	stmt.close();     
          
	%>

    <form name=queryData method=post action=testSearch.jsp> 

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
			<td>
				<input type=submit value="Search" name="search">
			</td>
		</tr>
	</table>
      
	<%
		if (request.getParameter("search") != null) {
			PreparedStatement doSearch;
			String startdate, enddate, keyword;
			boolean hasDate = false;
			boolean hasKeyword = false;
		
			//default search string
			String searchStr = "SELECT score(1), score(2), score(3),score(4),(score(1) + score(2)*3 + score(3)*6 + score(4)*6)rank,diagnosis, description, (first_name || ' ' || last_name) patient_name, test_date, record_id FROM radiology_record join persons on person_id = patient_id WHERE ";
          	
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
      	  		out.println("Searching for keyword: " + keyword);
      	 		out.println("<br>");	
		  		hasKeyword = true;		  
            }

			if (hasKeyword) {
		  		if (hasDate) {
					//TODO: need to do some sort of security check
					doSearch = m_con.prepareStatement(searchStr + "to_char(test_date, 'YYYY-MM-DD') >= ? and to_char(test_date, 'YYYY-MM-DD') <= ? and (contains(description, ?, 1) > 0 or contains(diagnosis, ?, 2) > 0 or contains(first_name, ?, 3) > 0 or contains(last_name, ?, 4) > 0) order by (score(1) + score(2)*3 + score(3)*6 + score(4)*6) desc");

        			doSearch.setString(1, startdate);
					doSearch.setString(2, enddate);
					doSearch.setString(3, "%" + keyword + "%");
					doSearch.setString(4, "%" + keyword + "%");
					doSearch.setString(5, "%" + keyword + "%");
					doSearch.setString(6, "%" + keyword + "%");

        			ResultSet rset2 = doSearch.executeQuery();
					out.println("<table border=1>");
					out.println("<tr>");
					out.println("<th>Patient Name</th>");
					out.println("<th>Diagnosis</th>");
					out.println("<th>Description</th>");
					out.println("<th>Test Date</th>");
					out.println("<th>Score1</th>");
					out.println("<th>Score2</th>");
					out.println("<th>Score3</th>");
					out.println("<th>Score4</th>");
					out.println("<th>Rank</th>");
			   		out.println("</tr>");
	        		while(rset2.next()) {
						out.println("<tr>");
						out.println("<td>"); 
						out.println(rset2.getString(8));
						out.println("</td>");
						out.println("<td>"); 
						out.println(rset2.getString(7));
						out.println("</td>");
						out.println("<td>"); 
						out.println(rset2.getString(6)); 
						out.println("</td>");
						out.println("<td>"); 
						out.println(rset2.getString(9)); 
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(1));
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(2));
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(3));
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(4));
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(5));
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
				} else {
					//TODO: need to do some sort of security check
					doSearch = m_con.prepareStatement(searchStr + "contains(description, ?, 1) > 0 or contains(diagnosis, ?, 2) > 0 or contains(first_name, ?, 3) > 0 or contains(last_name, ?, 4) > 0 order by score(1) + score(2)*3 + score(3)*6 + score(4)*6 desc");

					doSearch.setString(1, "%" + keyword + "%");
					doSearch.setString(2, "%" + keyword + "%");
					doSearch.setString(3, "%" + keyword + "%");
					doSearch.setString(4, "%" + keyword + "%");

					ResultSet rset2 = doSearch.executeQuery();
					out.println("<table border=1>");
					out.println("<tr>");
					out.println("<th>Patient Name</th>");
					out.println("<th>Diagnosis</th>");
					out.println("<th>Description</th>");
					out.println("<th>Test Date</th>");
					out.println("<th>Score1</th>");
					out.println("<th>Score2</th>");
					out.println("<th>Score3</th>");
					out.println("<th>Score4</th>");
					out.println("<th>Rank</th>");
					out.println("<th>Image</th>");
					out.println("</tr>");
					while(rset2.next()) {
						out.println("<tr>");
						out.println("<td>"); 
						out.println(rset2.getString(8));
						out.println("</td>");
						out.println("<td>"); 
						out.println(rset2.getString(7));
						out.println("</td>");
						out.println("<td>"); 
						out.println(rset2.getString(6)); 
						out.println("</td>");
						out.println("<td>"); 
						out.println(rset2.getString(9)); 
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(1));
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(2));
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(3));
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(4));
						out.println("</td>");
						out.println("<td>");
						out.println(rset2.getObject(5));
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
		  		}
			} else if (hasDate) {
			  //TODO: need to do some sort of security check
			  doSearch = m_con.prepareStatement("SELECT diagnosis, description, (first_name || ' ' || last_name) patient_name, test_date, record_id FROM radiology_record join persons on person_id = patient_id WHERE to_char(test_date, 'YYYY-MM-DD') >= ? and to_char(test_date, 'YYYY-MM-DD') <= ? order by test_date");

			  doSearch.setString(1, startdate);
			  doSearch.setString(2, enddate);

        	  ResultSet rset2 = doSearch.executeQuery();
        	  out.println("<table border=1>");
        	  out.println("<tr>");
          	  out.println("<th>Patient Name</th>");
          	  out.println("<th>Diagnosis</th>");
        	  out.println("<th>Description</th>");
        	  out.println("<th>Test Date</th>");
       		  out.println("</tr>");
	          while(rset2.next()) {
	            out.println("<tr>");
		  	    out.println("<td>"); 
	            out.println(rset2.getString(3));
	            out.println("</td>");
	            out.println("<td>"); 
	            out.println(rset2.getString(2));
	            out.println("</td>");
	            out.println("<td>"); 
	            out.println(rset2.getString(1)); 
	            out.println("</td>");
	            out.println("<td>"); 
	            out.println(rset2.getString(4));

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

			} else {
			  out.println("<br><b>Please enter search conditions</b>");
			}          
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
