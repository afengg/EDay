<%
        String customerId = ""+session.getValue("login");
        System.out.println(customerId);
	String itemName = request.getParameter("itemName");
	String itemType = request.getParameter("itemType");
        int numCopiesItem = Integer.parseInt(request.getParameter("numCopies"));
        String year = request.getParameter("year");
        String description = request.getParameter("description");
        Double minBid = Double.parseDouble(request.getParameter("minBid"));
        Double bidInc = Double.parseDouble(request.getParameter("bidInc"));
        int copiesSell = Integer.parseInt(request.getParameter("copiesSell"));
        Double reservePrice = Double.parseDouble(request.getParameter("reservePrice"));
        String expireDate = request.getParameter("expireDate");
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
            			String query = "INSERT INTO item(Name, Type, NumCopies, Description, Year) VALUES(?, ?, ?, ?, ?)";
            			java.sql.PreparedStatement ps = conn.prepareStatement(query);
            			ps.setString(1,itemName);
            			ps.setString(2,itemType);
            			ps.setInt(3,numCopiesItem);
                                ps.setString(4, description);
                                ps.setString(5, year);
				ps.executeUpdate();
                                conn.commit();
                                String query2 = "INSERT INTO auction(BidIncrement, MinimumBid, Copies_Sold, ReservePrice, ItemId, Monitor) VALUES (?, ?, ?, ?, (select(LAST_INSERT_ID())), ?)";
                                ps = conn.prepareStatement(query2);
                                System.out.println(bidInc);
                                ps.setDouble(1, bidInc);
                                ps.setDouble(2, minBid);
                                ps.setInt(3, copiesSell);
                                ps.setDouble(4, reservePrice);
                                ps.setString(5, "123-45-6789");
                                ps.executeUpdate();
                                conn.commit();
                                String query3 = "INSERT INTO post(ExpireDate, PostDate, CustomerId, AuctionId) VALUES(?, NOW(), ?, (select(LAST_INSERT_ID())))";
                                ps = conn.prepareStatement(query3);
                                System.out.println(expireDate);
                                System.out.println(customerId);
                                ps.setString(1, expireDate);
                                ps.setString(2, customerId);
                                ps.executeUpdate();
                                conn.commit();
                                // sendredirect to auctions page or something
			} catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				try{conn.close();}catch(Exception ee){};
			}
		
	
%>