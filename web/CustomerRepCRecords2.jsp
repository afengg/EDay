<%-- 
    Document   : CustomerRepCRecords2
    Created on : Dec 3, 2015, 9:16:54 AM
    Author     : Frank
--%>

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
        <title>EDAY - Customer Representative Customer Edits</title>
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
                        <li><a href="CustomerRepHome.jsp">Auction Overview</a></li>
                        <li><a href="CustomerRepCRecords.jsp">Customer Records</a></li>
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
                            <h2 class="panel-title">Current Customers</h2>
                        </div>
                        <div class="panel-body">
                               
                            <form action="editCustomer.jsp"  method="POST">
                            
                                
                            
                            <%
                                
                                String mysJDBCDriver = "com.mysql.jdbc.Driver";
                                String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng?allowMultipleQueries=true";
                                String mysUserID = "asfeng";
                                String mysPassword = "108685053";

                                String login = (String) session.getValue("login");
                                if (login == null) {
                                    response.sendRedirect("auth.htm");
                                }

                                int row1 = 1;
                                String CustomerID = request.getParameter("CustomerID");
                                java.sql.Connection conn = null;
                                try {
                                    Class.forName(mysJDBCDriver).newInstance();
                                    java.util.Properties sysprops = System.getProperties();
                                    sysprops.put("user", mysUserID);
                                    sysprops.put("password", mysPassword);

                                    // Master query
                                    int args = 3;

                                    String query = "SELECT * FROM Person P, Customer C WHERE P.SSN = C.CustomerID AND C.CustomerID = ?;";
                                    //connect to the database
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

                                    ps = conn.prepareStatement(query);
                                    ps.setString(1, CustomerID);
                                    java.sql.ResultSet rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <% out.write(CustomerID); %><br>
                            Last name: <input type="text" name="LastName" value="<%=rs.getString("LastName")%>" /> <br>
                            First name: <input type="text" name="FirstName" value="<%=rs.getString("FirstName")%>" /> <br>
                            Address: <input type="text" name="Address" value="<%=rs.getString("FirstName")%>" /> <br>
                            Zip: <input type="number" name="ZipCode" value="<%= Integer.toString(rs.getInt("ZipCode"))%>" /> <br>
                            Telephone: <input type="text" name="Telephone" value="<%=rs.getString("Telephone")%>" /> <br>
                            Email: <input type="text" name="Email" value="<%=rs.getString("City")%>" /> <br>
                            State: <input type="text" name="State" value="<%=rs.getString("State")%>" /> <br>
                            <input type="submit" value="Submit"> <br>
                            
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
                            
                            
                            </form>
                        </div>
                    </div>
                </div>
            </div>   
        </div>
    </div>
</body>
</html>
