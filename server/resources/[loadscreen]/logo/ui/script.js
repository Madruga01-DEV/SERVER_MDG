$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){

			var item = event.data;
			if (item !== undefined && item.type === "logo") {

				if (item.display === true) {
					$('#logo').show();
				} else {
					$('#logo').hide();
				}
			}
		});
	};
});