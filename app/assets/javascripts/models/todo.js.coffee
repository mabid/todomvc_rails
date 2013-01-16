class TodomvcRails.Models.Todo extends Backbone.Model


  defaults: {
    text: '',
    completed: false
  }

  toggle: ->
    cm = @get('completed')
    cm =  !cm
    @save({completed: cm})
