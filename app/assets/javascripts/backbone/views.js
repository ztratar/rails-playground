// Views

$(function() {

	airetyApp.view.baseView = Backbone.View.extend({

		initialize: function(options) {
			this.model = this.model || {};
			this.collection = this.collection || {};
			this.currentView = this.currentView || {};
			this.activeChildren = [];
			if (typeof this.init === 'function') {
				this.init(options);
			}
		},

		showView: function(selector, view, options) {
			if (this.currentView && this.currentView[selector] && view != this.currentView[selector]) {
				this.currentView.close();
			}
			this.currentView[selector] = view;
			this.$(selector).html(this.currentView[selector].$el);
			if (options && options.render === true) {
				this.currentView[selector].render();
			}
			return this;
		},
		
		close: function() {
			if (typeof this.onClose === 'function' ) {
				this.onClose();
			}
			if (this.activeChildren != undefined && this.activeChildren.length > 0) {
				_.each(this.activeChildren,function(child){ child.close(); })
				this.activeChildren = [];
			}
			this.$el.remove();
		}

	});

	airetyApp.view.appView = airetyApp.view.baseView.extend({
	
		el: $('body'),

		init: function() {
			this.model = new airetyApp.model.user();
			this.headerView = new airetyApp.view.headerView({
				model: this.model
			});
			this.model.set({
				id: 1,
				name: 'Zach Tratar',
				picture: {
					src: 'http://localhost:3000/assets/zach.png'
				}
			});
		}

	});

	airetyApp.view.headerView = airetyApp.view.baseView.extend({
	
		el: $('#header'),

		init: function(options) {
			this.model.bind('change', this.renderDropdown, this);
			this.dropdownTemplate = $("#headerDropdown-template").html();
		},

		renderDropdown: function() {
			$("#dropdown-container").html( Mustache.render(this.dropdownTemplate, this.model.toJSON()) );	
		}
	
	});

	airetyApp.view.homeView = airetyApp.view.baseView.extend({
	
		template: $("#homeView-template").html(),

		init: function() {
		},

		render: function() {
			this.$el.html(this.template);
		}
	
	});

	airetyApp.view.registrationView = airetyApp.view.baseView.extend({
	
		template: $("#registrationView-template").html(),

		init: function() {
			$(window).on('scroll', this.scrolling);
		},

		render: function() {
			this.$el.html(this.template);
		},

		scrolling: function() {
			if ($(window).scrollTop() < 1){
				this.$(".headerPop").css('z-index', '110');	
			} else {
				this.$(".headerPop").css('z-index', '90');
			}
		},

		onClose: function() {
			$(window).off('scroll', this.scrolling);
		}
	
	});

	airetyApp.view.streamView = airetyApp.view.baseView.extend({
	
		className: "user-stream",

		init: function(options) {
			this.options = options || this.options || {};

			this.collection.on('reset', this.addAll, this);
			this.collection.on('add', this.addOne, this);

			this.itemWidth = options.itemWidth || 210;
			this.offset = options.offset || 15;
		},

		setUp: function() {
			this.columnWidth = this.itemWidth + this.offset;
			this.containerWidth = this.$el.width();
			this.numColumns = Math.floor((this.containerWidth + this.offset) / this.columnWidth);
			this.offsetRight = Math.round((this.containerWidth - (this.numColumns * this.columnWidth - this.offset)) / 2);
			this.bottom = 0;
			this.columns = [];

			while (this.columns.length < this.numColumns) {
				this.columns.push(0);
			}

			$(window).on('scroll', this, this.infScroll);
		},

		addAll: function() {
			var that = this;
			this.activeChildren.each(function(child) { 
				child.close();   
			});
			this.aciveChildren = [];
			this.collection.each(function(user){
				that.addOne(user)
			});
			var scrollTop = $(window).scrollTop();
		},

		addOne: function(user) {
			var shortest = null,
			shortestIndex = 0,
			k;

			var view = new airetyApp.view.userCardView({ model: user });
			this.$el.append(view.render().el);

			this.activeChildren.push(view);

			for (k = 0; k < this.numColumns; k++) {
				if (shortest === null || this.columns[k] < shortest) {
					shortest = this.columns[k];
					shortestIndex = k;
				}
			}

			// Postion the item.
			view.$el.css({
				position: 'absolute',
				top: shortest + 'px',
				left: (shortestIndex * this.columnWidth) + 'px',
				width: this.itemWidth
			});

			// Update column height.
			this.columns[shortestIndex] = shortest + view.$el.outerHeight() + this.offset;
			if (this.columns[shortestIndex] > this.bottom) {
				this.bottom = this.columns[shortestIndex];
				this.$el.height(this.bottom);
			}

			view.$("img.lazy").lazyload({
				effect: 'fadeIn',
				threshold: 800
			});

		},

		infScroll: function() {

		}
	
	});

	airetyApp.view.userCardView = airetyApp.view.baseView.extend({

		className: "user-stream-card",

		template: $("#userCardView-template").html(),

		init: function() {
			this.model.on('change', this.render, this);
			this.model.on('destroy', this.remove, this);
		},

		render: function() {
			this.$el.html(Mustache.render(this.template, this.model.toJSON()));
			return this;
		}
	
	});

});
