<%@page contentType="text/html" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>


<html>
      <%
    String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
    String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng?allowMultipleQueries=true"; 
    String mysUserID = "asfeng"; 
    String mysPassword = "108685053";
    int employeeId = Integer.parseInt(request.getParameter("EmployeeID"));

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
            			String query = "SELECT * FROM Employee E, Person P WHERE E.EmployeeID = ? AND E.EmployeeID = P.SSN";
            			java.sql.PreparedStatement ps = conn.prepareStatement(query);
            			ps.setInt(1,employeeId);
				java.sql.ResultSet rs = ps.executeQuery();
                                rs.next();
				
                                    
                                    
%>
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
            <div class="container">
                <div class="row">
                  <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <h2 class="panel-primary">Employee Modification</h2>
                        </div>
                        <div class="panel-body">
                            <form name="editEmployee" action="editEmployee.jsp" method="post">
								<div class="form-group">
                                                                    Employee ID: <%= rs.getString("EmployeeID")%><br>
                                                                    Last Name: <input type="text" class="form-control" name="LastName" id="itemName" value="<%= rs.getString("LastName")%>">
								    First Name: <input type="text" class="form-control" name="FirstName" id="itemType" value="<%= rs.getString("FirstName")%>">
								    Address: <input type="text" class="form-control" name="Address" id="itemType" value="<%= rs.getString("Address")%>">
                                                                    Zip Code:	<input type="number" class="form-control" name="ZipCode" id="itemType" value="<%= rs.getString("ZipCode")%>">
                                                                    City:	<input type="text" class="form-control" name="City" id="itemType" value="<%= rs.getString("City")%>">
                                                                    State:	<input type="text" class="form-control" name="State" id="itemType" value="<%= rs.getString("State")%>">
                                                                    Telephone: <input type="text" class="form-control" name="Telephone" id="itemType" value="<%= rs.getString("Telephone")%>">
                                                                    Email: <input type="text" class="form-control" name="Email" id="itemType" value="<%= rs.getString("Email")%>">
                                                                    Start Date: <input type="text" class="form-control" name="StartDate" id="itemType" value="<%= rs.getString("StartDate")%>">
                                                                    Hourly Rate: <input type="number" class="form-control" name="HourlyRate" id="itemType" value="<%= rs.getString("HourlyRate")%>">
                                                                    Level: <input type="number" class="form-control" name="Level" id="itemType" value="<%= rs.getString("Level")%>">
                                                                    IsManager: <input type="number" class="form-control" name="IsManager" id="itemType" value="<%= rs.getString("IsManager")%>">
                                                                    <input type="hidden" name="EmployeeId" id="EmployeeId" value=<%=rs.getString("EmployeeID")%>>
								<button type="submit" value="Edit" class="btn btn-success">Submit</button>
                            </form></div>
                    </div>
                  </div>
                </div>
            </div>
        </nav>
    </body>
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
</html>
