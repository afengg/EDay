<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="jquery-1.11.3.min.js" type="text/javascript"></script>
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
                        <li><a href="ManagerHome.jsp">Overview</a></li>
                        <li><a href="EmployeeManagement.jsp">Employee Management</a></li>
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
                    <form class="form-inline" name="SearchItemsForm" action="ManagerSearch1.jsp" method="post">
                        <div class="form-group">
                            <input type="searchKeyword" class="form-control" name="searchKeyword1" id="searchKeyword" placeholder="Enter Item Name, Type, or Customer Name for Records and Listings">
                            <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                        </div>
                    </form>
                </div>
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
                                        <option value =0></option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("1")) ? "selected=\"selected\"" : ""%> value= 1>January</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("2")) ? "selected=\"selected\"" : ""%>value= 2>February</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("3")) ? "selected=\"selected\"" : ""%>value= 3>March</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("4")) ? "selected=\"selected\"" : ""%>value= 4>April</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("5")) ? "selected=\"selected\"" : ""%>value= 5>May</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("6")) ? "selected=\"selected\"" : ""%>value= 6>June</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("7")) ? "selected=\"selected\"" : ""%>value= 7>July</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("8")) ? "selected=\"selected\"" : ""%>value= 8>August</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("9")) ? "selected=\"selected\"" : ""%>value= 9>September</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("10")) ? "selected=\"selected\"" : ""%> value= 10>October</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("11")) ? "selected=\"selected\"" : ""%> value= 11>November</option>
                                        <option <%=  (request.getParameter("Month") != null && request.getParameter("Month").equals("12")) ? "selected=\"selected\"" : ""%> value= 12>December</option>
                                    
                                        Input Year:    
                                        
                                        <input type="text" name="Year" id="Year" value="<%= request.getParameter("Year") == null ? "" : request.getParameter("Year")%>" onchange='this.form.submit()' >

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
                                                if (month == "0") {
                                                    month = null;
                                                }
                                                String year = request.getParameter("Year");

                                                String login = (String) session.getValue("login");
                                                if (login == null) {
                                                    response.sendRedirect("passMistake.htm");
                                                }

                                                int row1 = 1;

                                                java.sql.Connection conn = null;
                                                try {
                                                    Class.forName(mysJDBCDriver).newInstance();
                                                    java.util.Properties sysprops = System.getProperties();
                                                    sysprops.put("user", mysUserID);
                                                    sysprops.put("password", mysPassword);

                                                    // Master query
                                                    int args = 3;
                                                    String query = "SELECT * FROM Sale S WHERE ? = MONTH(S.SaleDate) AND ? = YEAR(S.SaleDate)";
                                                    if (month == null && year == null) {
                                                        args = 0;
                                                        query = "SELECT * FROM Sale S";
                                                    } else if (month != null && year == null) {
                                                        args = 1;
                                                        query = "SELECT * FROM Sale S WHERE ? = MONTH(S.SaleDate)";
                                                    } else if (month == null && year != null) {
                                                        args = 2;
                                                        query = "SELECT * FROM Sale S WHERE ? = YEAR(S.SaleDate)";
                                                    }

                                                    //connect to the database
                                                    conn = java.sql.DriverManager.getConnection(mysURL, sysprops);
                                                    System.out.println("Connected successfully to database using JConnect");
                                                    conn.setAutoCommit(false);

                                                    // Check if user really is manager.
                                                    String qcheck = "SELECT IsManager FROM Employee E WHERE E.EmployeeID = ? AND E.IsManager = 1";
                                                    java.sql.PreparedStatement ps = conn.prepareStatement(qcheck);
                                                    ps.setString(1, (String) session.getValue("login"));
                                                    java.sql.ResultSet rs1 = ps.executeQuery();
                                                    if (!rs1.next()) // USER NOT AUTHENTICATED
                                                    {
                                                        response.sendRedirect("auth.html");
                                                    }

                                                    ps = conn.prepareStatement(query);
                                                    //ps.setString(1,month);
                                                    switch (args) {
                                                        case 0:
                                                            break;
                                                        case 1:
                                                            ps.setString(1, month);
                                                            break;
                                                        case 2:
                                                            ps.setString(1, year);
                                                            break;
                                                        case 3:
                                                            ps.setString(1, month);
                                                            ps.setString(2, year);
                                                    }

                                                    java.sql.ResultSet rs = ps.executeQuery();
                                                    while (rs.next()) {
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
                                    while (rs.next()) {
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
                            <h2 class="panel-title">Top Customer Representative By Revenue Monitored</h2>
                        </div>
                        <div class="panel-body">
                            <table class="table">
                                <tr>
                                    <th>Monitor ID</th>
                                    <th>Auction Count</th>
                                    <th>Total Revenue</th>

                                </tr>
                                <%
                                    conn.setAutoCommit(false);
                                    query = "SELECT Monitor , COUNT(*) AS NumAuctions, SUM(SalePrice) AS TotalRevenue FROM Sale GROUP BY Monitor ORDER BY TotalRevenue LIMIT 1";
                                    ps = conn.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {

                                %>
                                <tr>
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
                            <h2 class="panel-title">Top Customer By Total Revenue Generated</h2>
                        </div>
                        <div class="panel-body">
                            <table class="table">
                                <tr>
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
                                    while (rs.next()) {

                                %>
                                <tr>
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
                            <h2 class="panel-title">Top 50 Bestsellers List by Copies Sold</h2>
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
                                    query = "SELECT I.Name, SUM(S.CopiesSold) AS TotalCopiesSold, SUM(S.SalePrice) AS TotalSalePrice"
                                            + " FROM Item I, Sale S"
                                            + " WHERE I.ItemID = S.ItemID"
                                            + " GROUP BY I.Name"
                                            + " ORDER BY TotalCopiesSold DESC LIMIT 50";
                                    ps = conn.prepareStatement(query);

                                    rs = ps.executeQuery();
                                    row1 = 0;
                                    double prev = -1;
                                    while (rs.next()) {
                                        if (prev < rs.getDouble("TotalSalePrice")) {
                                            row1++;
                                        }
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
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                        out.print(e.toString());
                                    } finally {

                                        try {
                                            conn.close();
                                        } catch (Exception ee) {
                                        };
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
