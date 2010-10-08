express = require("express")
jade = require("jade")

# Business logic


class Node
  constructor: (@id, @title, @text) ->
    @exits = []
  addExit: (text, node) ->
    @exits.push([text, node])
  finish: ->
    @exits.length == 0

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

start = nodes.make "Welcome traveler", "Welcome to labyrinth. Select your path"
left =  nodes.make "Left path", "You are on a left path"
right =  nodes.make "Right path", "You are on a right path"
finish = nodes.make "Finish", "You have reached the destination"

start.addExit("Go left", left)
start.addExit("Go right", right)

left.addExit("Go straight", finish)
left.addExit("Go right", right)

right.addExit("Go straight", finish)
right.addExit("Go left", left)

# View

class NodeView
  constructor: (@node) ->
    
  template:
    '''
!!! 5
html
  head
    title #{title}
  body
    h1 #{title}
    p #{text}
    p #{exitsOrCongratulations}
    '''
  exits: ->
    for exit in @node.exits
      ['/nodes/' + exit[1].id, exit[0]]

  exitsOrCongratulations: ->
    text = if @node.finish()
      '''
p YOU'RE WINNER !
p
  a(href='/') Start again
    '''
    else
      '''
ul
  - exits.forEach(function(exit) {
    li
      a(href=exit[1])= exit[0]
  - })
    '''
    locals =
      locals:
        exits: this.exits()
    jade.render(text, locals)
  locals: ->
    locals:
      title: @node.title
      text: @node.text
      exitsOrCongratulations: this.exitsOrCongratulations()
      
  html: ->
    jade.render(this.template, this.locals())

