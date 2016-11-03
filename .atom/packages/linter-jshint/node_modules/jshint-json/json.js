'use strict';
module.exports = {
	reporter: function (result, data) {
		console.log(JSON.stringify({
			result: result,
			data: data
		}));
	}
};
