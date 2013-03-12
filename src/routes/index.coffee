
{ _ } = require 'underscore'
util  = require '../util'
Memory = require '../models/memory'
Code   = require '../models/code'

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


  getMemories = util.cache 5000, (done)->
    Memory.find {}, (err, memories) ->
      done(err, memories)


#=----------------------------------------------------------------------------=#
# Get memories
#=----------------------------------------------------------------------------=#
  app.get '/', (req, res) ->
    Code.find {}, (err, codes) ->
      { code } = util.random codes
      getMemories (err, memories)->
        memories = util.prepare memories, effects, (mems) ->
          mems.push
            name: "Monstercat"
            code: code
            memory: "You've found an Aftermath album code! Click the gold monstercat to redeem. Act quickly, other may have found it as well!"
          mems

        res.render "index",
          title: title
          times: util.calc memories.length
          memories: memories

#=----------------------------------------------------------------------------=#
# Add memory
#=----------------------------------------------------------------------------=#
  app.post '/add', (req, res) ->
    new_memory = new Memory req.body
    getMemories (err, memories)->
      new_memory.save (err, doc) ->
        memories = util.prepare memories, effects, (mems) ->
          mems.unshift doc if doc
          mems

        res.cookie 'memory-submitted', 'true'
        res.render "index",
          title: title
          times: util.calc memories.length
          memories: memories

#=----------------------------------------------------------------------------=#
# get memories and start from a specific one
#=----------------------------------------------------------------------------=#
  app.get '/:id', (req, res) ->
    { id } = req.params
    getMemories (err, memories)->
      console.log err if err
      memories = util.prepare memories, effects, (ms)->
        _.sortBy(ms, (m)-> return m._id.toString() != id )

      res.render "index",
        title: title
        times: util.calc memories.length
        memories: memories

module.exports = homeController
