$(function(){

	// Models
	
	airetyApp.model.baseModel = Backbone.Model.extend({
		initialize: function(options) {
			if (typeof this.init === 'function') {
				this.init(options)
			}
		}
	});

	airetyApp.model.user = airetyApp.model.baseModel.extend({
		urlRoot: '/users'
	});

	
	/* collections */

	airetyApp.collection.baseCollection = Backbone.Collection.extend({

		initialize: function(models,options) {
			this.pageSize = 100;
			this.data = {};
			if (typeof this.init === 'function') {
				this.init(models,options);
			}

		},

		fetchPrev: function() {
			var tempData = this.data;
			if (this.model.first()) {
				tempData = $.extend({ firstId: this.model.first().get('id') },tempData);
			}
			this.fetch({
				data: this.data
			});	
		},

		fetchNext: function() {
			var tempData = this.data;
			if (this.model.last()) {
				tempData = $.extend({ lastId: this.model.last().get('id') },tempData);
			}
			this.fetch({
				data: this.data
			});	
		}

	});

	airetyApp.collection.users = airetyApp.collection.baseCollection.extend({
		model: airetyApp.model.user
	});

});
