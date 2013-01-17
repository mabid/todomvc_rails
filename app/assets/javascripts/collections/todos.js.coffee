class TodomvcRails.Collections.Todos extends Backbone.Collection

  model: TodomvcRails.Models.Todo

  url:->
   'todos/'

  nextOrder :->
    if ( !@length )
      return 1
    return @last().get('position') + 1

  comparator: (todo)->
    todo.get('position')

  completed: ->
    return @filter(
      ( todo )->
        return todo.get('completed')
    )

  remaining: ->
    return @without.apply(@, @completed() )

  sortUrl: ->
    "todos/save_order"

  saveOrder:(sort_order) ->
    $.ajax @sortUrl(),
      type: 'put'
      data: sort_order
      dataType: 'JSON'
      error: (joinqXHR, textStatus, errorThrown) ->
      success: (data, textStatus, jqXHR) ->
        true
    @
