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
<meta charset="UTF-8">
<title>Human Resources</title>
<style>
.sarhasBody {
	padding-top: 70px;
}
</style>
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
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-animate.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-aria.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-messages.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.0-rc2/angular-material.min.js"></script>

<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.0-rc2/angular-material.min.css">
<script src="js/hrController.js"></script>
</head>
<body ng-app="hrModule" ng-controller="hrCtrl">
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
        pageContext.setAttribute("user", user);
    }else {
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
					<li><a href="/incidentSave.jsp">Incidents</a></li>
					<li><a href="/healthCare.jsp">Health Care</a></li>
					<li class = "active"><a href="/humanresource.jsp">Human Resources</a></li>
					<li><a style="font-style: italic;" href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>
<div class="sarhasBody">
	<div class="col-sm-12">

		<div class="col-sm-2">

			<div style="overflow-y: scroll; height: 400px">
				<ul class="list-group"">
					<li ng-repeat="name in names"
						ng-class="name.selected ? 'active' : ''" class="list-group-item"
						ng-dblclick="asd(name)" nc-click="selectPersonel(name)">{{name.properties.name}}
						{{name.properties.surname }}</li>

				</ul>
			</div>
			<fieldset class="form-group">



				<div class="col-sm-12">

					<button type="submit" class="form-control input-sm"
						ng-click="addPersonel()">Add</button>
				</div>
			</fieldset>
			<fieldset class="form-group">


				<label class="col-sm-0"></label>
				<div class="col-sm-12">

					<button type="submit" class="form-control input-sm"
						ng-click="editPersonel()">Edit</button>
				</div>
			</fieldset>
			<fieldset class="form-group">


				<label class="col-sm-0"></label>
				<div class="col-sm-12">

					<button type="submit" class="form-control input-sm"
						ng-click="deletePersonel()">Delete</button>
				</div>
			</fieldset>
		</div>
		<div class="col-sm-10">

			<fieldset class="form-group">
				<legend align="center">PERSONNELS PAGE</legend>

			</fieldset>

			<div class="col-sm-6">


				<fieldset class="form-group">


					<label class="col-sm-4">Name</label>
					<div class="col-sm-8">
						<input type="text" class="form-control input-sm" ng-model="name"
							ng-disabled="setAllDisabled" />
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label class="col-sm-4">Surname</label>
					<div class="col-sm-8">
						<input type="text" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="surname" />
					</div>
				</fieldset>

				<fieldset class="form-group">
					<label class="col-sm-4">Idnumber</label>
					<div class="col-sm-8">
						<input type="text" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="idNumber" />
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label class="col-sm-4">Birthdate</label>
					<div class="col-sm-8">
						<input type="date" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="birthDate" />
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label class="col-sm-4">Phone(home)</label>
					<div class="col-sm-8">
						<input type="tel" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="homeNumber" />
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label class="col-sm-4">Phone(mobile)</label>
					<div class="col-sm-8">
						<input type="tel" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="mobileNumber" />
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label class="col-sm-4">Phone(Emergency1)</label>
					<div class="col-sm-8">
						<input type="tel" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="emergency1Number" />
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label class="col-sm-4">Phone(Emergency2)</label>
					<div class="col-sm-8">
						<input type="tel" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="emergency2Number" />
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label class="col-sm-4">E-mail(Personel)</label>
					<div class="col-sm-8">
						<input type="text" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="emailPersonel" />
					</div>
				</fieldset>
				<fieldset class="form-group">
					<label class="col-sm-4">E-mail(Organization)</label>
					<div class="col-sm-8">
						<input type="text" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="emailOrganization" />
					</div>
				</fieldset>
				<fieldset class="form-group">
			</div>


			<div class="col-sm-6">

				<fieldset class="form-group">


					<label class="col-sm-4">Personal Insurance</label>
					<div class="col-sm-8">
						<input type="text" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="personalInsurance" />
					</div>
				</fieldset>
				<fieldset class="form-group">


					<label class="col-sm-4">Passport Information</label>
					<div class="col-sm-8">
						<input type="text" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="passportInformation" />
					</div>
				</fieldset>

				<fieldset class="form-group">


					<label class="col-sm-4">Personal Information</label>
					<div class="col-sm-8">
						<input type="text" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="personalInformation" />
					</div>
				</fieldset>
				<fieldset class="form-group">


					<label class="col-sm-4">Foreign Language</label>
					<div class="col-sm-8">
						<input type="text" class="form-control input-sm"
							ng-disabled="setAllDisabled" ng-model="foreignLanguage" />
					</div>
				</fieldset>


				<fieldset class="form-group">


					<label class="col-sm-4"></label>
					<div class="col-sm-8">

						<button type="submit" contenteditable="false"
							ng-disabled="setAllDisabled" class="form-control input-sm"
							ng-click="savePersonel()">SAVE</button>
					</div>
				</fieldset>
			</div>
		</div>
	</div>
</div>
</body>
</html>