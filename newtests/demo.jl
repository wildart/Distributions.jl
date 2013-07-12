using Distributions

d = Normal(0, 1)

# Need to shift relative to current scale and location
d = rescale(d, 2)

d = relocate(d, +5.0)

d = relocate(d, -5.0)

d = mix(Normal(5, 1), Normal(0, 1))

d = mix([Normal(5, 1), Normal(0, 1)], [0.5, 0.5])

d = truncate(d, -2.0, +2.0)

d = mix(Normal(5, 1), Gamma(1, 1))
