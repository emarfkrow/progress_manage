/**
 * 
 */

var Ajaxize = {

	getJson: function(url, callback) {
		Ajaxize.ajaxJson(url, 'get', null, callback);
	},

	postJson: function(url, dataJson, callback) {
		Ajaxize.ajaxJson(url, 'post', dataJson, callback);
	},

	ajaxJson: function(url, method, dataJson, callback) {
		$.ajax({
			url: url,
			type: method,
			data: dataJson,
			dataType: 'json',
		}).fail(function(jqXHR, textStatus, errorThrown) {

			console.log(jqXHR);
			console.log('textStatus: ' + textStatus);
			console.log('errorThrown: ' + errorThrown);

		}).done(function(json, textStatus, jqXHR) {

			callback(json);

		}).always(function(a, b, c) {
		});
	},

}