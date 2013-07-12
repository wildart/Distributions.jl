immutable LocationScaleFamily{T <: UnivariateDistribution}
	d::T
	location::Float64
	scale::Float64
	function LocationScaleFamily(d::T, l::Real, s::Real)
		if s <= 0.0
			throw(ArgumentError("Scale must be non-negative"))
		end
		new(d, float64(l), float64(s))
	end
end

function LocationScaleFamily{T <: UnivariateDistribution}(d::T, l::Real, s::Real)
	LocationScaleFamily{T}(d, l, s)
end

# TODO: May need extra constructor

function cdf(d::LocationScaleFamily, x::Real)
	cdf(d.d, (x - d.location) / d.scale)
end

cf(d::LocationScaleFamily) = error("Not yet implemented")

entropy(d::LocationScaleFamily) = entropy(d.d)

function insupport(d::LocationScaleFamily, x::Real)
	insupport(d.d, (x - d.location) / d.scale)
end

kurtosis(d::LocationScaleFamily) = kurtosis(d.d)

location(d::LocationScaleFamily) = d.location

mean(d::LocationScaleFamily) = mean(d.d) * d.scale + d.location

median(d::LocationScaleFamily) = median(d.d) * d.scale + d.location

mgf(d::LocationScaleFamily) = error("Not yet implemented")

function modes(d::LocationScaleFamily)
	m = modes(d.d)
	for i in 1:length(m)
		m[i] = m[i] * d.scale + d.location
	end
	return m
end

function pdf(d::LocationScaleFamily, x::Real)
	1 / d.scale * pdf(d.d, (x - d.location) / d.scale)
end

function quantile(d::LocationScaleFamily, p::Real)
	quantile(d.d, p) * d.scale + d.location
end

scale(d::LocationScaleFamily) = d.scale

skewness(d::LocationScaleFamily) = skewness(d.d)

var(d::LocationScaleFamily) = var(d.d) * d.scale^2

function rand(d::LocationScaleFamily)
	rand(d.d) * d.scale + d.location
end
