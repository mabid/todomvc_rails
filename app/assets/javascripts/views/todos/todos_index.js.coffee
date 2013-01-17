class TodomvcRails.Views.TodosIndex extends Backbone.View

  statsTemplate: JST['todos/stats']

  el: "#todoapp"

  events:
    'keypress #new-todo'     : 'createOnEnter',
    'click #clear-completed' : 'clearCompleted',
    'click #toggle-all'      : 'toggleAllComplete'

  createOnEnter: (e)->
    if ( e.which != ENTER_KEY || !@$input.val().trim() )
      return

    TodomvcRails.Todos.create( @newAttributes(), wait: true )
    @$input.val('')

  newAttributes: ->
    return {
      text: @$input.val().trim(),
      position: TodomvcRails.Todos.nextOrder(),
      completed: false
    }

  initialize: ->
    _.bindAll(@, "addAll", "addOne")

    @allCheckbox = this.$('#toggle-all')[0]
    @$input  = @$('#new-todo')
    @$footer = @$('#footer')
    @$main   = @$('#main')
    @$list= @$('#todo-list')

    TodomvcRails.Todos = TodomvcRails.Todos

    @listenTo(TodomvcRails.Todos, 'add', @addOne)
    @listenTo(TodomvcRails.Todos, 'reset', @addAll)
    @listenTo(TodomvcRails.Todos, 'change:completed', @filterOne)
    @listenTo(TodomvcRails.Todos, 'filter', @filterAll)
    @listenTo(TodomvcRails.Todos, 'all', @render)

    that = @

    @$list.sortable
      containment:"#main"
      axis: "y"
      grid: [61, 61]
      handle: "span"
      helper: (e, ele) ->
        $ "<div class='line'></div>"
      tolerance: "pointer"
      placeholder: "empty"
      scrollSensitivity: 30
      scorll: true
      start: (e, ui) ->
        that.$list.find("li span").removeClass "arrow"
        that.$list.find("li button").removeClass "destroy"
        ui.item.addClass "dragging"
        ui.item.show()

      beforeStop: (e, ui) ->
        that.$list.find("li span").addClass "arrow"
        that.$list.find("li button").addClass "destroy"
        ui.item.removeClass "dragging"
      stop: (e, ui)->
        sortData = that.$list.sortable("serialize")
        TodomvcRails.Todos.saveOrder(sortData)

    TodomvcRails.Todos.fetch()

  render: ->
    completed = TodomvcRails.Todos.completed().length
    remaining = TodomvcRails.Todos.remaining().length
    if ( TodomvcRails.Todos.length )
      @$main.show()
      @$footer.show()

      @$footer.html(this.statsTemplate({
        completed: completed,
        remaining:remaining
      }))

      @$('#filters li a')
      .removeClass('selected')
      .filter('[href="#/' + ( TodomvcRails.TodoFilter || '' ) + '"]')
      .addClass('selected')
    else
      @$main.hide()
      @$footer.hide()

    this.allCheckbox.checked = !remaining
    @$list.sortable("refresh")

    
  filterOne: (todo )->
    todo.trigger('visible')

  filterAll: ->
    TodomvcRails.Todos.each(@filterOne, @)

  addAll: ->
    @$('#todo-list').html('')
    TodomvcRails.Todos.each(@addOne, @)

  addOne: (todo)->
    view = new TodomvcRails.Views.TodoView({ model: todo})
    @$('#todo-list').append( view.render().el )

  clearCompleted: ->
    _.invoke(TodomvcRails.Todos.completed(), 'destroy')
    return false

  toggleAllComplete: ->
    completed = @allCheckbox.checked

    TodomvcRails.Todos.each(
      (todo)->
        todo.save({
          'completed': completed
        })
     )
    
