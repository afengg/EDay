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
                    <a class="navbar-brand" href="#">Brand</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
			<li><a href="#">Home</a></li>
                        <li><a href="#">My Auctions</a></li>
                        <li><a href="#">My Bids</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"><span class="glyphicon glyphicon-log-out"></span></a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div>
        </nav>
        <div class ="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <form class="form-inline" name="SearchItemsForm" action="" method="post">
                        <div class="form-group">
                            <input type="searchKeyword" class="form-control" name="searchKeyword" id="searchKeyword" placeholder="Search for an item...">
                            <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="row">
		<div class="col-md-4 col-md-offset-4">
                    <h2>Best Selling Items</h2>
                    <table class="table">
                        <tr>
                            <th>Name</th>
                            <th>Item Type</th>
                            <th>Total Copies Sold</th>
                            <th>Total Sale Price</th>
                        </tr>
<%
    String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
    String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng"; 
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
            			java.sql.Statement stmt1=conn.createStatement();
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
            <div class="row">
		<div class="col-md-4 col-md-offset-4">
                    <h2>Item Suggestions</h2>
		</div>
            </div>
        </div>
    </body>
</html>
