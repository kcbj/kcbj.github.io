var kcbj = {
	price: 8,
	distanceLimit: 5000,
	distancePerOrder: 250,
	errorGeneral: 'Er ging iets fout. Probeer later nog eens.',
	errorDistance: 'Dit adres ligt te ver voor levering aan huis. Gelieve de paasontbijten zelf te komen afhalen aan de kantine.',
	errorAddress: 'Dit adres kennen we niet. Hier kunnen we dan ook niet leveren.',
}


function initMap() {
	// alert("initMap");
}

function submitForm() {
	if(isAfhaal()) {
		sendOrder();
	} else{
		calculateDistance();
	}
}

function calculateDistance() {
	var address = $('#street').val() + " " +  $('#number').val() + ", " + $('#zip').val() + " " + $('#city').val()
	var distanceService = new google.maps.DistanceMatrixService();
	var kantine = new google.maps.LatLng( 50.987692, 4.7809190000000115 );
	distanceService.getDistanceMatrix({
		origins: [kantine],
		destinations: [address],
		travelMode: 'DRIVING',
		avoidHighways: true,
		avoidTolls: true,
	}, distanceCallback);
}

function distanceCallback(response, status) {
	if(status == "OK") {
		try{
			var distance = response.rows[0].elements[0].distance.value;
			if(isDistanceGood(distance)) {
				sendOrder();
			} else{
				showError(kcbj.errorDistance);
			}
		}
		catch(err) {
			showError(kcbj.errorAddress);
		}
	} else{
		showError();
	}
}

function isDistanceGood(distance) {
	console.log(distance);
	var aantal = $('#aantal').val();
	return distance < kcbj.distanceLimit + aantal * kcbj.distancePerOrder;
}

function isAfhaal() {
	return $('input[name=transport]:checked').val() == "afhalen";
}

function showError(text) {
	$('#submit').removeAttr('disabled');
	$('#error-text').text(text == null ? kcbj.errorGeneral : text);
	$('#error').modal();
}

function sendOrder() {
	var order = {
		date: new Date().toISOString(),
		street: $('#street').val(),
		number: $('#number').val(),
		zip: $('#zip').val(),
		city: $('#city').val(),
		name: $('#name').val(),
		tel: $('#tel').val(),
		email: $('#email').val(),
		aantal: $('#aantal').val()
	}
	if(isAfhaal()){
		order.time = "Afhaal";
	} else{
		order.time = $('input[name=time]:checked').val();
	}

	$.ajax({
		url: "https://script.google.com/macros/s/AKfycbzGKR16g48vgZNgZhcAPvuwJiDoRPCRx9Ugm2RoSDUG0HFwFg/dev",
		data: {
			order: JSON.stringify(order)
		},
		dataType: "jsonp",
		success: successCallback,
		error: errorCallback
	});
}

function successCallback(response) {
	$('#submit').removeAttr('disabled');
	$("#form").hide();
	$("#result-success").show();
	$("#result-email").text(response.order.email);
	$("#result-bedrag").text((response.order.aantal * kcbj.price) + " euro");
	$("#result-mededeling").text(response.order.ogm);
}

function errorCallback(response) {
	showError(kcbj.errorGeneral);
}

$(document).ready(
	function() {
		$('#form').submit(function() {
			$('#submit').attr('disabled', true);
			$('#submit-error').hide();
			submitForm();
			event.preventDefault();
			event.stopPropagation();
		});
		$('#aantal').change(function() {
			$('#total').attr('value', (kcbj.price * $('#aantal').val()) + " euro")
		});
		$('input[type=radio][name=transport]').change(function() {
			if($(this).val() == "leveren") {
				$('#levering').show();
				$('#zip').attr('required', true);
				$('#city').attr('required', true);
				$('#street').attr('required', true);
				$('#number').attr('required', true);
				$('input[type=radio][name=time]').attr('required', true);
			} else{
				$('#levering').hide();
				$('#zip').removeAttr('required');
				$('#city').removeAttr('required');
				$('#street').removeAttr('required');
				$('#number').removeAttr('required');
				$('input[type=radio][name=time]').removeAttr('required');
			}
		});

		if(window.location.search.endsWith("dev")) {
			$('#name').val("Test");
			$('#email').val("litrik@gmail.com");
			$('#tel').val("016123456");
			$('#aantal').val("2");
			$('#zip').val("3130");
			$('#city').val("Betekom");
			$('#street').val("Beekstraat");
			$('#number').val("45");
		}

	}
);
