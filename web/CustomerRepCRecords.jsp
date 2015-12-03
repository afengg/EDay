<%@page import="com.mysql.jdbc.PreparedStatement"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : CustomerRepCRecords
    Created on : Dec 3, 2015, 8:38:12 AM
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
                <div class="col-md-12 ">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h2 class="panel-title">Current Customers</h2>
                        </div>
                        <div class="panel-body">

                            <form name="myform" action="CustomerRepCRecords2.jsp"  method="POST">
                                <select name="CustomerID">


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

                                        java.sql.Connection conn = null;
                                        try {
                                            Class.forName(mysJDBCDriver).newInstance();
                                            java.util.Properties sysprops = System.getProperties();
                                            sysprops.put("user", mysUserID);
                                            sysprops.put("password", mysPassword);

                                            // Master query
                                            int args = 3;

                                            String query = "SELECT CustomerID FROM Person P, Customer C WHERE P.SSN = C.CustomerID;";
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

                                            java.sql.ResultSet rs = ps.executeQuery();
                                            while (rs.next()) {
                                    %>

                                    <option value="<%= rs.getString("CustomerID")%>" ><%= rs.getString("CustomerID")%></option>

                                    <%
                                        }
                                    %>
                                </select>
                                <input type="submit" value="Submit" name="submitbtn" />
                            </form>
                        </div>
                    </div>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h2 class="panel-title">Mailing List</h2>
                        </div>
                        <div class="panel-body">
                            <table class="table">
                                <tr>
                                    <th></th>
                                    <th>FirstName</th>
                                    <th>LastName</th>
                                    <th>Address</th>
                                    <th>ZipCode</th>
                                    <th>State</th>
                                    <th>City</th>
                                    <th>Telephone</th>
                                    <th>Email</th>
                                </tr>
                                <%
                                    row1 = 1;
                                    query = "SELECT * FROM Person P, Customer C WHERE P.SSN = C.CustomerID;";
                                    ps = conn.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                %>

                                <tr>
                                    <td><%=row1++%></td>
                                    <td><%=rs.getString("FirstName")%></td>
                                    <td><%=rs.getString("LastName")%></td>
                                    <td><%=rs.getString("Address")%></td>
                                    <td><%=rs.getInt("ZipCode")%></td>
                                    <td><%=rs.getString("State")%></td>
                                    <td><%=rs.getString("City")%></td>
                                    <td><%=rs.getString("Telephone")%></td>
                                    <td><%=rs.getString("Email")%></td>
                                </tr>


                                <% } %>
                            </table>
                        </div>
                    </div>

                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h2 class="panel-title">Recommended Items</h2>
                        </div>
                        <div class="panel-body">

                            <form name="recommenditems" action="CustomerRepItems.jsp"  method="POST">
                                <select name="CustomerID">


                                    <%
                                        row1 = 1;
                                        query = "SELECT CustomerID FROM Customer C";
                                        ps = conn.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                    %>

                                    <option value="<%= rs.getString("CustomerID")%>" ><%= rs.getString("CustomerID")%></option>

                                    <%
                                        }
                                    %>
                                </select>
                                <input type="submit" value="Submit" name="submitbtn2" />
                            </form>
                        </div>
                    </div>

                </div>
            </div>
            <%    } catch (Exception e) {
                    e.printStackTrace();
                    out.print(e.toString());
                } finally {
                    try {
                        conn.close();
                    } catch (Exception ee) {
                    };
                }
            %>
        </div>
    </div>
</body>
</html>
