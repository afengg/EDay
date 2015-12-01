<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous">
			
		</script>
        <title>EDAY - Management</title>
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
			<li><a href="#">Auction Overview</a></li>
                        <li><a href="#">Employee Management</a></li>
                        <li><a href="#">2</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"><span class="glyphicon glyphicon-log-out"></span></a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div>
        </nav>
        <div class ="container">
            <div class="row"> 
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                    <h2 class="panel-title">Monthly Sales Report</h2>
                        </div>
                        <div class="panel-body">
                            <form action="ManagerHome.jsp">
                                <p>
                                    Select Month: 

                                <select id="Month" name="Month" onchange='this.form.submit()'>
                                    <option selected="selected" value= 1>January</option>
                                    <option value= 2>February</option>
                                    <option value= 3>March</option>
                                    <option value= 4>April</option>
                                    <option value= 5>May</option>
                                    <option value= 6>June</option>
                                    <option value= 7>July</option>
                                    <option value= 8>August</option>
                                    <option value= 9>September</option>
                                    <option value= 10>October</option>
                                    <option value= 11>November</option>
                                    <option value= 12>December</option>
                                </select>
									Input year: 
									<input type="text" name="Year" id="Year" onchange='this.form.submit()' >
									
								</p>
                            </form>
                    <table class="table">
                        <tr>
                            <th></th>
                            <th>Auction ID</th>
                            <th>Item ID</th>
                            <th>Seller</th>
                            <th>Buyer</th>
                            <th>Sale Price</th>
                            <th>Copies Sold</th>
                            <th>Monitor</th>
                            <th>Sale Date</th>
                        </tr>
<%
    String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
    String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng?allowMultipleQueries=true"; 
    String mysUserID = "asfeng"; 
    String mysPassword = "108685053";
    
    String month = request.getParameter("Month");
	String year = request.getParameter("Year");
        int row1 = 1;
    
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
            			String query = "SELECT * FROM Sale S WHERE ? = MONTH(S.SaleDate) AND ? = YEAR(S.SaleDate)";
            			java.sql.PreparedStatement ps = conn.prepareStatement(query);
            			ps.setString(1,month);
						if (year.equals(""))
							ps.setString(1,"*");
						else
							ps.setString(1,year);
				java.sql.ResultSet rs = ps.executeQuery();
				while (rs.next()){
                                    
%>
                                <tr>
                                    <td><%=row1++%></td>
                                    <td><%=rs.getInt("AuctionID")%></td>
                                    <td><%=rs.getInt("ItemID")%></td>
                                    <td><%=rs.getString("SellerID")%></td>
                                    <td><%=rs.getString("BuyerID")%></td>
                                    <td><%="$" + rs.getDouble("SalePrice")%></td>
                                    <td><%=rs.getInt("CopiesSold")%></td>
                                    <td><%=rs.getString("Monitor")%></td>
                                    <td><%=rs.getDate("SaleDate")%></td>
                                </tr>
                                
<%
                                }
%>
                    </table>
                        </p>
                        </div>
                    </div>
		</div>
                     <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                    <h2 class="panel-title">Comprehensive Item Listing</h2>
                        </div>
                        <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th>Item ID</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Year</th>
                            <th>Description</th>
                            <th>Copies</th>
                        </tr>
<%
				conn.setAutoCommit(false);
            			query = "SELECT * FROM Item";
            			ps = conn.prepareStatement(query);
				rs = ps.executeQuery();
				while (rs.next()){
%>
                                <tr>
                                    <td><%=rs.getInt("ItemID")%></td>
                                    <td><%=rs.getString("Name")%></td>
                                    <td><%=rs.getString("Type")%></td>
                                    <td><%=rs.getInt("Year")%></td>
                                    <td><%=rs.getString("Description")%></td>
                                    <td><%=rs.getInt("NumCopies")%></td>
                                    
                                </tr>
<%
                                }
%>
                    </table>
                        </p>
                        </div>
                    </div>
		</div>
                     <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                    <h2 class="panel-title">Top Customer Representatives By Earnings</h2>
                        </div>
                        <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th></th>
                            <th>Monitor ID</th>
                            <th>Auction Count</th>
                            <th>Total Revenue</th>
           
                        </tr>
