<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
        <title>EDAY - Home</title>
    </head>
    <body>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                      <span class="sr-only">Toggle navigation</span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#"><%=session.getValue("login")%></a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
			<li><a href="CustomerHome.jsp">Home</a></li>
                        <li><a href="CustomerAuctions.jsp">My Auctions</a></li>
                        <li><a href="CustomerBids.jsp">My Bids</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div>
        </nav>
        <div class ="container">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <form class="form-inline" name="SearchItemsForm" action="CustomerSearch.jsp" method="post">
                        <div class="form-group">
                            <input type="searchKeyword" class="form-control" name="searchKeyword" id="searchKeyword" placeholder="Search for an item...">
                            <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                        </div>
                    </form>
                </div>
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                        <h2 class="panel-title">Create New Auction</h2>
                        </div>
                        <div class="panel-body">
                            <form name="createAuction" action="createAuction.jsp" method="post">
					<div class="form-group">
						<input type="itemName" class="form-control" name="itemName" id="itemName" placeholder="Item Name">
						<input type="itemType" class="form-control" name="itemType" id="itemType" placeholder="Item Type">
                                                <input type="numCopies" class="form-control" name="numCopies" id="numCopies" placeholder="No. of Copies">
                                                <input type="year" class="form-control" name="year" id="year" placeholder="Year">
                                                <input type="description" class="form-control" name="description" id="description" placeholder="Description">
					</div>
                                        <div class="form-group">
						<input type="minBid" class="form-control" name="minBid" id="minBid" placeholder="Minimum Bid">
						<input type="bidInc" class="form-control" name="bidInc" id="itemType" placeholder="Bid Increment">
                                                <input type="copiesSell" class="form-control" name="copiesSell" id="numCopies" placeholder="Copies to Sell">
                                                <input type="reservePrice" class="form-control" name="reservePrice" id="reservePrice" placeholder="Reserve Price">
                                                <input type="expireDate" class="form-control" name="expireDate" id="expireDate" placeholder="Expire Date (yyyy-mm-dd hh-mm-ss)">
                                                
					</div>
					<button type="submit" value="Log In" class="btn btn-success">Create</button>
                            </form>
                        </div>
                    </div>
                </div>
		<div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                    <h2 class="panel-title">Best Selling Items</h2>
                        </div>
                        <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th>Name</th>
                            <th>Item Type</th>
                            <th>Total Copies Sold</th>
                            <th>Total Sale Price</th>
                        </tr>
<%
    String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
    String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng?allowMultipleQueries=true"; 
    String mysUserID = "asfeng"; 
    String mysPassword = "108685053";
    
    String customerId = ""+session.getValue("login");
    if(customerId.equals("")){
        response.sendRedirect("index.htm");
    }
  			java.sql.Connection conn=null;
			try
			{
            	Class.forName(mysJDBCDriver).newInstance();
    			java.util.Properties sysprops=System.getProperties();
    			sysprops.put("user",mysUserID);
    			sysprops.put("password",mysPassword);
        
				//connect to the database
            			conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            			System.out.println("Connected successfully to database using JConnect");
                                conn.setAutoCommit(false);
            			String query = "SELECT I.Name, I.Type, SUM(S.CopiesSold) AS TotalCopiesSold, SUM(S.SalePrice) AS TotalSalePrice FROM Item I, Sale S WHERE I.ItemID = S.ItemID AND S.SellerID = ? GROUP BY I.Name ORDER BY TotalSalePrice DESC LIMIT 50";
            			java.sql.PreparedStatement ps = conn.prepareStatement(query);
            			ps.setString(1,customerId);
				java.sql.ResultSet rs = ps.executeQuery();
				while (rs.next()){
%>
                                <tr>
                                    <td><%=rs.getString("Name")%></td>
                                    <td><%=rs.getString("Type")%></td>
                                    <td><%=rs.getInt("TotalCopiesSold")%></td>
                                    <td><%=rs.getDouble("TotalSalePrice")%></td>
                                </tr>
<%
                                }
%>
                    </table>
                        </div>
                    </div>
		</div>
		<div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                    <h2 class="panel-title">Item Suggestions</h2>
                        </div>
                        <div class="panel-body">
                        <table class="table">
                            <tr>
                                <th>Seller</th>
                                <th>Auction Id</th>
                                <th>Item Id</th>
                                <th>Item Name</th>
                                <th>Item Type</th>
                                <th>Num Copies</th>
                            </tr>
<%                          
                            String query2 = "SELECT I.Type from bid B, item I, auction A WHERE B.CustomerID = ?" + 
                                            " AND B.AuctionID = A.AuctionID AND A.ItemID = I.ItemID ORDER BY B.BidTime DESC LIMIT 1";
                            ps = conn.prepareStatement(query2);
                            ps.setString(1, customerId);
                            rs = ps.executeQuery();
                            String typeComp = "";
                            if(rs.next()){
                                typeComp = rs.getString("Type");
                            }
                            query2 = "SELECT P.CustomerID, P.AuctionID, A.ItemId, I.Name, I.Type, I.NumCopies FROM auction A, post P, item I WHERE P.AuctionID = A.AuctionID AND A.ItemID = I.ItemID AND I.Type = ? AND CustomerID NOT IN ( ? )";
                            ps = conn.prepareStatement(query2);
                            ps.setString(1, typeComp);
                            ps.setString(2, customerId);
                            rs = ps.executeQuery();
                            while(rs.next()){
%>                              
                            <tr>
                                <td><%=rs.getString("CustomerId")%></td>
                                <td><%=rs.getString("AuctionId")%></td>
                                <td><%=rs.getString("ItemId")%></td>
                                <td><%=rs.getString("Name")%></td>
                                <td><%=rs.getString("Type")%></td>
                                <td><%=rs.getString("NumCopies")%></td>
                            </tr>
<%
                            }
                        }
                        catch(Exception e)
			{
				e.printStackTrace();
				out.print(e.toString());
			}
			finally{
			
				try{conn.close();}catch(Exception ee){};
			}
%>
                        </table>
                        </div>
                        </div>
                </div>
            </div>
        </div>
    </body>
</html>
