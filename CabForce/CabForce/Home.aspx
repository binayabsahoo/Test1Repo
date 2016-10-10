<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="CabForce.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>Home</title>
		<link rel="stylesheet" href="css/camera.css"/>
		<link rel="stylesheet" href="css/owl.carousel.css"/>
		<link rel="stylesheet" href="css/style.css"/>
		<script src="js/jquery.js"></script>
		<script src="js/jquery-migrate-1.2.1.js"></script>				
		<script src="js/jquery.equalheights.js"></script>		
		<script src="js/jquery.easing.1.3.js"></script>
		<script src="js/owl.carousel.js"></script>
		<script src="js/camera.js"></script>
				
		<script>
		    $(document).ready(function () {
		        jQuery('#camera_wrap').camera({
		            loader: false,
		            pagination: false,
		            minHeight: '444',
		            thumbnails: false,
		            height: '28.28125%',
		            caption: true,
		            navigation: true,
		            fx: 'mosaic'
		        });
		        $().UItoTop({ easingType: 'easeOutQuart' });
		    });
		</script>
		
	</head>
<body class="page1" id="top">
		<div class="main">
<!--==============================header=================================-->
			<header>
				<div class="menu_block ">
					<div class="container_12">
						<div class="grid_12">
							<nav class="horizontal-nav full-width horizontalNav-notprocessed">
								<ul class="sf-menu">
									<li class="current"><a href="Home.aspx">Home</a></li>
									<li><a href="Reservation.aspx">Reservation</a></li>
									<li><a href="#">AboutUs</a></li>
									<li><a href="SourceToDestination.aspx">LocationCharges</a></li>
									<li><a href="CalculatePrice.aspx">CalculatePrice</a></li>
                                    <li><a href="#">ContactUs</a></li>
                                    <li><a href="#"</a>ReservationReport</li>
                                    <li><a href="Settings.aspx">Settings</a></li>
                                    <li><a href="AdminLogin.aspx">AdminLogin</a></li>
								</ul>
								
							</nav>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<div class="container_12">
					<div class="grid_12">
						<h1>
							<a href="index.html">
								<img src="images/logo.png" alt="Your Happy Family"/>
							</a>
						</h1>
					</div>
				</div>
				<div class="clear"></div>
			</header>
			<div class="slider_wrapper ">
				<div id="camera_wrap" class="">
					<div data-src="images/slide.jpg" ></div>
					<div data-src="images/slide1.jpg" ></div>
					<div data-src="images/slide2.jpg"></div>
				</div>
			</div>
			<div class="container_12">
				<div class="grid_4">
					<div class="banner">
						<div class="maxheight">
							<div class="banner_title">
								<img src="images/icon1.png" alt=""/>
								<div class="extra_wrapper">Fast&amp;
									<div class="color1">Safe</div>
								</div>
							</div>
							Only properly licensed and insured cars and drivers. Be safe every step of the journey.
							<a href="#" class="fa fa-share-square"></a>
						</div>
					</div>
				</div>
				<div class="grid_4">
					<div class="banner">
						<div class="maxheight">
							<div class="banner_title">
								<img src="images/icon2.png" alt=""/>
								<div class="extra_wrapper">Cost 
									<div class="color1">Transparency</div>
								</div>
							</div>
							Get the full visibility in your travel program. See the full cost of the trip already before booking and include also taxi and transfer service costs in your travel reporting.
							<a href="#" class="fa fa-share-square"></a>
						</div>
					</div>
				</div>
				<div class="grid_4">
					<div class="banner">
						<div class="maxheight">
							<div class="banner_title">
								<img src="images/icon3.png" alt=""/>
								<div class="extra_wrapper">24/7 
									<div class="color1">Customer Service</div>
								</div>
							</div>
							You are never left alone. Cabforce 24/7 customer service helps passengers and agents all day and night.
							<a href="#" class="fa fa-share-square"></a>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			

			
		</div>
<!--==============================footer=================================-->
		<footer>
			<div class="container_12">
				<div class="grid_12">
					<div class="f_phone"><span>Call Us:</span> + 1800 559 6580</div>
					<div class="socials">
						<a href="#" class="fa fa-twitter"></a>
						<a href="#" class="fa fa-facebook"></a>
						<a href="#" class="fa fa-google-plus"></a>
					</div>
					<div class="copy">
						<div class="st1">
						<div class="brand">Tour<span class="color1">T</span>axi </div>
						&copy; 2014	| <a href="#">Privacy Policy</a> </div> Website designed by <a href="http://www.templatemonster.com/" rel="nofollow">TemplateMonster.com</a>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</footer>
		
	</body>
</html>
