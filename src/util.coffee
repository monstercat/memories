
{ _ } = require 'underscore'

exports.random = (xs) ->
  xs[_.random(0, xs.length - 1)]

exports.move = (vec, trans) ->
  vec[0] += trans[0]
  vec[1] += trans[1]
  vec[2] += trans[2]

exports.calc = (n, y=60*60*1000+5000) ->
  n: n
  read: Math.floor((3*y)/(4*n))
  trans: Math.floor(y/(4*n))

exports.shuffle = (array)->
  m = array.length
  while (m)
    i = Math.floor(Math.random() * m--)
    t = array[m]
    array[m] = array[i]
    array[i] = t
  return array

exports.prepare = (mems, effects, fn, n=200) ->
  mems = mems.slice(0)
  mems = exports.shuffle(mems)[..n]
  mems = fn mems if fn
  mems = exports.applyEffects(mems, effects)
  mems = _(mems).filter ((m) -> m.memory.length <= 725)
  mems

exports.cache = (wait, fn)->
  data = null
  lastErr = null
  invalidCache = yes
  return (cb)->
    if invalidCache
      fn (err, d) ->
        lassErr = null
        data = d
        invalidCache = no
        setTimeout (-> invalidCache = yes), wait
        cb err,d
    else
      cb lastErr, data

exports.anonymise = (name) ->
  n = []
  xs = name.split(" ").filter (n) -> n and n.length > 0
  n.push xs[0] if xs.length > 0
  if xs.length > 1
    last = xs.pop()
    n.push last[0] if last and last.length > 0
  n.join " "

exports.applyEffects = (memories, effects)->
  lpos = [0, 0, 0]
  lrot = [30, 0, 20]

  mems = for memory in memories
    memory = memory.toObject()
    memory.pos = lpos.slice(0)
    memory.rot = lrot.slice(0)

    exports.random(effects)(memory)

    lpos = memory.pos
    lrot = memory.rot

    memory.name = exports.anonymise memory.name

    memory
  mems
