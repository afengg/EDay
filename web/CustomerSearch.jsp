<%-- 
    Document   : CustomerSearch.jsp
    Created on : Nov 18, 2015, 8:34:19 PM
    Author     : alvin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="jquery-1.11.3.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
        <title>EDAY - Search Results</title>
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
                    <a class="navbar-brand" href="#">Brand</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
			<li><a href="CustomerHome.jsp">Home</a></li>
                        <li><a href="CustomerAuctions.jsp">My Auctions</a></li>
                        <li><a href="CustomerBids.jsp">My Bids</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"><span class="glyphicon glyphicon-log-out"></span></a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div>
        </nav>
            <div class="container">
                <h2> Search Results </h2>
                <table class="table">
                    <tr>
                        <th>Seller</th>
                        <th>Item ID</th>
                        <th>Description</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>No. Copies</th>
                        <th>Auction ID</th>
                        <th>Bid Increment</th>
                        <th>Minimum Bid</th>
                        <th>Copies Sold</th>
                        <th>Expire Date</th>
                        <th></th>
                    </tr>
<%
    String searchKeyword = request.getParameter("searchKeyword");
    String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
    String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng?allowMultipleQueries=true"; 
    String mysUserID = "asfeng"; 
    String mysPassword = "108685053";
    
    String customerId = ""+session.getValue("login");
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
                                String query = "SELECT P.CustomerId, A.AuctionID, A.BidIncrement, A.MinimumBid, A.Copies_Sold, I.ItemID, I.Description, I.Name, I.Type, I.NumCopies, P.ExpireDate FROM Auction A, Item I, Post P WHERE I.ItemID = A.ItemID AND P.AuctionID = A.AuctionID AND (P.CustomerID = ? OR I.Type = ? OR I.Name LIKE ? )";
                                java.sql.PreparedStatement ps = conn.prepareStatement(query);
            			ps.setString(1,searchKeyword);
                                ps.setString(2,searchKeyword);
                                ps.setString(3,searchKeyword);
                                java.sql.ResultSet rs = ps.executeQuery();
				while (rs.next()){
%>                                  
                <tr>
                    <td><%=rs.getString("CustomerId")%></td>
                    <td><%=rs.getString("ItemId")%></td>
                    <td><%=rs.getString("Description")%></td>
                    <td><%=rs.getString("Name")%></td>
                    <td><%=rs.getString("Type")%></td>
                    <td><%=rs.getString("NumCopies")%></td>
                    <td><%=rs.getString("AuctionId")%></td>
                    <td><%=rs.getString("BidIncrement")%></td>
                    <td><%=rs.getString("MinimumBid")%></td>
                    <td><%=rs.getString("Copies_Sold")%></td>
                    <td><%=rs.getString("ExpireDate")%></td>
                    <td><span><form action="CustomerViewAuction.jsp" method="post"><input type="hidden" name="auctionId" id="auctionId" value=<%=rs.getInt("AuctionId")%>><button type="submit">View Details</button></form></span>
                </tr>
<% 
                }
%>
                </table>
            </div>
<%
   
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
        </nav>
    </body>
</html>
