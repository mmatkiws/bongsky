jQuery(document).ready(function($){

    var NUM_GUESTS=0;

	if( $('.floating-labels').length > 0 ) floatLabels();

	$("#addguest").click(function () {
        //var addressValue = $(this).attr("href");
        //alert(addressValue );
        console.log("addguest click");
        NUM_GUESTS++;
        add_fields();
        floatLabels();
    });

    $("#addguestp").click(function () {
        //var addressValue = $(this).attr("href");
        //alert(addressValue );
        console.log("addguestp click");
        NUM_GUESTS++;
        add_fields();
        floatLabels();
    });

	function floatLabels() {
		var inputFields = $('.floating-labels .cd-label').next();
		inputFields.each(function(){
			var singleInput = $(this);
			//check if user is filling one of the form fields 
			checkVal(singleInput);
			singleInput.on('change keyup', function(){
				checkVal(singleInput);
			});
		});
	}

	function checkVal(inputField) {
		( inputField.val() == '' ) ? inputField.prev('.cd-label').removeClass('float') : inputField.prev('.cd-label').addClass('float');
	}

	function add_fields() {
        //var d = document.getElementById("guest-fields");
        

        $("#guest-fields").append("<div class='icon'><label class='cd-label' for='guest-name" + NUM_GUESTS + "' id='guest-label" + NUM_GUESTS + "'>Guest Name</label> <input class='user' type='text' name='guest" + NUM_GUESTS + "' id='guest-name" + NUM_GUESTS + "'></div>");

        //d.innerHTML += "<div class='icon'><label class='cd-label' for='guest-name" + NUM_GUESTS + "' id='guest-label" + NUM_GUESTS + "'>Guest Name</label> <input class='user' type='text' name='guest" + NUM_GUESTS + "' id='guest-name" + NUM_GUESTS + "'></div>";
    }

});