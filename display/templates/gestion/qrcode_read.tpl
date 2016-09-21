<script src="display/javascript/adapter.js"></script>
<script
	src="display/javascript/dwa012-html5-qrcode/lib/jsqrcode-combined.min.js"></script>
<script
	src="display/javascript/html5-qrcode.eq.js"></script>
	

<script>
$(document).ready(function() { 
	var destination = "object";

	var db = "{$db}";	
	function getDetail(uid, champ) {
		/*
		 * Retourne le detail d'un objet, par interrogation ajax
		 */
		var url = "index.php";
		var chaine ;
		var is_container = 0;
		if (champ == "container") {
			is_container = 1;
		}
		console.log("uid : " + uid);
		console.log("is_container : "+ is_container);
		$.ajax ( { url:url, method:"GET", data : { module:"objectGetDetail", uid:uid, is_container:is_container }, success : function ( djs ) {
			console.log("interrogation Json terminée");
			console.log("data recuperee depuis le serveur : " + djs);
			var data = [];
			for (elem in djs) {
			   data.push(djs[elem]);
			}
			//var data = $.parseJSON('"'+datajson+'"');
			console.log ("uid recupere : "+data[0]);
			console.log ("data.length : " + data.length );
			if (data != null) {
				console.log("traitement de data");
				if (!isNaN(data[0])) {
					console.log("uid recupere : "+ data[0]);
					var id = "", type="";
					if (data[1]) {
						id = data[1];
					}
					if (data[4]) {
						type = " (" + data[4]+")";
					}
					chaine = id + type ;
					console.log("Retour objectGetDetail : " + chaine);
					$("#"+champ+"_uid").val(data[0]);
					$("#"+champ+"_detail").val(chaine);
				} else {
					$("#"+champ+"_uid").val("");
					$("#"+champ+"_detail").val("");
				}
			}
		}
		} ); 
	}
	
	$("#container_uid").focusout(function () {
		getDetail($("#container_uid").val(), "container");
	});
	$("#container_search").click(function () {
		getDetail($("#container_uid").val(), "container");
	});
	$("#object_uid").focusout(function () {
		getDetail($("#object_uid").val(), "object");
	});
	$("#object_search").click(function () {
		getDetail($("#object_uid").val(), "object");
	});
	$("#valeur-scan").change(function () {
		console.log("#valeur-scan change. Value : " + $(this).val());
		readChange();
	});
	/*
	 * Fonctions pour la lecture du QRCode
	 */
	var is_read = false;
	var snd = new Audio("display/images/sound.ogg"); 
	function readChange() {
		//console.log("destination : "+destination);
		//console.log("valeur : "+ $("#valeur-scan").val());
		snd.play();
		var valeur = $("#valeur-scan").val();
		var value = extractUidVal(valeur);
		$("#" + destination +"_uid").val(value);
		getDetail(value, destination);
	}
	function extractUidVal(valeur) {
		/*
		 * Transformation des [] en { }
		 */
		 valeur = valeur.replace("[", String.fromCharCode(123));
		 valeur = valeur.replace ("]", String.fromCharCode(125));
		 console.log("valeur après remplacement suite à lecture douchette :" + valeur);
		var data = eval( '('+valeur+')');
		console.log("uid après extraction : "+data["uid"]);
		console.log ("db après extraction : " + data ["db"]);
		if (data["db"] == db) {
			return data["uid"];	
		} else {
			return "";
		}
		
		/*
		 * Recherche s'il s'agit d'une adresse web
		 */
		var adresse = valeur.split("?");
		var variables;
		var a_variables;
		var variable;
		var value = "";
		if (adresse.length == 2) {
			variables = adresse[1];
		} else
			variables = adresse[0];
		/*
		 * Decoupage des variables
		 */
		a_variables = variables.split("&");
		for (i = 0; i < a_variables.length; i++) {
			/*
			 * extraction du nom de la variable
			 */
			variable = a_variables[i].split("=");
			if (variable[0] == "uid") {
				value = variable[1];
				break;
			}
		}
		return value;
	}
	function readEnable() {
		/*
		 * Fonction declenchant la lecture des qrcodes
		 */
		is_read = true;
		$("#read_optical").val("1");
		$('#reader').html5_qrcode(function(data) {
			// do something when code is read
			$("#valeur-scan").val(data);
			readChange();
		}, function(error) {
			//show read errors 
			//console.log(error);
		}, function(videoError) {
			//the video stream could be opened
			$("#valeur-scan").val(videoError);
			console.log(videoError);
		});
	}
	$('#start').click(function() {
		destination = "container";
		if (is_read == false) {
			readEnable();
		}
	});
	$('#start2').click(function() {
		destination = "object";
		if (is_read == false) {
			readEnable();
		}
	});


	$('#stop').click(function() {
		$('#reader').html5_qrcode_stop();
	});
/*
 * Activation automatique de la lecture optique
 */
 {if $read_optical == 1}
readEnable();
{/if}

});
</script>