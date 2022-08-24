/**
 *
 */

var Numbers = {

	formatDec2 : function(element) {
		var $dec2 = $(element);
		$dec2.css('text-align', 'right');
		var isInput = $dec2.prop('tagName') == 'INPUT';
		var val;
		if (isInput) {
			val = $dec2.val();
		} else {
			val = $dec2.html();
		}
		var isNumber = !isNaN(val);
		if (isNumber) {
			val = Number(val).toFixed(2).toLocaleString();
			if (isInput) {
				$dec2.val(val);
			} else {
				$dec2.html(val);
			}
		}
	},
};
