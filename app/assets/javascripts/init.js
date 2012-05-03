var airetyApp = airetyApp || {}; // airetyApp contains all model, collection, and view templates
var airety = airety || {}; // airety is the application at runtime

airetyApp.router = airetyApp.router || {};
airetyApp.model = airetyApp.model || {};
airetyApp.collection = airetyApp.collection || {};
airetyApp.view = airetyApp.view || {};



$(function(){

	/********* ROUTER *********/

	airetyApp.router.primary = Backbone.Router.extend({
			
			routes: {
				'': 'index'
			},

			index: function() {
			}

	});

	airety.run = function() {
		airety.route = new airetyApp.router.primary;	
		Backbone.history.start({ pushState: true });
	};
	
	/* initialize application */
	
	airety.run();

});
