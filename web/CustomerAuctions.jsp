<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
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
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                    <h2 class="panel-title">Your Auctions</h2>
                        </div>
                        <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th>Item Name</th>
                            <th>Item Type</th>
                            <th>Auction Id</th>
                            <th>Current Hi Bid</th>
                            <th>Current Hi Bidder</th>
                            <th>Expire Date</th>
                            <th></th>
                        </tr>
<%
    String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
    String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng?allowMultipleQueries=true"; 
    String mysUserID = "asfeng"; 
    String mysPassword = "108685053";
    
    String customerId = ""+session.getValue("login");
  			java.sql.Connection conn=null;
    if(customerId.equals("")){
        response.sendRedirect("index.htm");
    }
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
            			String query = "SELECT I.Name, I.Type, A.AuctionId, A.CurrentHiBid, A.CurrentHiBidder, P.ExpireDate FROM Item I, Auction A, Post P WHERE P.CustomerId = ? AND P.AuctionId = A.AuctionId AND A.ItemId = I.ItemId";
            			java.sql.PreparedStatement ps = conn.prepareStatement(query);
            			ps.setString(1,customerId);
				java.sql.ResultSet rs = ps.executeQuery();
                                NumberFormat formatter = new DecimalFormat("#0.00");
				while (rs.next()){
%>
                                <tr>
                                    <td><%=rs.getString("Name")%></td>
                                    <td><%=rs.getString("Type")%></td>
                                    <td><%=rs.getInt("AuctionId")%></td>
                                    <td><%=formatter.format(rs.getDouble("CurrentHiBid"))%></td>
                                    <td><%=rs.getString("CurrentHiBidder")%></td>
                                    <td><%=rs.getString("ExpireDate")%></td>
                                    <td><span><form action="CustomerViewAuction.jsp" method="post"><input type="hidden" name="auctionId" id="auctionId" value=<%=rs.getInt("AuctionId")%>><button type="submit">View Details</button></form></span>
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
