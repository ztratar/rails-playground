$(function(){

	/********* ROUTER *********/

	airetyApp.router.primary = Backbone.Router.extend({
			
			routes: {
				'': 'index'
			},

			index: function() {
				this.homeView = new airetyApp.view.homeView();
				window.airety.app.showView('#primaryContainer', this.homeView, { render: true });

				this.registrationView = new airetyApp.view.registrationView();
				this.homeView.showView('.top-container', this.registrationView, { render: true });

				this.userStream = new airetyApp.collection.users();
				this.userStreamView = new airetyApp.view.streamView({
					collection: this.userStream
				});
				this.homeView.showView('.stream-container', this.userStreamView);
				this.userStreamView.setUp();
				for(var i = 0; i < 30; i++){
					this.userStream.add({ 
						name: 'Zach Tratar',
						picture: {
							width: 180,
							height: 270,
							src: 'http://localhost:3000/assets/zach.png'
						}
					});
				}
			}

	});

});
