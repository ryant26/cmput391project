import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Database;

/**
* Servlet that handles the posting of infor from the usermanagement 
* area.
*/
public class SubmitData extends HttpServlet{

	HttpServletResponse response;

	 public void doPost(HttpServletRequest request, HttpServletResponse response) 
	 throws ServletException, IOException{
	 	if (!request.getSession().getAttribute("class").equals("a")){
	 		sendFailure("Only admins can use this page");
	 	}
	 	this.response = response;
	 	response.setContentType("text/html");

	 	String value = request.getParameter("value");
	 	String pk = request.getParameter("pk");
	 	String name = request.getParameter("name");
	 	System.out.println("DEBUG received values: " + pk + " " + name + " " + value);
	 	if (name.equals("username")){
	 		handleUsername(pk, value);
	 	} else if (name.equals("password")) {
	 		handlePassword(pk, value);
	 	} else if (name.equals("date")){
	 		handleDateRegistered(pk, value);
	 	} else if (name.equals("class")) {
	 		handleClass(pk, value);
	 	} else if (name.equals("firstname")){
	 		handleFristName(pk, value);
	 	} else if (name.equals("lastname")){
	 		handleLastName(pk, value);
	 	} else if (name.equals("address")){
	 		handleAddress(pk, value);
	 	} else if (name.equals("email")){
	 		handleEmail(pk, value);
	 	} else if (name.equals("phone")) {
	 		handlePhone(pk, value);
	 	} else if (name.equals("doctorid")){
	 		String [] pks = pk.split("\\.");
	 		handleDocID(pks[0], pks[1], value);
	 	} else if (name.equals("patientid")){
	 		String [] pks = pk.split("\\.");
	 		handlePatientID(pks[0], pks[1], value);
	 	} else {
	 		sendFailure("value not understood");
	 	}
	}

	private void handleUsername(String pk, String value){
		String query = buildUsersQuery("user_name", value, pk);
		if (noSpaces(value)){
			runQuery(query);
		} else {
			sendFailure("No spaces allowed!");
		}
	}

	private void handlePassword(String pk, String value){
		String query = buildUsersQuery("password", value, pk);
		if (noSpaces(value)){
			runQuery(query);
		} else {
			sendFailure("No spaces allowed!");
		}
	}

	private void handleDateRegistered(String pk, String value){
		String query = "UPDATE users SET date_registered = to_date('" + value +"', 'YYYY-MM-DD') where user_name = " + pk;
		runQuery(query);
	}

	private void handleClass(String pk, String value){
		String query = buildUsersQuery("class", value, pk);
		if (length(value, 1)){
			runQuery(query);
		} else {
			sendFailure("Must be 1 character");
		}
	}

	private void handleFristName(String pk, String value){
		updateName(buildPersonsQuery("first_name", value, pk), value);
	}

	private void handleLastName(String pk, String value){
		updateName(buildPersonsQuery("last_name", value, pk), value);
	}

	private void handleAddress(String pk, String value){
		String query = buildPersonsQuery("address", value, pk);
		if (length(value, 128)){
			runQuery(query);
		} else {
			sendFailure("Must be less than 128 chars");
		}
	}

	private void handleEmail(String pk, String value){
		String query = buildPersonsQuery("email", value, pk);
		if (value.contains("@") && value.contains(".")){
			if (length(value, 128)){
				runQuery(query);
			} else {
				sendFailure("Must be less than 128 chars");
			}
		} else {
			sendFailure("Not a valid email");
		}
	}

	private void handlePhone(String pk, String value){
		String query = buildPersonsQuery("phone", value, pk);
		if (numbersOnly(value)){
			runQuery(query);
		} else {
			sendFailure("Can only contain digits");
		}
	}

	private void handleDocID(String doc, String pat, String value){
		String query = buildFamilyDoctorQuery("doctor_id", value, doc, pat);
		if (numbersOnly(value)){
			runQuery(query);
		} else {
			sendFailure("only numbers allowed");
		}
	}

	private void handlePatientID(String doc, String pat, String value){
		String query = buildFamilyDoctorQuery("patient_id", value, doc, pat);
		if (numbersOnly(value)){
			runQuery(query);
		} else {
			sendFailure("Only numbers allowed");
		}
	}

	private void updateName(String query, String value){
		if (noSpaces(value)){
			if (length(value, 24)){
				runQuery(query);
			} else {
				sendFailure("Must be less than 24 chars");
			}
		} else {
			sendFailure("No spaces Allowed");
		}
	}

	private boolean noSpaces(String input){
		if(input.split(" ").length > 1){
			return false;
		}
		return true;
	}

	private boolean numbersOnly(String input){
		if (input.matches("^[\\d]+$")){
			return true;
		} else {
			return false;
		}
	}

	private boolean length(String input, int len){
		if (input.length() <= len){
			return true;
		} else {
			return false;
		}
	}

	private void runQuery(String query){
		Database db = new Database();
		System.out.println("DEBUG, query string: " + query);
		try{
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet results = stmt.executeQuery(query);
			sendOK();
		} catch (Exception e){
			System.out.println("Error updating data: " + e.getMessage());
			sendFailure("That input is not correct");
		} finally {
			db.close();
		}
	}

	private String buildUsersQuery(String field, String value, String pk){
		return buildQuery("users", field, value, "user_name", pk);
	}

	private String buildPersonsQuery(String field, String value, String pk){
		return buildQuery("persons", field, value, "person_id", pk);
	}

	private String buildFamilyDoctorQuery(String field, String value, String doc, String pat){
		return "UPDATE family_doctor SET "+ field +"= '" + value + "' where doctor_id  = " + doc + " AND patient_id = " + pat;
	}

	private String buildQuery(String table, String field, String value, String pk, String pk_value){
		return "UPDATE "+ table +" SET "+ field +"= '" + value + "' where "+ pk +" = " + pk_value;
	}

	private void sendOK(){
		try{
	 		response.sendError(HttpServletResponse.SC_OK);
	 	} catch (IOException e){
	 		System.out.println("Error sending repsonse: " + e.getMessage());
	 	}
	}

	private void sendFailure(String msg){
		try{
	 		response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
 			response.getWriter().print(msg);
	 	} catch (IOException e){
	 		System.out.println("Error sending repsonse: " + e.getMessage());
	 	}
	}

}  