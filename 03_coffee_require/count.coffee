exports.Count = class Count
  constructor: ->
    @count = 1
  
  increment: ->
    @count++
    this
  
  value: ->
    @count
