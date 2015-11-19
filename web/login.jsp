<%
	if((request.getParameter("action")!=null)&&	(request.getParameter("action").trim().equals("logout")))
	{
		session.putValue("login","");
		response.sendRedirect("/");
		return;
	}
		String username = request.getParameter("loginUser");
		String userpasswd = request.getParameter("loginPassword");
     	String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
     	String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng"; 
     	String mysUserID = "asfeng"; 
    	String mysPassword = "108685053";
    	
	session.putValue("login","");
	if ((username!=null) &&(userpasswd!=null))
	{
		if (username.trim().equals("") || userpasswd.trim().equals(""))
		{
			response.sendRedirect("index.htm");
		}
		else
		{
			// code start here
			java.sql.Connection conn=null;
			try {
		            	Class.forName(mysJDBCDriver).newInstance();
            			java.util.Properties sysprops=System.getProperties();
            			sysprops.put("user",mysUserID);
            			sysprops.put("password",mysPassword);
        
				//connect to the database
            			conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            			System.out.println("Connected successfully to database using JConnect");
            
            			conn.setAutoCommit(false);
            			java.sql.Statement stmt1=conn.createStatement();
            			String query = "SELECT * FROM Person P WHERE P.SSN=? and P.Passwd=SHA(?)";
            			java.sql.PreparedStatement ps = conn.prepareStatement(query);
            			ps.setString(1,username);
            			ps.setString(2,userpasswd);
            			//ps.setString(3,username);
				java.sql.ResultSet rs = ps.executeQuery();
				
				if (rs.next())
				{
					// login success
					session.putValue("login",username);
					response.sendRedirect("CustomerHome.jsp");
				}
				else
				{
					rs = stmt1.executeQuery(" select * from Person P, Employee E where P.SSN='"+username+"' and E.EmployeeID='"+username+"' and Passwd='"+userpasswd+"'");
					if(rs.next())
					{
						session.putValue("login", username);
						response.sendRedirect("FacultyInformation.jsp");
					}
						
					else
					{
						// username or password mistake
						response.sendRedirect("passMistake.jsp");
					}
				}
			} catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				try{conn.close();}catch(Exception ee){};
			}
		}
	}
%>