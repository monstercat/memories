
{ _ } = require 'underscore'

homeController = (app) ->

  random = (xs) -> xs[_.random(0, xs.length - 1)]
  move = (vec, trans) ->
    vec[0] += trans[0]
    vec[1] += trans[1]
    vec[2] += trans[2]

  rate = 500
  rotrate = 10
  effects = [
      # 3d rot

      # flat rotate
      (memory)->
        move(memory.pos, [rate, 0, rate])
        move(memory.rot, [0, 0, 90])

      # crazy rotate
    , (memory)->
        move(memory.pos, [rate, 0, rate])
        move(memory.rot, [70, 0, 70])

      # zoom
    , (memory)->
        move(memory.pos, [0, 0, -1000])
    ]

  app.get '/', (req, res) ->
    msgs = ["In my opinion, it was the New Artist Week. A family like Monstercat, opening spots for new talents(some of them not really new) was really awesome.",
     "To see the grow of artists. If you listen every song of a single artist and you start at the first one they made, and end at the most recent one you can hear them become better. Literally. So the best memory is the evolution of skill of the MCM crew.",
     "The sheer emotion that was behind Tristam's song \"Truth.\" Every time I listen to that song I can feel the effort and dedication he put into it.", "Mine was the day i found revolt i by rezonate i threw i ipod at the wall and it broke cuz i loved monstercat so much",
     "Mine was the day i found revolt i by rezonate i threw i ipod at the wall and it broke cuz i loved monstercat so much"]

    for msg in msgs
      msgs.push msg

    for msg in msgs
      msgs.push msg

    for msg in msgs
      msgs.push msg

    for msg in msgs
      msgs.push msg

    lpos = [0, 0, 0]
    lrot = [30, 0, 20]
    memories = []

    for msg in msgs
      memory =
        pos: lpos.slice(0)
        rot: lrot.slice(0)
        msg: msg

      random(effects)(memory)

      lpos = memory.pos
      lrot = memory.rot

      memories.push memory

    console.log memories

    res.render "index",
      title: "Express"
      memories: memories

module.exports = homeController
