<%@ include file="connect.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.crypto.*" %>
<%@ page import="javax.crypto.spec.SecretKeySpec" %>
<%@ page import="java.security.*" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="javax.servlet.ServletContext" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Post Display Page</title>
</head>
<body>
    <div align="center">
        <%
            // Fetch parameters from the request
            String patient = request.getParameter("patient");
            String mobile = request.getParameter("mobile");
            String blood = request.getParameter("blood");
            String email = request.getParameter("email");
            String disease = request.getParameter("disease");
            String city = request.getParameter("city");
            String age = request.getParameter("age");
            String address = request.getParameter("address");
            String dob = request.getParameter("dob");
            String code = request.getParameter("code");
            String gender = request.getParameter("gender");
            String textarea = request.getParameter("textarea");
            int id = Integer.parseInt(request.getParameter("id"));

            try {
                // File path for storing digital signature
                ServletContext context = getServletContext();
                String filePath = context.getRealPath("DigitalSignatures/filename.txt");

                // Ensure directory exists
                File directory = new File(context.getRealPath("DigitalSignatures"));
                if (!directory.exists()) {
                    directory.mkdirs();
                }

                // Write textarea contents to the file
                try (FileOutputStream fos = new FileOutputStream(filePath);
                     PrintStream ps = new PrintStream(fos)) {
                    ps.print(textarea);
                }

                // Generate digital signature
                MessageDigest md = MessageDigest.getInstance("SHA-1");
                try (FileInputStream fis = new FileInputStream(filePath);
                     DigestInputStream dis = new DigestInputStream(fis, md)) {
                    while (dis.read() != -1) {
                        // Process the file contents
                    }
                }

                String digitalSignature = new BigInteger(1, md.digest()).toString(16);

                // Encode sensitive data using Base64
                String patientEncoded = Base64.getEncoder().encodeToString(patient.getBytes());
                String emailEncoded = Base64.getEncoder().encodeToString(email.getBytes());
                String mobileEncoded = Base64.getEncoder().encodeToString(mobile.getBytes());
                String bloodEncoded = Base64.getEncoder().encodeToString(blood.getBytes());
                String diseaseEncoded = Base64.getEncoder().encodeToString(disease.getBytes());
                String cityEncoded = Base64.getEncoder().encodeToString(city.getBytes());
                String ageEncoded = Base64.getEncoder().encodeToString(age.getBytes());
                String addressEncoded = Base64.getEncoder().encodeToString(address.getBytes());
                String dobEncoded = Base64.getEncoder().encodeToString(dob.getBytes());
                String codeEncoded = Base64.getEncoder().encodeToString(code.getBytes());
                String genderEncoded = Base64.getEncoder().encodeToString(gender.getBytes());
                String textareaEncoded = Base64.getEncoder().encodeToString(textarea.getBytes());
                String signatureEncoded = Base64.getEncoder().encodeToString(digitalSignature.getBytes());

                // Update patient details in the database
                String updateQuery = "UPDATE patients SET patientname = ?, email = ?, mobile = ?, bloodgroup = ?, disease = ?, " +
                        "city = ?, age = ?, address = ?, dob = ?, pincode = ?, gender = ?, contents = ?, digital_sign = ? WHERE id = ?";
                try (PreparedStatement psUpdate = connection.prepareStatement(updateQuery)) {
                    psUpdate.setString(1, patientEncoded);
                    psUpdate.setString(2, emailEncoded);
                    psUpdate.setString(3, mobileEncoded);
                    psUpdate.setString(4, bloodEncoded);
                    psUpdate.setString(5, diseaseEncoded);
                    psUpdate.setString(6, cityEncoded);
                    psUpdate.setString(7, ageEncoded);
                    psUpdate.setString(8, addressEncoded);
                    psUpdate.setString(9, dobEncoded);
                    psUpdate.setString(10, codeEncoded);
                    psUpdate.setString(11, genderEncoded);
                    psUpdate.setString(12, textareaEncoded);
                    psUpdate.setString(13, signatureEncoded);
                    psUpdate.setInt(14, id);

                    int updateResult = psUpdate.executeUpdate();
                    if (updateResult > 0) {
        %>
                        <p align="center" class="style46">Patient Details Updated Successfully.</p>
                        <p align="center"><a href="DO_EditPatients.jsp">Back</a></p>
        <%
                    } else {
        %>
                        <p align="center" class="style46">Patient Details Update Failed.</p>
                        <p align="center"><a href="DO_EditPatients.jsp">Back</a></p>
        <%
                    }
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>
    </div>
</body>
</html>
