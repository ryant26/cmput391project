<%@ page import="java.sql.*, java.util.*, db.Database" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head> 
<title>Uploading Module</title> 
</head>
<body>
	<p>Uploading Module</p>
	
	<%
	//only radiologist can use
	/*try{
		if (!(((String) session.getAttribute("class")).equals("r"))){
			throw new Exception();
		}
	} catch (Exception e){
		response.sendError(HttpServletResponse.SC_FORBIDDEN);
	}*/
	%>

	<%
  		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
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
		} 

		//use this for final submission
		//Database db = new Database();
		//m_con = db.getConnection();
          
	%>
	<form name=queryData method=post action=imageUpload.jsp> 
		<table>
			<tr>
	  			<tr>
					<td>Enter Radiology Record ID: </td>
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
