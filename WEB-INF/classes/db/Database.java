package db;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class Database{
	static final String username = "thornhil";
	static final String password = "cmput391";
	
	Connection conn = null;

	public Database(){
		String driverName = "oracle.jdbc.driver.OracleDriver";
		// Use this dbstring to connect to the campus databases from home
		//String dbstring = "jdbc:oracle:thin:@localhost:1525:CRS";
		
		// Use this string on campus
		String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		System.out.println("Attempting to connect to db:");
		try{
			// load and register the driver
			Class<?> drvClass = Class.forName(driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
			conn = DriverManager.getConnection(dbstring, username, password);
		} catch (Exception e){
			System.out.println("DB Connection Error: " + e.getMessage());
		}
	}

	public Connection getConnection(){
		return conn;
	}
	
	public void close(){
		try{
			conn.close();
		} catch (SQLException e){
			e.printStackTrace();
		}
	}
}