
function minDate(){
	
	var now = new Date();

	var y = now.getFullYear();
	var m = now.getMonth() + 1;
	var d = now.getDate();
	
	if(m < 10){
		m = "0" + m;
	}
	
	if(d < 10){
		d = "0" + d;
	}
	
	var today =	y+"-"+m+"-"+d;
	
	$("#lec_start_date").attr("min", today);
	$("#lec_end_date").attr("min", today);
}