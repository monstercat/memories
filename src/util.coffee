
{ _ } = require 'underscore'

exports.random = (xs) ->
  xs[_.random(0, xs.length - 1)]

exports.move = (vec, trans) ->
  vec[0] += trans[0]
  vec[1] += trans[1]
  vec[2] += trans[2]

exports.calc = (n, y=60) ->
  n: n
  read: Math.floor(60*1000*((3*y)/(4*n)))
  trans: Math.floor(60*1000*(y/(4*n)))
