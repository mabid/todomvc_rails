class TodomvcRails.Routers.Todos extends Backbone.Router
  routes:
    '*filter'         : 'setFilter'

  setFilter: (param)->
    TodomvcRails.TodoFilter = param.trim() || ''
    TodomvcRails.Todos.trigger('filter')
    
    
