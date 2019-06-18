'use strict'

###
A C E
B D F
0 0 1
###
module.exports = class Matrix
    constructor: ->
        @a = @d = 1
        @b = @c = @e = @f = 0

    transform: (a2, b2, c2, d2, e2, f2) ->
        a1 = @a
        b1 = @b
        c1 = @c
        d1 = @d
        e1 = @e
        f1 = @f

        @a = a1 * a2 + c1 * b2
        @b = b1 * a2 + d1 * b2
        @c = a1 * c2 + c1 * d2
        @d = b1 * c2 + d1 * d2
        @e = a1 * e2 + c1 * f2 + e1
        @f = b1 * e2 + d1 * f2 + f1

        @

    rotate: (angle) ->
        cos = Math.cos angle
        sin = Math.sin angle
        @transform cos, sin, -sin, cos, 0, 0

    scale: (f) ->
        @transform f, 0, 0, f, 0, 0

    translate: (tx, ty) ->
        @transform 1, 0, 0, 1, tx, ty

    multiply: (m) ->
        @transform m.a, m.b, m.c, m.d, m.e, m.f

    getRotation: ->
        r = Math.sqrt(@a * @a + @b * @b)
        if @b > 0 then Math.acos(@a / r) else -Math.acos(@a / r)

    getScale: ->
        Math.sqrt(@a * @a + @b * @b)

    getTranslate: ->
        x: @e, y: @f
