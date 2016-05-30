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

<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#navbar" aria-expanded="true" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">Sarhas</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse in"
			aria-expanded="true">
			<ul class="nav navbar-nav">
				<li><a href="#">Users</a></li>
				<li><a href="#about">Incidents</a></li>
				<li><a href="#contact">Human Resources</a></li>
			</ul>
		</div>
		<!--/.nav-collapse -->
	</div>
</nav>

	<div class="sarhasBody container">
		<div ng-controller="incidentCtrl">
			<form name="form" role="form">
				<fieldset>
					<label class="col-sm-2 control-label" for="type">Incident
						Type</label>
					<div class="col-sm-4">
						<select ng-model="type" ng-init="type = '1'"
							class="form-control input-sm">
							<option value="1">Incident Rescue</option>
							<option value="2">Emergency</option>
						</select>
					</div>
				</fieldset>
			</form>
            <hr>
			<form name="form" ng-submit="save(form)" role="form">
				<div ng-show="type == 1">
					<fieldset class="form-group">
						<div class="row">
							<!-- <label class="col-sm-2 control-label" for="field1">Field1</label> -->
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									ng-model="incident.id" ng-show="false" />
							</div>
						</div>
						<div class="row">
							<label class="col-sm-2 control-label" for="title">Title</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									ng-model="incident.title" />
							</div>
						</div>
						<div class="row">
							<label class="col-sm-2 control-label" for="completed">Completed</label>
							<div class="col-sm-4">
								<select ng-model="incident.completed" ng-init="type = '1'"
									class="form-control input-sm">
									<option value="false">Finished</option>
									<option value="true">Going on</option>
								</select>
							</div>
						</div>
						<div class="row">
							<label class="col-sm-2 control-label" for="incidentTime">Incident
								Time</label>
							<md-datepicker class="col-sm-4 " ng-model="incident.incidentDate"
								md-placeholder="Enter date"></md-datepicker>
						</div>
						<div class="row">
							<button type="submit" class="btn btn-info">Save</button>
						</div>
					</fieldset>
				</div>
			</form>
			<form name="form" ng-submit="save(form)" role="form">
				<div ng-show="type == 2">
					<fieldset class="form-group">
						<div class="row">
							<!-- <label class="col-sm-2 control-label" for="field1">Field1</label> -->
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									ng-model="incident.id" ng-show="false" />
							</div>
						</div>
						<div class="row">
							<label class="col-sm-2 control-label" for="title">Title</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm"
									ng-model="incident.title" />
							</div>
						</div>
						<div class="row">
							<label class="col-sm-2 control-label" for="dangerous">Dangereous</label>
							<div class="col-sm-4">
								<select ng-model="incident.dangerous" ng-init="type = '1'"
									class="form-control input-sm">
									<option value="false">No</option>
									<option value="true">Yes</option>
								</select>
							</div>
						</div>
						<div class="row">
							<label class="col-sm-2 control-label" for="incidentDate">Incident
								Time</label>
							<md-datepicker class="col-sm-4 " ng-model="incident.incidentDate"
								md-placeholder="Enter date"></md-datepicker>
						</div>
						<div class="row">
							<button type="submit" class="btn btn-info">Save</button>
						</div>
					</fieldset>
				</div>
			</form>
			<p>Click <a ng-click="listAll()">here</a> to load data.</p>
			<div ui-grid="gridOptions" class="incidentList"></div>
		</div>
	</div><!-- container -->


</body>
</html>