var hrApp = angular.module("hcModule", [ 'ngMaterial', 'ui.grid']);

hrApp.controller("hcCtrl", function($scope, $http, $window) {
//	var site = "";
	var site = "https://metu561sarhas.appspot.com";
	var selectedPersonel = {};
	var me = this;
	/*
	 * scrollbar
	 *     height: 150px;
    overflow-y: scroll
	 * */
	$scope.setAllDisabled = true;

	//$scope.names = "qwertyuoasdfghjklzxcvbnmö".split("");
	
	$scope.asd = function (personel) {
		debugger;
		
		$scope.bloodtype = personel.properties.bloodtype;
		$scope.antihavigg = personel.properties.antihavigg;
		$scope.antihbs = personel.properties.antihbs;
		$scope.antihcv = personel.properties.antihcv;
		$scope.antihiv = personel.properties.antihiv;
		$scope.hbs = personel.properties.hbs;
		$scope.docsInterpreps = personel.properties.docsInterpreps;
		
		$scope.selectPersonel(personel);
	}
	
	
	
	$scope.selectPersonel = function (personel) {
		
		debugger;
		for(var i in $scope.names){
			$scope.names[i].selected = false ;
		}
		personel.selected = true;
		
		me.selectedPersonel = personel;
		me.selectedPersonel.isNew = false;
		
	}
	
	$scope.listAll = function() {
		var obj = {};
		$http({
			method : 'GET',
			url : site+'/_ah/api/incident/v1/listAllPersonel',
		}).then(function(resp) {
			
			
			
			debugger;
			$scope.names  = resp.data.items;
			alert("Done");
		}, function() {
			alert("An error occured during post request");
		});
	}
	$scope.listAll();
	
	$scope.savePersonelHcInfo = function() {
		debugger;
			var personelHcInfo ={};
			personelHcInfo.bloodtype=$scope.bloodtype;
			personelHcInfo.antihavigg=$scope.antihavigg;
			personelHcInfo.antihbs=$scope.antihbs;
			personelHcInfo.antihcv=$scope.antihcv;
			personelHcInfo.antihiv=$scope.antihiv;
			personelHcInfo.hbs=$scope.hbs;
			personelHcInfo.docsInterpreps=$scope.docsInterpreps;
			personelHcInfo.name=me.selectedPersonel.properties.name;
		
		
		$http({
			method : 'GET',
			url : site+'/_ah/api/incident/v1/savePersonelHcInfo?personelHcInfo='+JSON.stringify(personelHcInfo),
//			data : {
//				personelHcInfo : JSON.stringify(personelHcInfo)
//			}
		}).then(function() {
			$window.location.reload();
			
		}, function() {
			alert("An error occured during post request");
		});
	}
	
	
	$scope.editPersonel = function () {
		$scope.setAllDisabled = false;
	}
	
	
});