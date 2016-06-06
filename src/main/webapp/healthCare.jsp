<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>


<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Health Care</title>
<script src="js/angular/1.5.3/angular.min.js"></script>
<link href="css/lib/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="js/jquery/1.12.3/jquery-1.12.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap/3.3.6/bootstrap.min.js"></script>

<link rel="styleSheet" href="css/lib/angular/ui-grid/3.1.1/ui-grid.min.css" />
<script type="text/javascript" src="js/angular/ui-grid/3.1.1/ui-grid.min.js"></script>

<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-animate.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-aria.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-messages.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.0-rc2/angular-material.min.js"></script>
<style>
.sarhasBody {
	padding-top: 70px;
}
</style>
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.0-rc2/angular-material.min.css">
<script src="js/hcController.js"></script>
</head>
<body ng-app="hcModule" ng-controller="hcCtrl">
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
					<li class="active"><a href="/healthCare.jsp">Health Care</a></li>
					<li><a href="/humanresource.jsp">Human Resources</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>
	<div class="sarhasBody">

		<div class="col-sm-4">

			<div class="col-sm-11" style="border: 1px solid black">
				
	
				<div style="overflow-y: scroll; height:500px">
					<ul class="list-group"">
						<li ng-repeat="name in names" ng-class = "name.selected ? 'active' : ''" class="list-group-item" ng-dblclick ="asd(name)" nc-click ="selectPersonel(name)">{{name.properties.name}} {{name.properties.surname
							}}</li>
	
					</ul>
				</div>
				
				<fieldset class="form-group">
	
	
					<label class="col-sm-0"></label>
					<div class="col-sm-12">
	
						<button type="submit" class="form-control input-sm"
							ng-click="editPersonel()">EDIT</button>
					</div>
				</fieldset>
			</div>
			
			<div class="col-sm-1">
			</div>
		
		
		</div>

		<div class="col-sm-8" style="border: 1px solid black">
		
		
			<fieldset class="form-group">
						<legend align="center">PERSONNEL HEALTH INFORMATION PAGE</legend>
						
			</fieldset>
		
			<fieldset class="form-group">
				<label class="col-sm-6">BLOOD TYPE</label>
				<div class="col-sm-6">
					<select ng-model="bloodtype" ng-init="type = '1'"
									class="form-control input-sm" ng-disabled = "setAllDisabled">
									<option value="A+">A(+)</option>
									<option value="A-">A(-)</option>
									<option value="B+">B(+)</option>
									<option value="B-">B(-)</option>
									<option value="AB+">AB(+)</option>
									<option value="AB-">AB(-)</option>
									<option value="0+">0(+)</option>
									<option value="0-">0(-)</option>
					</select>
				</div>
			</fieldset>
			
			<fieldset class="form-group">
				<label class="col-sm-6">Anti HAV IgG</label>
				<div class="col-sm-6">
					<select ng-model="antihavigg" ng-init="type = '1'"
									class="form-control input-sm" ng-disabled = "setAllDisabled">
									<option value="true">Yes</option>
									<option value="false">No</option>
					</select>
				</div>
			</fieldset>
			
			<fieldset class="form-group">
				<label class="col-sm-6">Anti HBs</label>
				<div class="col-sm-6">
					<select ng-model="antihbs" ng-init="type = '1'"
									class="form-control input-sm" ng-disabled = "setAllDisabled">
									<option value="true">Yes</option>
									<option value="false">No</option>
					</select>
				</div>
			</fieldset>
			
			<fieldset class="form-group">
				<label class="col-sm-6">Anti HCV</label>
				<div class="col-sm-6">
					<select ng-model="antihcv" ng-init="type = '1'"
									class="form-control input-sm" ng-disabled = "setAllDisabled">
									<option value="true">Yes</option>
									<option value="false">No</option>
					</select>
				</div>
			</fieldset>
			
			<fieldset class="form-group">
				<label class="col-sm-6">Anti HIV</label>
				<div class="col-sm-6">
					<select ng-model="antihiv" ng-init="type = '1'"
									class="form-control input-sm" ng-disabled = "setAllDisabled">
									<option value="true">Yes</option>
									<option value="false">No</option>
					</select>
				</div>
			</fieldset>
			
			<fieldset class="form-group">
				<label class="col-sm-6">HBs</label>
				<div class="col-sm-6">
					<select ng-model="hbs" ng-init="type = '1'"
									class="form-control input-sm" ng-disabled = "setAllDisabled">
									<option value="true">Yes</option>
									<option value="false">No</option>
					</select>
				</div>
			</fieldset>
			
			<fieldset class="form-group">
				<label class="col-sm-6">DOCTORS INTERPRETATIONS</label>
				<div class="col-sm-6">
					<input type="text" class="form-control input-xlg" ng-model="docsInterpreps" ng-disabled = "setAllDisabled" />
				</div>
			</fieldset>
			
			<fieldset class="form-group">


				<label class="col-sm-8"></label>
				<div class="col-sm-4">

					<button type="submit" class="form-control input-sm" ng-click="savePersonelHcInfo()">
						SAVE</button>
				</div>
			</fieldset>
		</div>


	
	</div>
</body>
</html>