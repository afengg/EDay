  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Your Course Information -- Student Registration System</title>

</head>
<body style="text-align: center" bgcolor="#ffff00">
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Sir. Your ID is
        <%=session.getValue("login")%>. Here is Your Course Information.<br />
        <br />
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
            <tr>
                <td style="vertical-align: top; width: 11237px; text-align: left; height: 454px;">
                    <span style="font-size: 10pt">
                    This is the table for the courses in which you enrolled.<br />
                    You can delete the ones which do not have a grade.<br />
                        And you can search new courses by click the "Search" button below.<br />
                        You may engage in at most 10 courses.<br />
                    </span><br />
                    <table border="8" id="TABLE1" onclick="return TABLE1_onclick()">
                    <tr>
                      <td style="width: 84px">
                          <span style="font-size: 10pt">
                          Course Code</span></td>
                      <td style="width: 187px">
                          <span style="font-size: 10pt">Course Name</span></td>
                        <td style="width: 74px">
                            <span style="font-size: 10pt">Department</span></td>
                        <td>
                            <span style="font-size: 10pt">Professor</span></td>
                        <td style="width: 7px">
                            <span style="font-size: 10pt">Grade</span></td>
                        <td style="width: 7px">
                            <span style="font-size: 10pt">Oper</span></td>
                    </tr>   
<%
/*
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/cse305ta"; 
		String mysUserID = "asfeng"; 
		String mysPassword = "108685053";
        
        String stuId = ""+session.getValue("login");
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
            
            			java.sql.Statement stmt1=conn.createStatement();
        
					java.sql.ResultSet rs = stmt1.executeQuery("select Course.CrsCode,Course.CrsName,Course.DeptID,Professor.Name,Transcript.Grade from Course, Professor,Transcript where Course.CrsCode=Transcript.CrsCode and Professor.Id=Course.InsNo and Transcript.StudId='"+stuId+"'");
      	  
      	  String strGrade;
      	       	  
      	  while(rs.next())
        	{
        		strGrade = rs.getString(5);
        		if(rs.getString(5).trim().equals("-1"))
      	  	{
      	  			strGrade = "N/A";
      	  	}
*/
%>
</body>
</html>
