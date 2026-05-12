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
            font-size: 30px;
            color: skyblue;
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
                        <h2><span class="style43">Welcome To Data Owner Registration</span></h2>
                        <p><img src="images/Register.jpg" width="200" height="88" alt="Registration Image"/></p>
                        <div class="clr"></div>
                       <form method="post" action="OwnerRegisterAuthentication.jsp" enctype="multipart/form-data">

                          
                            <p class="style40">
                                User Name :<input type="text" class="text" name="userid" required="required"/><br><br>
                            </p>

                            <p class="style40">
                                Password :<input name="pass" type="password" required="required" /><br><br>
                            </p>

                            
                            <p class="style40">
                               Email Address: <input name="email" type="email"  required="required" /><br><br>
                            </p>

                       
                            <p class="style40">
                                Mobile Number:<input name="mobile" type="text"  required="required"/><br><br>
                            </p>

                            
                            <p class="style40">
                               Your Address : <textarea type="text" name="address" rows="2" cols="30"></textarea><br><br>
                            </p>

                            
                            <p class="style40">
                                Date of Birth:<input name="dob" type="date"  required="required" /><br><br>
                            </p>

                           
                            <p class="style40">
                               Select Gender : <select id="gender" name="gender" class="text" required="required">
                                    <option value="">--Select--</option>
                                    <option value="MALE">MALE</option>
                                    <option value="FEMALE">FEMALE</option>
                                </select>
                            </p>

                           
                            <p class="style40">
                               Select Profile Picture: <input type="file" name="pic" accept="image/*"  required="required"/><br><br>
                            </p>

                            <p>
                                <input name="submit" type="submit" value="REGISTER" />
                            </p>
                        </form>
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
