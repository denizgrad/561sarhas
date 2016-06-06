<%-- //[START all]--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%-- //[START imports]--%>
<%-- //[END imports]--%>

<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<style>
.sarhasBody {
	padding-top: 70px;
}
</style>
<meta content="text/html; charset=UTF-8">
<title>Incidents</title>

<script src="js/angular/1.5.3/angular.min.js"></script>
<link href="css/lib/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet"
	media="screen">
<script type="text/javascript"
	src="js/jquery/1.12.3/jquery-1.12.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap/3.3.6/bootstrap.min.js"></script>

<link rel="styleSheet"
	href="css/lib/angular/ui-grid/3.1.1/ui-grid.min.css" />
<script type="text/javascript"
	src="js/angular/ui-grid/3.1.1/ui-grid.min.js"></script>

<script
	src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-animate.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-aria.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-messages.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.0-rc2/angular-material.min.js"></script>

<link rel="stylesheet"
	href="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.0-rc2/angular-material.min.css">
<script src="js/incidentController.js"></script>

</head>
<body ng-app="incidentModule">
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
        pageContext.setAttribute("user", user);
    } else {
    	System.out.println(request.getContextPath()+"login.jsp");
    	response.sendRedirect(request.getContextPath()+"login.jsp");
    }
%>

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#navbar" aria-expanded="true" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Sarhas, ${fn:escapeXml(user.nickname)}</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse in"
				aria-expanded="true">
				<ul class="nav navbar-nav">
					<li class="active"><a href="/incidentSave.jsp">Incidents</a></li>
					<li><a href="/healthCare.jsp">Health Care</a></li>
					<li><a href="/humanresource.jsp">Human Resources</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>

	<div class="sarhasBody container">
		<div ng-controller="incidentCtrl">
			<div class="col-lg-12">
				<div class="col-lg-4">
					<p>
						Click <a ng-click="listAll()">here</a> to load data.
					</p>
					<div ui-grid="gridOptions" class="incidentList"></div>
				</div >	
				<div class="col-lg-8">	
					<form name="form" role="form">
						<fieldset>
							<label class="col-sm-2 control-label" for="type">Incident
								Type</label>
							<div class="col-sm-4">
								<select ng-model="type" ng-init="type = '1'"
									class="form-control input-sm">
									<option value="1">Animal Rescue</option>
									<option value="2">Urban SAR</option>
									<option value="3">Ground SAR</option>
								</select>
							</div>
						</fieldset>
					</form>
					<hr>
					<form name="animalRescueForm" ng-submit="save(form)" role="form">
						<div ng-show="type == 1">
							<fieldset class="form-group">
								<div class="row">
									<!-- <label class="col-sm-2 control-label" for="field1">Field1</label> -->
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="animalRescue.id" ng-show="false" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="title">Title</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="animalRescue.title" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="animalType">Animal Type</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="animalRescue.animalType" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="condition">Condition</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="animalRescue.condition" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="where">Where</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="animalRescue.where" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="date">Date</label>
									<md-datepicker class="col-sm-4 " ng-model="animalRescue.date"
										md-placeholder="Enter date"></md-datepicker>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="location">Location</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="animalRescue.location" />
									</div>
								</div>
								<!-- <div class="row">
									<label class="col-sm-2 control-label" for="completed">Completed</label>
									<div class="col-sm-4">
										<select ng-model="incident.completed" ng-init="type = '1'"
											class="form-control input-sm">
											<option value="false">Finished</option>
											<option value="true">Going on</option>
										</select>
									</div>
								</div> -->
								<div class="row">
									<button type="submit" class="btn btn-info">Save</button>
								</div>
							</fieldset>
						</div>
					</form>
					<form name="urbanForm" ng-submit="save(form)" role="form">
						<div ng-show="type == 2">
							<fieldset class="form-group">
								<div class="row">
									<!-- <label class="col-sm-2 control-label" for="field1">Field1</label> -->
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.id" ng-show="false" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="title">Title</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.title" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="earthquake">Earthquake</label>
									<div class="col-sm-4">
										<select ng-model="urban.earthquake" ng-init="type = '1'"
											class="form-control input-sm">
											<option value="false">No</option>
											<option value="true">Yes</option>
										</select>
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="latitude">Latitude</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.latitude" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="longitude">Longitude</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.longitude" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="country">Country</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.country" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="city">City</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.city" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="village">Village</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.village" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="depth">Depth</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.depth" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="magnitude">Magnitude</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.magnitude" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="date">Date</label>
									<md-datepicker class="col-sm-4 " ng-model="urban.date"
										md-placeholder="Enter date"></md-datepicker>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="location">Location</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.location" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="quantity">Possible Wreckage Quantity</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.quantity" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="buildingType">Building Types</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.buildingType" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="population">Human Population</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="urban.population" />
									</div>
								</div>
								<div class="row">
									<button type="submit" class="btn btn-info">Save</button>
								</div>
							</fieldset>
						</div>
					</form>
					<form name="groundForm" ng-submit="save(form)" role="form">
						<div ng-show="type == 3">
							<fieldset class="form-group">
								<div class="row">
									<!-- <label class="col-sm-2 control-label" for="field1">Field1</label> -->
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="ground.id" ng-show="false" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="title">Title</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="ground.title" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="intelligenceSource">Intelligence Source</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="ground.intelligenceSource" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="contactInfo">Subject Contact Information</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="ground.contactInfo" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="physicalInfo">Subject Physical Information</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="ground.physicalInfo" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="clothingInfo">Subject Clothing Information</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="ground.clothingInfo" />
									</div>
								</div>
								<div class="row">
									<label class="col-sm-2 control-label" for="lastSeenDescription">Last Seen Description</label>
									<div class="col-sm-4">
										<input type="text" class="form-control input-sm"
											ng-model="ground.lastSeenDescription" />
									</div>
								</div>
								<div class="row">
									<button type="submit" class="btn btn-info">Save</button>
								</div>
							</fieldset>
						</div>
					</form>
					<p>
						<a ng-click="clear()">Clear</a> for New Record
					</p>
				</div>
			</div>	
		</div>
	</div>
	<!-- container -->


</body>
</html>