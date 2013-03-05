

homeController = (app) ->

  app.get '/', (req, res) ->
    msgs = ["In my opinion, it was the New Artist Week. A family like Monstercat, opening spots for new talents(some of them not really new) was really awesome.",
     "To see the grow of artists. If you listen every song of a single artist and you start at the first one they made, and end at the most recent one you can hear them become better. Literally. So the best memory is the evolution of skill of the MCM crew.",
     "The sheer emotion that was behind Tristam's song \"Truth.\" Every time I listen to that song I can feel the effort and dedication he put into it.", "Mine was the day i found revolt i by rezonate i threw i ipod at the wall and it broke cuz i loved monstercat so much",
     "Mine was the day i found revolt i by rezonate i threw i ipod at the wall and it broke cuz i loved monstercat so much"]

    x = 0
    z = 0
    rx = 30
    rz = 20
    rate = 500
    rrate = 10
    memories = []

    for msg in msgs
      p = [x += rate, 0, z += rate]
      r = [rx += rrate, 0, rz += rrate]
      memories.push
        pos: p
        rot: r
        msg: msg

    res.render "index",
      title: "Express"
      memories: memories

module.exports = homeController
