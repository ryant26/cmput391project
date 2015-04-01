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
	}

	private void handleClass(String pk, String value){
		String query = buildUsersQuery("class", value, pk);
		if (length(value, 1)){
			runQuery(query);
		} else {
			sendFailure("Must be 1 character");
		}
	}

	private boolean noSpaces(String input){
		if(input.split(" ").length > 1){
			return false;
		}
		return true;
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
		return buildQuery("users", field, value, "person_id", pk);
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