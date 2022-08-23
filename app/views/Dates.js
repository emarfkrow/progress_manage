/**
 *
 */

var Dates = {

	parseYyyyHmmHdd : function(yyyyHmmHdd) {
		if (!yyyyHmmHdd) {
			return null;
		}
		var ymds = yyyyHmmHdd.split('-');
		return new Date(ymds[0] * 1, ymds[1] - 1, ymds[2]);
	},

	parseYySmmSdd : function(yySmmSdd) {
		if (!yySmmSdd) {
			return null;
		}
		var ymds = yySmmSdd.split('/');
		return new Date(2000 + ymds[0] * 1, ymds[1] - 1, ymds[2]);
	},

	formatYyyyHmmHdd : function(date) {
		if (!date) {
			return '';
		}
		var yyyy = date.getFullYear();
		var mm = ('0' + (date.getMonth() + 1)).slice(-2);
		var dd = ('0' + date.getDate()).slice(-2);
		return yyyy + '-' + mm + '-' + dd;
	},

	formatYySmmSdd : function(date) {
		if (!date) {
			return '';
		}
		var yyyy = date.getFullYear();
		var yy = yyyy - 2000;
		var mm = ('0' + (date.getMonth() + 1)).slice(-2);
		var dd = ('0' + date.getDate()).slice(-2);
		return yy + '/' + mm + '/' + dd;
	},
};
