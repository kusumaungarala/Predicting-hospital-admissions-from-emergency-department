<%@page import="java.security.SecureRandom"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Owner Registration Page</title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="js/cufon-yui.js"></script>
    <script type="text/javascript" src="js/arial.js"></script>
    <script type="text/javascript" src="js/cuf_run.js"></script>
    <style type="text/css">
    
        .style3 {
            color: #999900;
            font-size: 15px;
        }
        .style11 {
            font-size: 25px;
            color: blue;
        }
        .style21 {
            color: #0000FF;
            font-weight: bold;
        }
        .style22 {
            color: #00CC00;
        }
        .style40 {
            color: maroon;
            font-weight: bold;
        }
        .style43 {
            color: blue;
            font-size: 25px;
        }
    </style>
</head>
<body>
    <div class="main">
        <div class="header">
            <div class="header_resize">
                <div class="logo style3">
                    <marquee><p align="center" class="style11"><b>Predicting Hospital Admissions From Emergency Department</b></p></marquee>
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
        <div class="hbg"></div>
        <div class="content">
            <div class="content_resize">
                <div class="mainbar">
                    <div class="article">
                        <h2><span class="style43">Welcome To Data Owner mobile number verification.....</span></h2>
                       
                        <div class="clr"></div>
                       <form method="post">
        <label for="mobile">Mobile Number :</label>
        <input id="mobile" name="mobile" class="text" value="<%= request.getParameter("mobile") != null ? request.getParameter("mobile") : "" %>" />
        <input type="submit" name="action" value="GenerateOTP" /><br><br>
   
        <label for="otp">Enter OTP:</label>
        <input id="otp" name="otp" class="text" value="<%= request.getParameter("otp") != null ? request.getParameter("otp") : "" %>" />
        <input type="submit" name="action" value="VerifyOTP" />
    </form>

    <% 
        String action = request.getParameter("action");
        String mobile = request.getParameter("mobile");
        String otp = request.getParameter("otp");

        if ("GenerateOTP".equals(action)) {
            if (mobile != null && !mobile.isEmpty()) {
                if (checkdbMobile(mobile)) {
                    String generatedOtp = GenerateOTP(6);

                    boolean otpStored = storeOtpInDatabase(mobile, generatedOtp);

                    if (otpStored) {
                        session.setAttribute("generatedOtp", generatedOtp);
                        session.setAttribute("mobile", mobile);
                        %>
                        <script type="text/javascript">
                            alert("Your OTP send successfully");
                        </script>
                        <%
                    } else {
                        out.println("Failed to store OTP in the database.");
                    }
                } else {
                    out.println("Mobile number not registered.");
                }
            } else {
                out.println("Mobile number is required.");
            }
        } else if ("VerifyOTP".equals(action)) {
            if (mobile != null && !mobile.isEmpty() && otp != null && !otp.isEmpty()) {
                String storedOtp = (String) session.getAttribute("generatedOtp");
                String storedMobile = (String) session.getAttribute("mobile");
                
                if (storedOtp != null && storedMobile != null && storedOtp.equals(otp) && storedMobile.equals(mobile)) {
                    out.println("<p>OTP Verified Successfully. Redirecting to login page...</p>");
                    response.sendRedirect("DO_Main.jsp");  
                } else {
                    out.println("<p>Invalid OTP or Mobile number. Please try again.</p>");
                }
            } else {
                out.println("<p>Please enter both mobile number and OTP.</p>");
            }
        }
    %>
    
</body>
</html>

<%! 
    private String GenerateOTP(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otp.append(random.nextInt(10));
        }
        return otp.toString();
    }

    // Method to check if the mobile number exists in the database
    private boolean checkdbMobile(String mobile) {
        boolean existingMobile = false;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Using_DataMining", "root", "root");
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM owner WHERE mobile=?");
            pst.setString(1, mobile);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                existingMobile = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return existingMobile;
    }

    // Method to store OTP in the database
    private boolean storeOtpInDatabase(String mobile, String otp) {
        boolean success = false;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Using_DataMining", "root", "root");
            PreparedStatement pst = conn.prepareStatement("UPDATE owner SET otp=? WHERE mobile=?");
            pst.setString(1, otp);  
            pst.setString(2, mobile);  
            
            int rowsAffected = pst.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
%>

                        <p align="right"><a href="index.html" class="style21">Back</a></p>
                    </div>
                </div>
                <div class="sidebar">
                    <div class="gadget">
                        <h2 class="star"><span>Sidebar</span> Menu</h2>
                        <div class="clr"></div>
                        <ul class="sb_menu">
                            <li>
                                <p><a href="DO_Register.jsp">Home</a></p>
                                <p><a href="DO_Login.jsp">Owner Login</a></p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="clr"></div>
            </div>
        </div>
        <div class="fbg"></div>
        <div class="footer"></div>
    </div>
</body>
</html>
