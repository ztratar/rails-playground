$(function(){

	/********* ROUTER *********/

	airetyApp.router.primary = Backbone.Router.extend({
			
			routes: {
				'': 'index',
				'chats/:id': 'chats'
			},

			index: function() {
				this.homeView = new airetyApp.view.homeView();
				window.airety.app.showView('#primaryContainer', this.homeView, { render: true });
				
				if ( !window.airety.app.model.get('id') ) {
					this.registrationView = new airetyApp.view.registrationView();
					this.homeView.showView('.top-container', this.registrationView, { render: true });
				} else {
					$("#primaryContainer").addClass('authed');
					this.chatsToday = new airetyApp.collection.chats();
					this.chatsTodayView = new airetyApp.view.chatsTodayView({
						collection: this.chatsToday
					});
					this.chatsToday.add({
						id: 3
					}).add({
						id: 4
					}).add({
						id: 5
					});

					this.homeView.showView('.top-container', this.chatsTodayView);
					this.chatsTodayView.center();
				}

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
			},

			chats: function(id) {

				this.chat = new airetyApp.model.chat();
				this.textChats = new airetyApp.collection.textChats();

				this.chatView = new airetyApp.view.chatView();
				this.chatColumnView = new airetyApp.view.chatColumnView({
					model: this.chat
				});
				this.textChatView = new airetyApp.view.textChatView({
					collection: this.textChats
				});
				this.cardView = new airetyApp.view.userCardView({
					model: window.airety.app.model,
					extended: true
				});
	
				$("#primaryContainer").addClass('authed');

				window.airety.app.showView('#primaryContainer', this.chatView, { render: true });
				this.chatView.showView('.chat-column', this.chatColumnView, { render: true });
				this.chatColumnView.showView('.textChat-container', this.textChatView, { render: true });
				this.chatView.showView('.card-column', this.cardView, { render: true });
			}

	});

});
