
// cash 클래스에 숫자 처리 ex) 10000000 => 10,000,000
function fn_formatCash() {
	  // "cash" 클래스를 가진 모든 요소를 선택
	  var cashElements = document.querySelectorAll(".cash");

	  // 각 요소의 내용을 포맷팅
	  cashElements.forEach(function (element) {
	    var text = element.textContent || element.innerText;
	    var formattedText = fn_formatNumber(parseFloat(text.replace(/,/g, "")));
	    element.textContent = formattedText;
	  });
}
function fn_formatNumber(number) {
	return number.toLocaleString();
}