<%
				conn.setAutoCommit(false);
            			query = "SELECT Monitor , COUNT(*) AS NumAuctions, SUM(SalePrice) AS TotalRevenue FROM Sale GROUP BY Monitor ORDER BY TotalRevenue LIMIT 1";
            			ps = conn.prepareStatement(query);
				rs = ps.executeQuery();
                                double prev = -1;
                                row1 = 0;
				while (rs.next()){
                                 if(prev < rs.getDouble("TotalRevenue"))
                                    row1++;
                                prev = rs.getDouble("TotalRevenue");   
%>
                                <tr>
                                    <td><%=row1%></td>
                                    <td><%=rs.getString("Monitor")%></td>
                                    <td><%=rs.getInt("NumAuctions")%></td>
                                    <td><%="$" + rs.getDouble("TotalRevenue")%></td>
                                    
                                </tr>
<%
                                }
%>
                    </table>
                        </p>
                        </div>
                    </div>
		</div>
                                        <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                    <h2 class="panel-title">Top 50 Customers By Total Revenue Generated</h2>
                        </div>
                        <div class="panel-body">
                    <table class="table">
                        <tr>
                            <th></th>
                            <th>Customer ID</th>
                            <th>Total Revenue</th>
                            <th>Sales</th>
                            <th>Purchases</th>
           
                        </tr>
<%
				conn.setAutoCommit(false);
            			query = "SELECT P.CustomerID, P.TotalRevenue, S1.SalesRevenue, S2.PurchasesRevenue FROM ( SELECT SellerID as CustomerID, SUM(SalePrice) as TotalRevenue FROM Sale UNION SELECT BuyerID, SUM(SalePrice) FROM Sale) AS P LEFT JOIN ( SELECT S.SellerID, SUM(S.SalePrice) AS SalesRevenue FROM Sale S GROUP BY S.SellerID ) AS S1 ON P.CustomerID = S1.SellerID LEFT JOIN ( SELECT S.BuyerID, SUM(S.SalePrice) AS PurchasesRevenue FROM Sale S GROUP BY S.BuyerID ) AS S2 ON P.CustomerID = S2.BuyerID GROUP BY P.CustomerID ORDER BY P.TotalRevenue DESC LIMIT 1";
            			ps = conn.prepareStatement(query);
				rs = ps.executeQuery();
                                row1 = 0;
                                prev = -1;
				while (rs.next()){
                                if(prev < rs.getDouble("TotalRevenue"))
                                    row1++;
                                prev = rs.getDouble("TotalRevenue");
                           
%>
                                <tr>
                                    <td><%=row1%></td>
                                    <td><%=rs.getString("CustomerID")%></td>
                                    <td><%="$" + rs.getDouble("TotalRevenue")%></td>
                                    <td><%="$" + rs.getDouble("SalesRevenue")%></td>
                                    <td><%="$" + rs.getDouble("PurchasesRevenue")%></td>
                                    
                                </tr>
<%
                                }
%>
                    </table>
                        </p>
                        </div>
                    </div>
		</div> 
		<div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                    <h2 class="panel-title">Top 50 Bestsellers List</h2>
                        </div>
                        <div class="panel-body">
                        <table class="table">
                            <tr>
                                <th></th>
                                <th>Item Name</th>
                                <th>Copies Sold</th>
                                <th>Revenue Generated</th>
                            </tr>
<%                         
                           query="SELECT I.Name, SUM(S.CopiesSold) AS TotalCopiesSold, SUM(S.SalePrice) AS TotalSalePrice" +
	" FROM Item I, Sale S" +
	" WHERE I.ItemID = S.ItemID" + 
	" GROUP BY I.Name" +
	" ORDER BY TotalSalePrice DESC LIMIT 1";
                            ps = conn.prepareStatement(query);

                            rs = ps.executeQuery();
                            row1 = 0;
                            prev = -1;
                            while(rs.next()){
                                if(prev < rs.getDouble("TotalSalePrice"))
                                    row1++;
                                prev = rs.getDouble("TotalSalePrice");
%>                              
                            <tr>
                                <td><%=row1%></td>
                                <td><%=rs.getString("Name")%></td>
                                <td><%=rs.getString("TotalCopiesSold")%></td>
                                <td><%="$" + rs.getString("TotalSalePrice")%></td>
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
        </div>
    </body>
</html>
