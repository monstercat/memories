
{ _ } = require 'underscore'
util  = require '../util'
Memory = require '../models/memory'

homeController = (app) ->
  rate = 500
  rotrate = 10

  title = "Monstercat Memories"

  generateEffect = (memories)->
    lpos = [0, 0, 0]
    lrot = [30, 0, 20]

    mems = for memory in memories
      memory = memory.toObject()
      memory.pos = lpos.slice(0)
      memory.rot = lrot.slice(0)

      util.random(effects)(memory)

      lpos = memory.pos
      lrot = memory.rot

      memory.name = util.anonymise memory.name

      memory
    mems

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
    getMemories (err, memories)->
      mems = memories.slice(0)
      console.log err if err
      util.shuffle(mems)
      mems = generateEffect(mems)
      maxlen = 725
      nolongs = _(mems).filter ((m) -> m.memory.length <= maxlen)

      res.render "index",
        title: title
        times: util.calc nolongs.length
        memories: nolongs

#=----------------------------------------------------------------------------=#
# Add memory
#=----------------------------------------------------------------------------=#
  app.post '/add', (req, res) ->
    new_memory = new Memory req.body
    getMemories (err, memories)->
      new_memory.save (err, doc) ->
        console.log err if err
        mems = memories.slice(0)
        util.shuffle(mems)
        mems.unshift(doc) if doc
        mems = generateEffect(mems)
        maxlen = 725

        res.cookie 'memory-submitted', 'true'
        res.render "index",
          title: title
          times: util.calc mems.length
          memories: _(mems).filter ((m) -> m.memory.length <= maxlen)

#=----------------------------------------------------------------------------=#
# get memories and start from a specific one
#=----------------------------------------------------------------------------=#
  app.get '/:id', (req, res) ->
    { id } = req.params
    getMemories (err, memories)->
      console.log err if err
      mems = memories.slice(0)
      util.shuffle(mems)
      mems = _.sortBy(mems, (m)-> return m._id.toString() != id )
      mems = generateEffect(_.sortBy(mems, (m)-> return m._id.toString() != id ))
      maxlen = 725

      res.render "index",
        title: title
        times: util.calc mems.length
        memories: _(mems).filter ((m) -> m.memory.length <= maxlen)

module.exports = homeController
