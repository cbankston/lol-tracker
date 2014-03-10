//= require jquery/jquery
//= require bootstrap/dist/js/bootstrap
//= require underscore/underscore
//= require backbone/backbone
//= require d3/d3
//= require ./app
//= require_tree ./app/models
//= require_tree ./app/collections
//= require ./app/views/charts/base
//= require_tree ./app/views
//= require_tree ./app/controllers
//= require ./app/router

new App.Router();
Backbone.history.start({ pushState: true })
