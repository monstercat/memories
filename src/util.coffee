
exports.random = (xs) ->
  xs[_.random(0, xs.length - 1)]

exports.move = (vec, trans) ->
  vec[0] += trans[0]
  vec[1] += trans[1]
  vec[2] += trans[2]
