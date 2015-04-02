<%@ page import="java.sql.*, java.util.*, db.Database" %>
<HTML>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=windows-1250">
  		<title>OLAP</title>
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

	<form name=queryData method=post action=OLAP.jsp> 
		<table>
			<p> Data Analysis Module
				<br>
				Display # of images for: 
			</p>
			<tr>
	  			<tr>
					<td>Patient</td>
					<td>
						<input type="checkbox" name="patient" value="Y">
					</td>
					<td>Test Type</td>
					<td>
						<input type="checkbox" name="testtype" value="Y">
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
					<td>Time Block</td>
					<td><input type="radio" name="timeHeir" value="1" checked> Weekly</td>
					<td><input type="radio" name="timeHeir" value="2"> Monthly</td>
					<td><input type="radio" name="timeHeir" value="3"> Yearly</td>
				</tr>	
				<td>
					<input type=submit value="Submit" name="OLAP">
				</td>
			</tr>
		</table>
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
					OLAPStr1 += "p.person_id, (p.first_name || ' ' || p.last_name) patient_name, ";
					OLAPStr3 += "p.person_id, (p.first_name || ' ' || p.last_name), ";
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
				
				out.println("<br>" + OLAPStr1 + OLAPStr2 + OLAPStr3);

				doOLAP = m_con.createStatement();
				ResultSet rset = doOLAP.executeQuery(OLAPStr1 + OLAPStr2 + OLAPStr3);

				out.println("<table border=1>");
				out.println("<tr>");

				if (hasPatient) {
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
						out.println(rset.getString("patient_name"));
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
	</form>
    </BODY> 
</HTML> 
