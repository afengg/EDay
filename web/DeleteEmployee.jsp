<%

	String EmployeeID = request.getParameter("EmployeeID");
	
	String mysJDBCDriver = "com.mysql.jdbc.Driver";
	String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng";
	String mysUserID = "asfeng";
	String mysPassword = "108685053";
	java.sql.Connection conn = null;
	try {
		Class.forName(mysJDBCDriver).newInstance();
		java.util.Properties sysprops = System.getProperties();
		sysprops.put("user", mysUserID);
		sysprops.put("password", mysPassword);

		//connect to the database
		conn = java.sql.DriverManager.getConnection(mysURL, sysprops);
		System.out.println("Connected successfully to database using JConnect");

		conn.setAutoCommit(false);
		java.sql.Statement stmt1 = conn.createStatement();
		String query = "DELETE FROM Employee WHERE EmployeeID = ?";
		java.sql.PreparedStatement ps = conn.prepareStatement(query);
		ps.setString(1, EmployeeID);
		
		ps.executeUpdate();
		conn.commit();
		String query2 = "DELETE FROM Person WHERE SSN = ?";
                ps = conn.prepareStatement(query2);
		ps.setString(1, EmployeeID);
		ps.executeUpdate();
		conn.commit();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			conn.close();
		} catch (Exception ee) {
		};
	}
        response.sendRedirect("EmployeeManagement.jsp");

%>