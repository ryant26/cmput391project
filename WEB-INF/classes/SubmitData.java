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
	 public void doPost(HttpServletRequest request, HttpServletResponse response) 
	 throws ServletException, IOException{
	 	String data = request.getParameter("value");
	 	System.out.println("Received Data: \n" + data);
	 	response.sendError(HttpServletResponse.SC_OK);
	}
}  