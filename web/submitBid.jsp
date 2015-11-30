<%
        String customerId = ""+session.getValue("login");
	String maximumBid = request.getParameter("maximumBid");
	String auctioNId = request.getParameter("auctionId");
     	String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
     	String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng"; 
     	String mysUserID = "asfeng"; 
    	String mysPassword = "108685053";
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
                                // sendredirect to auctions page or something
			} catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				try{conn.close();}catch(Exception ee){};
			}
		
	
%>