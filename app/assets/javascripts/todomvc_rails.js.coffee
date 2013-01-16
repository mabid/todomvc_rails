window.ENTER_KEY = 13

window.TodomvcRails =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    TodomvcRails.Todos = new TodomvcRails.Collections.Todos
    TodomvcRails.router = new TodomvcRails.Routers.Todos
    Backbone.history.start()
    TodomvcRails.appView = new TodomvcRails.Views.TodosIndex

$(document).ready ->
  TodomvcRails.initialize()
