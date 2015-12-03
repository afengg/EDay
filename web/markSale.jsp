<%-- 
    Document   : markSale
    Created on : Dec 2, 2015, 11:18:19 PM
    Author     : Frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<title>EDAY: Mark Sale</title>
		<script src="jquery-1.11.3.min.js" type="text/javascript"></script>
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">

		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
	</head>

	<%
		String mysJDBCDriver = "com.mysql.jdbc.Driver";
		String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng?allowMultipleQueries=true";
		String mysUserID = "asfeng";
		String mysPassword = "108685053";
		java.sql.Connection conn = null;

		String login = (String) session.getValue("login");
		if (login == null) {
			response.sendRedirect("auth.htm");
		}

		try {

			Class.forName(mysJDBCDriver).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", mysUserID);
			sysprops.put("password", mysPassword);

			conn = java.sql.DriverManager.getConnection(mysURL, sysprops);
			System.out.println("Connected successfully to database using JConnect");
			conn.setAutoCommit(false);

			// Check if user really is cust rep. A manager technically has this ability, so we allow it.
			String qcheck = "SELECT IsManager FROM Employee E WHERE E.EmployeeID = ?";
			java.sql.PreparedStatement ps = conn.prepareStatement(qcheck);
			ps.setString(1, (String) session.getValue("login"));
			java.sql.ResultSet rs1 = ps.executeQuery();
			if (!rs1.next()) // USER NOT AUTHENTICATED
			{
				response.sendRedirect("auth.html");
			}

			// Now -- mark auction.
			// Given as param
			String aid = request.getParameter("AuctionID");
			if (aid == null) {
				response.sendRedirect("/"); // Shut up failures.
			}

			// SALE: AuctionID, ItemID, SellerID, SalePrice, CopiesSold, BuyerID, Monitor, SaleDate
			/*
			AuctionID	From Params
			ItemID		(Auction) Param.AuctionID . ItemID
			SellerID	CustomerID in Post
			SalePrice	CurrentHiBid
			CopiesSold	equal to previous plus 1, THEN DECREMENT the ITEM.
			BuyerID		Auction.CurrentHiBidder
			Monitor		login session
			SaleDate	Now()
			
			
			 */
			String sqlUpdate
					= "INSERT INTO Sale VALUES"
					+ "(?, ?, ?, ?, ?, ?, ?, Now());";

			String sqlQuery = "SELECT CustomerID AS SellerID, "
					+ "Copies_Sold as CopiesSold, ItemID, Monitor, CurrentHiBidder as BuyerID, CurrentHiBid as SalePrice "
					+ "FROM Post P, Auction A "
					+ "WHERE P.AuctionID = ? AND A.AuctionID = ?";

			String ItemID;
			double SalePrice;
			int CopiesSold;
			String Monitor;
			String buyerid, sellerid;

			ps = conn.prepareStatement(sqlQuery);
			ps.setString(1, aid);
			ps.setString(2, aid);

			java.sql.ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				buyerid = rs.getString("BuyerID");
				sellerid = rs.getString("SellerID");
				ItemID = rs.getString("ItemID");
				SalePrice = rs.getDouble("SalePrice");
				CopiesSold = rs.getInt("CopiesSold");
				
			} else {
				throw new Exception("Failed to get IDs");
			}

			ps = conn.prepareStatement(sqlUpdate);
			ps.setString(1, aid);
			ps.setString(2, ItemID);
			ps.setString(3, sellerid);
			ps.setDouble(4, SalePrice);
			ps.setInt(5, CopiesSold);
			ps.setString(6, buyerid);
			ps.setString(7, (String) session.getValue("login"));
			

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			out.print(e.toString());
			
			//response.sendRedirect("CustomerRepHome.jsp");
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception ee) {
			};
		}

	%>

	<body>
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-lg-offset-4">
					<legend class="text-center"><h1>E-DAY - Sale Posted!</h1>
						<p> Click <a href="CustomerRepHome.jsp">Here</a> to go back. </p>
					</legend>
				</div>
			</div>

		</div>

	</body>
</html>
