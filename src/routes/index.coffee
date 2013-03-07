
{ _ } = require 'underscore'
util  = require '../util'
Memory = require '../models/memory'

homeController = (app) ->
  rate = 500
  rotrate = 10

  title = "Monstercat Memories"

#=----------------------------------------------------------------------------=#
# Effects
#=----------------------------------------------------------------------------=#

  effects = [
      # 3d rot

      # flat rotate
      (memory)->
        util.move(memory.pos, [rate, 0, rate])
        util.move(memory.rot, [0, 0, 90])

      # crazy rotate
    , (memory)->
        util.move(memory.pos, [rate, 0, rate])
        util.move(memory.rot, [70, 0, 70])

      # zoom
    , (memory)->
        util.move(memory.pos, [0, 0, -1000])
    ]

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

        util.random(effects)(memory)

        lpos = memory.pos
        lrot = memory.rot
        memory

      maxlen = 725

      res.render "index",
        title: title
        times: util.calc mems.length
        memories: _(mems).filter ((m) -> m.memory.length <= maxlen)

#=----------------------------------------------------------------------------=#
# Add memory
#=----------------------------------------------------------------------------=#
  app.post '/add', (req, res) ->
    res.cookie 'memory-submitted', 'true'
    res.render "index",
      title: title
      memories: memories


module.exports = homeController
