<%

    String CustomerID = request.getParameter("CustomerID");
    String email = request.getParameter("Email");
    String fName = request.getParameter("FirstName");
    String lName = request.getParameter("LastName");
    String address = request.getParameter("Address");
    String zipcode = request.getParameter("ZipCode");
    String state = request.getParameter("State");
    String city = request.getParameter("City");
    String telephone = request.getParameter("Telephone");
    String rating = request.getParameter("Rating");
    String ccn = request.getParameter("CreditCardNum");
    
    
    String mysJDBCDriver = "com.mysql.jdbc.Driver";
    String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng";
    //mysURL = "jdbc:mysql://localhost:3306/asfeng"; 
    String mysUserID = "asfeng";
    String mysPassword = "108685053";

    //session.putValue("login", "");
    //throw new RuntimeException();
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
        String query = "UPDATE Person P SET LastName = ?, FirstName = ?, Address = ?, ZipCode = ?, Telephone = ?, Email = ?, City = ?, State = ? WHERE P.SSN = ?";
        java.sql.PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, lName);
        ps.setString(2, fName);
        ps.setString(3, address);
        ps.setInt(4, Integer.parseInt(zipcode));
        ps.setString(5, telephone);
        ps.setString(6, email);
        ps.setString(7, city);
        ps.setString(8, state);
        ps.setString(9, CustomerID);
        ps.executeUpdate();
        conn.commit();
        

        String query2 = "UPDATE  Customer C " + 
                "SET CreditCardNum = ?, Rating = ? " +
                "WHERE C.CustomerID = ?";
        ps = conn.prepareStatement(query2);
        
        ps.setString(1, ccn);
        ps.setInt(2, Integer.parseInt(rating));
        ps.setString(3, CustomerID);
        
        ps.executeUpdate();
        conn.commit();

        response.sendRedirect("CustomerRepHome.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            conn.close();
        } catch (Exception ee) {
        };
    }


%>
