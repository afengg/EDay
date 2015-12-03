<%-- 
    Document   : backup
    Created on : Dec 3, 2015, 12:30:06 PM
    Author     : fmigliorino
--%>

<%

    
    String mysJDBCDriver = "com.mysql.jdbc.Driver";
    String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu:3306/asfeng";
    //mysURL = "jdbc:mysql://localhost:3306/asfeng"; 
    String mysUserID = "asfeng";
    String mysPassword = "108685053";

    //session.putValue("login", "");
    //throw new RuntimeException();
    // code start here
    java.sql.Connection conn = null;
    try {
        Class.forName(mysJDBCDriver).newInstance();
        java.util.Properties sysprops = System.getProperties();
        sysprops.put("user", mysUserID);
        sysprops.put("password", mysPassword);

        //connect to the database
        conn = java.sql.DriverManager.getConnection(mysURL, sysprops);
        System.out.println("Connected successfully to database using JConnect");

        String executeCmd = "Z:\\Desktop\\mysqldump.exe -u -h mysql2.cs.stonybrook.edu:3306  " + mysUserID + " -p" + mysPassword + " --add-drop-database -B " + "Z:\\Desktop\\asfeng" + " -r " + "asfeng" + ".sql";

            Process runtimeProcess;
            try {
                 runtimeProcess = Runtime.getRuntime().exec(executeCmd);
                int processComplete = runtimeProcess.waitFor();
                 if (processComplete == 0) {
                    out.println("Backup created to asfeng.sql");
                } else {
                    out.println("Could not create the backup");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        
        conn.setAutoCommit(false);
        response.sendRedirect("ManagerHome.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            conn.close();
        } catch (Exception ee) {
        };
    }


%>
