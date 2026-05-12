<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Adding Patients Status..</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/cufon-yui.js"></script>
    <script type="text/javascript" src="js/arial.js"></script>
    <script type="text/javascript" src="js/cuf_run.js"></script>
    <style type="text/css">
        .style3 { color: #999900; font-size: 15px; }
        .style11 { font-size: 25px; color: #00CC00; }
        .style26 { color: #FF00FF; }
        .style1 { font-size: 25px; }
        .style33 { color: #0000FF; }
        .style28 { font-size: 13px; }
        .style43 { color: #FFCC00; }
        .style44 { color: #FF0000; }
        .style46 { color: #6633FF; font-weight: bold; }
        .style47 { color: #FF0000; font-weight: bold; }
    </style>
</head>
<body>
<!-- START PAGE SOURCE -->
<div class="main">
    <div class="header">
        <div class="header_resize">
            <div class="logo style3">
               <marquee><h1 align="center" class="style11"><b>Predicting Hospital Admissions From Emergency Department</b></h1></marquee>
            </div>
            <div class="menu_nav">
                <ul>
                    <li><a href="index.html"><strong>Home</strong></a></li>
                    <li class="active"><a href="DO_Login.jsp"><strong>Data Holder</strong></a></li>
                    <li><a href="AdminLogin.jsp"><strong>Healthcare Server</strong></a></li>
                    <li><a href="UserLogin.jsp"><strong>Data Analyzer</strong></a></li>
                </ul>
            </div>
            <div class="clr"></div>
        </div>
    </div>
    <div class="hbg">&nbsp;</div>
    <div class="content">
        <div class="content_resize">
            <div class="mainbar">
                <div class="article">
                    <h2><span class="style33 style1 style26">Adding Patients Status..</span></h2>
                    <div class="clr"></div>
                    <%@ include file="connect.jsp" %>
                    <%@ page import="java.util.*" %>
                    <%@ page import="java.sql.*" %>
                    <%@ page import="java.text.*" %>
                    <%@ page import="java.io.*" %>
                    <%@ page import="com.oreilly.servlet.MultipartRequest" %>
                    <%@ page import="java.security.MessageDigest" %>
                    <%@ page import="java.math.BigInteger" %>
                    <%
                        // Initialize variables
                        String name = "", blood = "", disease = "", age = "", dob = "", gender = "", mobile = "";
                        String email = "", city = "", address = "", code = "", fname = "", textarea = "";
                        String Hb = null, Bp = null, paramName = null, digitalSign = null;

                        try {
                            ServletContext context = getServletContext();
                            String dirName = context.getRealPath("Gallery/");

                            MultipartRequest multi = new MultipartRequest(request, dirName, 10 * 1024 * 1024);

                            // Get parameters
                            Enumeration params = multi.getParameterNames();
                            while (params.hasMoreElements()) {
                                paramName = (String) params.nextElement();
                                switch (paramName) {
                                    case "name": name = multi.getParameter(paramName); break;
                                    case "blood": blood = multi.getParameter(paramName); break;
                                    case "disease": disease = multi.getParameter(paramName); break;
                                    case "age": age = multi.getParameter(paramName); break;
                                    case "dob": dob = multi.getParameter(paramName); break;
                                    case "gender": gender = multi.getParameter(paramName); break;
                                    case "mobile": mobile = multi.getParameter(paramName); break;
                                    case "email": email = multi.getParameter(paramName); break;
                                    case "city": city = multi.getParameter(paramName); break;
                                    case "address": address = multi.getParameter(paramName); break;
                                    case "code": code = multi.getParameter(paramName); break;
                                    case "fname": fname = multi.getParameter(paramName); break;
                                    case "textarea": textarea = multi.getParameter(paramName); break;
                                    case "Hb": Hb = multi.getParameter(paramName); break;
                                    case "Bp": Bp = multi.getParameter(paramName); break;
                                }
                            }

                            // Validate input
                            if (name.isEmpty() || blood.isEmpty() || disease.isEmpty() || age.isEmpty() || dob.isEmpty() ||
                                gender.equals("--Select--") || mobile.isEmpty() || email.isEmpty() || city.isEmpty() || 
                                address.isEmpty() || code.isEmpty() || fname.isEmpty() || textarea.isEmpty()) {
                    %>
                            <p align="center" class="style44"><strong>Please Enter All Details..</strong></p>
                            <p align="center"><a href="DO_AddPatientDetails.jsp" class="style11 style33 style28"><strong>Back</strong></a></p>
                    <%
                            } else {
                                // Check if patient already exists
                                String query = "SELECT * FROM patients WHERE patientname = ? AND email = ?";
                                PreparedStatement psCheck = connection.prepareStatement(query);
                                psCheck.setString(1, name);
                                psCheck.setString(2, email);
                                ResultSet rsCheck = psCheck.executeQuery();

                                if (rsCheck.next()) {
                    %>
                                    <p align="center" class="style44"><strong>Patient Details Already Exist!</strong></p>
                                    <p align="center"><a href="DO_AddPatientDetails.jsp" class="style11 style33 style28"><strong>Back</strong></a></p>
                    <%
                                } else {
                                    // Generate Digital Signature
                                    MessageDigest md = MessageDigest.getInstance("SHA1");
                                    md.update(textarea.getBytes());
                                    digitalSign = new BigInteger(1, md.digest()).toString(16);

                                    // Insert patient details
                                    String insertQuery = "INSERT INTO patients(owner, patientname, bloodgroup, disease, age, dob, gender, mobile, email, city, address, pincode, fname, contents, digital_sign, date, Hb, Bp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?)";
                                    PreparedStatement psInsert = connection.prepareStatement(insertQuery);
                                    psInsert.setString(1, (String) application.getAttribute("oname"));
                                    psInsert.setString(2, name);
                                    psInsert.setString(3, blood);
                                    psInsert.setString(4, disease);
                                    psInsert.setString(5, age);
                                    psInsert.setString(6, dob);
                                    psInsert.setString(7, gender);
                                    psInsert.setString(8, mobile);
                                    psInsert.setString(9, email);
                                    psInsert.setString(10, city);
                                    psInsert.setString(11, address);
                                    psInsert.setString(12, code);
                                    psInsert.setString(13, fname);
                                    psInsert.setString(14, textarea);
                                    psInsert.setString(15, digitalSign);
                                    psInsert.setString(16, Hb);
                                    psInsert.setString(17, Bp);

                                    int result = psInsert.executeUpdate();
                                    if (result > 0) {
                    %>
                                        <p align="center" class="style46">Patient Details Uploaded Successfully!</p>
                                        <p align="center"><a href="DO_AddPatientDetails.jsp" class="style11 style33 style28"><strong>Back</strong></a></p>
                    <%
                                    } else {
                    %>
                                        <p align="center" class="style47">Failed to Upload Patient Details..!!</p>
                                        <p align="center"><a href="DO_AddPatientDetails.jsp" class="style11 style33 style28"><strong>Back</strong></a></p>
                    <%
                                    }
                                }
                            }
                        } catch (Exception e) {
                            out.println("<p>Error: " + e.getMessage() + "</p>");
                        }
                    %>
                </div>
            </div>
            <div class="sidebar">
                <!-- Sidebar content -->
            </div>
        </div>
    </div>
    <div class="footer"></div>
</div>
<!-- END PAGE SOURCE -->
</body>
</html>
