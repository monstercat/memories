
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
