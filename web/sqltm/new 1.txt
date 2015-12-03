String mysJDBCDriver = "com.mysql.jdbc.Driver";
String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng?allowMultipleQueries=true";
String mysUserID = "asfeng";
String mysPassword = "108685053";

try {
	Class.forName(mysJDBCDriver).newInstance();
	java.util.Properties sysprops = System.getProperties();
	sysprops.put("user", mysUserID);
	sysprops.put("password", mysPassword);
	conn = java.sql.DriverManager.getConnection(mysURL, sysprops);
	System.out.println("Connected successfully to database using JConnect");
	conn.setAutoCommit(false);

} catch (Exception e) {
	e.printStackTrace();
	out.print(e.toString());
} finally {
	try {
		conn.close();
	} catch (Exception ee) {};
}