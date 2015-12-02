<%
    if ((request.getParameter("action") != null) && (request.getParameter("action").trim().equals("logout"))) {
        session.putValue("login", "");
        response.sendRedirect("/");
        return;
    }
    String username = request.getParameter("registerUser");
    String userpasswd = request.getParameter("registerPassword");
    String email = request.getParameter("registerEmail");
    String fName = request.getParameter("registerFName");
    String lName = request.getParameter("registerLName");
    String address = request.getParameter("registerAddress");
    String zipcode = request.getParameter("registerZipCode");
    String state = request.getParameter("registerState");
    String city = request.getParameter("registerCity");
    String CCN = request.getParameter("registerCCN");
    String userType = request.getParameter("registerUserType");
    String hourlyRate = request.getParameter("registerHourlyRate");
    String telephone = request.getParameter("registerPhone");
    String mysJDBCDriver = "com.mysql.jdbc.Driver";
    String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng";
    //mysURL = "jdbc:mysql://localhost:3306/asfeng"; 
    String mysUserID = "asfeng";
    String mysPassword = "108685053";

    session.putValue("login", "");
    System.out.println(userType);
    System.out.println(hourlyRate);
    //throw new RuntimeException();
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
                String query = "INSERT INTO person(SSN, LastName, FirstName, Address, ZipCode, Telephone, Email, City, State, passwd) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, SHA(?))";
                java.sql.PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, lName);
                ps.setString(3, fName);
                ps.setString(4, address);
                ps.setString(5, zipcode);
                ps.setString(6, telephone);
                ps.setString(7, email);
                ps.setString(8, city);
                ps.setString(9, state);
                ps.setString(10, userpasswd);
                ps.executeUpdate();
                conn.commit();
				if (userType.contains("Customer Representative") ||userType.contains("Manager") ) {
					String query2 = "INSERT INTO employee(StartDate, HourlyRate, Level, EmployeeID, IsManager) VALUES (NOW(), ?, 1, ?, ?)";
					ps = conn.prepareStatement(query2);
					ps.setString(1, hourlyRate);
					ps.setString(2, username);
					ps.setString(3, userType.contains("Customer Representative") ? "0" : "1");
					ps.executeUpdate();
					conn.commit();
				} else {
					String query2 = "INSERT INTO customer(Rating, CreditCardNum, CustomerId) VALUES (0, ?, ?)";
					ps = conn.prepareStatement(query2);
					ps.setString(1, CCN);
					ps.setString(2, username);
					ps.executeUpdate();
					conn.commit();
				}
                String query3 = "SELECT * FROM Person P WHERE P.SSN=? and P.Passwd=SHA(?)";
                ps = conn.prepareStatement(query3);
                ps.setString(1, username);
                ps.setString(2, userpasswd);
                //ps.setString(3,username);
                java.sql.ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    // login success
                    session.putValue("login", username);
					if (userType.contains("Manager"))
							response.sendRedirect("ManagerHome.jsp");
					else if (userType.contains("Customer Representative"))
						response.sendRedirect("ManagerHome.jsp");
					else
						response.sendRedirect("CustomerHome.jsp");
                } else {
                    response.sendRedirect("/");
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
