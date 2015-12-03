<%
	if ((request.getParameter("action") != null) && (request.getParameter("action").trim().equals("logout"))) {
		session.putValue("login", "");
		response.sendRedirect("/");
		return;
	}
	String username = request.getParameter("loginUser");
	String userpasswd = request.getParameter("loginPassword");
	String mysJDBCDriver = "com.mysql.jdbc.Driver";
	String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng";
	String mysUserID = "asfeng";
	String mysPassword = "108685053";

	session.putValue("login", "");
	if ((username != null) && (userpasswd != null)) {
		if (username.trim().equals("") || userpasswd.trim().equals("")) {
			response.sendRedirect("index.htm");
		} else {
			// code start here
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
				// First see if user is an employee, then a customer.

				String query = "SELECT P.SSN, E.isManager FROM Person P, Employee E WHERE P.SSN=? and P.Passwd=SHA(?) and P.SSN = E.EmployeeID";
				java.sql.PreparedStatement ps = conn.prepareStatement(query);
				// ESCAPE
				username = username.replace("'", "''");
				userpasswd = userpasswd.replace("'", "''");
				ps.setString(1, username);
				ps.setString(2, userpasswd);
				//ps.setString(3,username);
				java.sql.ResultSet rs = ps.executeQuery();

				if (rs.next()) {
					// login success - Employee
					session.putValue("login", username);
					System.out.println("Employee login: isManager: " + rs.getBoolean("isManager"));
					if (rs.getBoolean("IsManager"))
						response.sendRedirect("ManagerHome.jsp");
					else
						response.sendRedirect("CustomerRepHome.jsp");
				} else {
					query = "SELECT P.SSN FROM Person P, Customer C WHERE P.SSN=? and P.Passwd=SHA(?) AND P.SSN = C.CustomerID";
					ps = conn.prepareStatement(query);
					// ESCAPE
					username = username.replace("'", "''");
					userpasswd = userpasswd.replace("'", "''");
					ps.setString(1, username);
					ps.setString(2, userpasswd);
					//ps.setString(3,username);
					rs = ps.executeQuery();
					if (rs.next()) {
						session.putValue("login", username);
						response.sendRedirect("CustomerHome.jsp");
					} else {
						// username or password mistake
						response.sendRedirect("passMistake.htm");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					conn.close();
				} catch (Exception ee) {
				};
			}
		}
	}
%>