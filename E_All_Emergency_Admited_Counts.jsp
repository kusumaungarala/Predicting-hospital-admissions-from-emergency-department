<%@ include file="connect.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>All Emergency Patients Details</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <link href="style.css" />
</head>
<body>
    <div align="center">
        <h2>View All Emergency Admitted Patients Details</h2>
        <table border="3" cellpadding="5" cellspacing="0">
            <tr>
                <th>PID</th>
                <th>Patient Name</th>
                <th>Blood Group</th>
                <th>Disease</th>
                <th>Number of Times Admitted</th>
            </tr>
            <%
                String query = "SELECT MAX(id) AS id, patientname, MAX(bloodgroup) AS bloodgroup, " +
                               "MAX(disease) AS disease, COUNT(patientname) AS admission_count " +
                               "FROM emergency_patients " +
                               "GROUP BY patientname";

                try {
                    Statement st = connection.createStatement();
                    ResultSet rs = st.executeQuery(query);

                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true; 
                        int id = rs.getInt("id");
                        String patientName = rs.getString("patientname");
                        String bloodGroup = rs.getString("bloodgroup");
                        String disease = rs.getString("disease");
                        int admissionCount = rs.getInt("admission_count");
            %>
            <tr>
            
                <td><%= id %></td>
                <td><%= patientName %></td>
                <td><%= bloodGroup %></td>
                <td><%= disease %></td>
                <td><%= admissionCount %></td>
            </tr>
            <%
                    }

                    if (!hasData) {
            %>
            <tr>
                <td colspan="5" align="center">No data found</td>
            </tr>
            <%
                    }

                    connection.close();
                } catch (Exception e) {
                }
            %>
        </table>
        <div>
        <a href="E_Emergency_Main.jsp">Back</a>
        </div>
    </div>
</body>
</html>
