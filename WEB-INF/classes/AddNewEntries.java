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

public class AddNewEntries extends HttpServlet{
	HttpServletResponse response;
	HttpServletRequest request;

	public void doPost(HttpServletRequest request, HttpServletResponse response) 
	 throws ServletException, IOException{
	 	this.response = response;
	 	this.request = request;
	 	String type = request.getParameter("type");
	 	if (type.equals("user")){
	 		handleUserInsert();
	 	} else if (type.equals("person")) {
	 		handlePersonInsert();
	 	} else if (type.equals("family_doctor")){
	 		handleFamilyDoctorInsert();
	 	} else {
	 		sendFailure("Invalid Request");
	 	}
	 }

	private void handleUserInsert(){
		try{
			String personid = request.getParameter("personid");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String date = request.getParameter("date");
			String pclass = request.getParameter("pclass");

			System.out.println("User Insert: " + personid + " " + username + 
				" " + password + " " + date + " " + pclass);
 
			if (!validateCredentials(username, "Username", 24) ||
				!validateCredentials(password, "Password", 24)){
				return;
			}


			String query ="INSERT INTO users values('" +
				username +"', '" +
				password +"', '" +
				pclass +"', " +
				personid +", " +
				"to_date('" + date +"', 'YYYY-MM-DD'))";
			
			System.out.println("Attempted query: " + query);

			if (length(pclass, 1)){
				if (numbersOnly(personid)){
					runQuery(query);
				} else {
				sendFailure("person id can only contain numbers");
				}
			} else {
				sendFailure("Class must be a single character");
			}
		} catch (Exception e){
			sendFailure("Invalid input");
		}
	}

	private void handlePersonInsert(){
		try{
			String personid = request.getParameter("personid");
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			String address = request.getParameter("address");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");

			System.out.println("Person Insert: " + personid + " " + firstname + 
				" " + lastname + " " + address + " " + email + " " + phone);

			String query = "INSERT INTO persons values(" +
				personid + ", '" +
				firstname + "', '" +
				lastname + "', '" +
				address + "', '" +
				email + "', '" +
				phone + "')";
			
			System.out.println("Attempted query: " + query);

			if (!validateCredentials(firstname, "First Name", 24)){
				return;
			}
			if (!validateCredentials(lastname, "Last Name", 24)){
				return;
			}

			if (!length(address, 128)){
				sendFailure("Address must be less than 128 chars");
				return;
			}

			if (!validateEmail(email)){
				return;
			}

			if (!numbersOnly(phone)){
				sendFailure("PHone number must contain only numbers");
			} else {
				runQuery(query);
			}
		} catch (Exception e){
			sendFailure("Invalid input");
		}
	}

	private void handleFamilyDoctorInsert(){
		try{
			String doctorid = request.getParameter("doctorid");
			String patientid = request.getParameter("patientid");

			String query = "INSERT INTO family_doctor values(" +
				doctorid + ", " +
				patientid + ")";

			if (!numbersOnly(doctorid) || !numbersOnly(patientid)){
				sendFailure("Must only contain numbers");
			} else {
				runQuery(query);
			}

		} catch (Exception e){
			sendFailure("Invalid input");
		}
	}

	private boolean validateCredentials(String value, String name, int len){
		if (noSpaces(value)){
				if (length(value, len)){
					return true;
				} else {
					sendFailure( name +" must be 24 char or less");
					return false;
				} 
		} else {
			sendFailure( name +" cannot contain spaces");
			return false;
		}
	}

	private boolean validateEmail(String value){
		if (value.contains("@") && value.contains(".")){
			if (length(value, 128)){
				return true;
			} else {
				sendFailure("Must be less than 128 chars");
				return false;
			}
		} else {
			sendFailure("Not a valid email");
			return false;
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

	private void sendOK(){
		try{
	 		response.setStatus(HttpServletResponse.SC_OK);
 			response.getWriter().print("Addition Successful");
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