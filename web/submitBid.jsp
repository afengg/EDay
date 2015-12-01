<%
        String customerId = ""+session.getValue("login");
	double maximumBid = Double.parseDouble(request.getParameter("maximumBid"));
	int auctionId = Integer.parseInt(request.getParameter("auctionId"));
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
                                // B.BidPrice is the lowest between B.MaximumBid and A.CurrentHiBid + A.BidIncrement. 
                                /*
                                    SELECT A.CurrentHiBidder A.CurrentHiBid, A.BidIncrement FROM auction A WHERE A.AuctionID = auctionId;
                                    currenthibid <- A.CurrentHiBid
                                    bidincrement <- A.BidIncrement
                                    currenthibidder <- A.CurrentHiBidder
                                    bidprice = math.least(maximumbid, currenthibid+bidincrement)
                                */
                                String query = "SELECT A.CurrentHiBidder, A.CurrentHiBid, A.BidIncrement FROM Auction A WHERE A.AuctionID = ?";
            			java.sql.PreparedStatement ps = conn.prepareStatement(query);
            			ps.setInt(1, auctionId);
				java.sql.ResultSet rs = ps.executeQuery();
                                double currentHiBid = 0.0;
                                double bidIncrement = 0.0;
                                String currentHiBidder = "";
                                if(rs.next()){
                                    currentHiBid = rs.getDouble("CurrentHiBid");
                                    bidIncrement = rs.getDouble("BidIncrement");
                                    currentHiBidder = rs.getString("CurrentHiBidder");
                                }
                                rs.close();
                                double bidPrice = Math.min(maximumBid, currentHiBid+bidIncrement);
                                String query2 = "SELECT MAX(B.MaximumBid) as AuctionMaxBid, B.CustomerID from Bid B where B.AuctionID = ? ORDER BY BidTime ASC";
                                ps = conn.prepareStatement(query2);
                                ps.setInt(1, auctionId);
                                rs = ps.executeQuery();
                                double auctionMaxBid = 0.0;
                                String maxBidder = "";
                                if(rs.next()){
                                    auctionMaxBid = rs.getDouble("AuctionMaxBid");
                                    maxBidder = rs.getString("CustomerId");
                                }
                                rs.close();
                                if(maximumBid > auctionMaxBid){
                                    String query3 = "UPDATE auction SET auction.CurrentHiBidder = ?, auction.CurrentHiBid = ? WHERE auction.AuctionId = ?";
                                    ps = conn.prepareStatement(query3);
                                    ps.setString(1, customerId);
                                    ps.setDouble(2, bidPrice);
                                    ps.setInt(3, auctionId);
                                    ps.executeUpdate();
                                    conn.commit();
                                }
                                // First insert original bid
                                    String query4 = "INSERT INTO bid (CustomerID, AuctionID, BidTime, BidPrice, MaximumBid) VALUES (?, ?, now(), ?, ?)";
                                    ps = conn.prepareStatement(query4);
                                    ps.setString(1, customerId);
                                    ps.setInt(2, auctionId);
                                    ps.setDouble(3, bidPrice);
                                    ps.setDouble(4, maximumBid);
                                    ps.executeUpdate();
                                    conn.commit();
                                if(maximumBid > currentHiBid && maximumBid <= auctionMaxBid){
                                    // Finally add a new bid on behalf of the high bidder
                                    String query5 = "INSERT INTO bid (CustomerID, AuctionID, BidTime, BidPrice, MaximumBid) VALUES (?, ?, now(), ?, ?)";
                                    ps = conn.prepareStatement(query5);
                                    ps.setString(1, maxBidder);
                                    ps.setInt(2, auctionId);
                                    ps.setDouble(3, Math.min(maximumBid + bidIncrement, auctionMaxBid));
                                    ps.setDouble(4, auctionMaxBid);
                                    ps.executeUpdate();
                                    conn.commit();
                                }
                                response.sendRedirect("CustomerViewAuction.jsp");
                                // If maximumbid is the highest for this auction, then SET Auction.CurrentHiBidder to him and Auction.CurrentHiBid to B.BidPrice.
                                /*
                                    SELECT MAX(B.MaximumBid) as AuctionMaxBid, B.CustomerID from Bid B where B.AuctionID = AuctionId ORDER BY BidTime ASC;
                                    auctionmaxbid <- AuctionMaxBid
                                    if maximumbid > auctionmaxbid then UPDATE Auction SET currentHiBidder = customerId AND currentHiBid = bidprice
                                    else if maximumbid > currenthibid and maxmiumbid < auctionmaxbid then insert a bid for the currentHiBidder equal to LEAST(maximumBid + bidIncrement, auctionmaxbid)
                                 INSERT original bid
                                */
			} catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				try{conn.close();}catch(Exception ee){};
			}
		
	
%>