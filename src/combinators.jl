# Override when family can be achieved easily
function relocate(d::UnivariateDistribution, l::Real)
	LocationScaleFamily(d, location(d) + l, scale(d))
end

function rescale(d::UnivariateDistribution, s::Real)
	LocationScaleFamily(d, location(d), scale(s) * s)
end

function mix(d::Distribution...)
	N = length(d)
	dists = Array(Distribution, N)
	for i in 1:N
		dists[i] = d[i]
	end
	probs = 1 / N * ones(N)
	MixtureModel(dists, probs)
end

function truncate()
	error("Not yet defined")
end
