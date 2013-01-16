class TodomvcRails.Views.TodoView extends Backbone.View

  template: JST['todos/todo']

  tagName: 'li'

  events:
    'click .toggle' :'toggleCompleted',
    'dblclick label':'edit',
    'click .destroy':'clear',
    'keypress .edit':'updateOnEnter',
    'blur .edit'    :'close'

  initialize: ->
    @listenTo(@model, 'change', @render)
    @listenTo(@model, 'destroy', @remove)
    @listenTo(@model, 'visible', @toggleVisible)

  render: ->
    @$el.html( @template(todo: @model) )
    @$el.toggleClass( 'completed', @model.get('completed') )

    @toggleVisible()
    @$input = @$('.edit')
    @

  toggleVisible: ->
    @$el.toggleClass('hidden',  @isHidden())

  isHidden: ->
    isCompleted = @model.get('completed')
    return (
      (!isCompleted && TodomvcRails.TodoFilter == 'completed')|| (isCompleted && TodomvcRails.TodoFilter == 'active')
    )

  toggleCompleted: ->
    @model.toggle()

  edit: ->
    @$el.addClass('editing')
    @$input.focus()

  close: ->
    value = @$input.val().trim()
    if ( value )
      @model.save({ text: value })
    else
      this.clear()
    @$el.removeClass('editing')

  updateOnEnter: (e)->
    if ( e.which == ENTER_KEY )
      this.close()

  clear: ->
    this.model.destroy()
