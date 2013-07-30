module.exports = (xs...) ->
  if xs.length isnt 0
    tap {}, (o) -> o[k] = v for k, v of x for x in xs

tap = (x, f) -> f(x); x