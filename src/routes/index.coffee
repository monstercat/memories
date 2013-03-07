
{ _ } = require 'underscore'
util  = require '../util'
Memory = require '../models/memory'

homeController = (app) ->
  title = "Monstercat Memories"

#=----------------------------------------------------------------------------=#
# Effects
#=----------------------------------------------------------------------------=#
  rate = 500
  rotrate = 10
  effect = (memory)->
    util.move(memory.pos, [rate+_.random(-100, 100),rate+_.random(-100,100),rate+_.random(-100,100)])
    util.move(memory.rot, [_.random(-90, 90), _.random(-90,90), _.random(-90, 90)])

#=----------------------------------------------------------------------------=#
# Get memories
#=----------------------------------------------------------------------------=#
  app.get '/', (req, res) ->

    lpos = [0, 0, 0]
    lrot = [30, 0, 20]
    memories = []

    Memory.find {}, (err, memories)->
      console.log err if err
      mems = for memory in memories
        memory = memory.toObject()
        memory.pos = lpos.slice(0)
        memory.rot = lrot.slice(0)

        effect(memory)

        lpos = memory.pos
        lrot = memory.rot
        memory

      res.render "index",
        title: title
        times: util.calc mems.length
        memories: mems

#=----------------------------------------------------------------------------=#
# Add memory
#=----------------------------------------------------------------------------=#
  app.post '/add', (req, res) ->
    res.cookie 'memory-submitted', 'true'
    res.render "index",
      title: title
      memories: memories


module.exports = homeController
