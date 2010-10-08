class Node
  constructor: (@id, @title, @text) ->
    @exits = {}
  addExit: (text, node) ->
    @exits[text] = node

class Nodes
  constructor: ->
    @next_id = 1
    @nodes = []
  make: (title, text) ->
    node = new Node(@next_id++, title, text)
    @nodes[node.id] = node
    node
  find: (id) ->
    @nodes[id]

nodes = new Nodes

