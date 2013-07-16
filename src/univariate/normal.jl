immutable Normal <: ContinuousUnivariateDistribution
    μ::Float64
    σ::Float64
    function Normal(mu::Real, sd::Real)
    	sd > zero(sd) || error("std must be positive")
    	new(float64(mu), float64(sd))
    end
end
Normal(mu::Real) = Normal(float64(mu), 1.0)
Normal() = Normal(0.0, 1.0)

@_jl_dist_2p Normal norm

@Base.math_const √2     1.4142135623730951 sqrt(big(2.))
@Base.math_const log2π  1.8378770664093456 log(big(2.)*π)
@Base.math_const √2π    2.5066282746310007 sqrt(big(2.)*π)

const Gaussian = Normal

begin
    zval(d::Normal, x::Real) = (x - d.μ)/d.σ
    xval(d::Normal, z::Real) = d.μ + d.σ * z
    
    φ{T<:FloatingPoint}(z::T) = exp(-0.5*z*z)/√2π
    pdf(d::Normal, x::FloatingPoint) = φ(zval(d,x))/d.σ

    logφ{T<:FloatingPoint}(z::T) = -0.5*(z*z + log2π)
    logpdf(d::Normal, x::FloatingPoint) = logφ(zval(d,x)) - log(d.σ)

    Φ{T<:FloatingPoint}(z::T) = 0.5 + 0.5*erf(z/√2)
    cdf(d::Normal, x::FloatingPoint) = Φ(zval(d,x))

    Φc{T<:FloatingPoint}(z::T) = 0.5*erfc(z/√2)
    ccdf(d::Normal, x::FloatingPoint) = Φc(zval(d,x))

    Φinv{T<:FloatingPoint}(p::T) = √2 * erfinv(2p - 1)
    quantile(d::Normal, p::FloatingPoint) = xval(d, Φinv(p))

    Φcinv{T<:FloatingPoint}(p::T) = √2 * erfcinv(2p)
    cquantile(d::Normal, p::FloatingPoint) = xval(d, Φcinv(p))
end

for f in [pdf, logpdf, ccdf, cdf, quantile]
    quote
        $f(d::Normal, x::Integer) = $f(d, float64(x))
    end
end

entropy(d::Normal) = log2π + 0.5 + log(d.σ)

insupport(d::Normal, x::Real) = isfinite(x)

kurtosis(d::Normal) = 0.0

mean(d::Normal) = d.μ

median(d::Normal) = d.μ

mgf(d::Normal, t::Real) = exp(t * d.μ + 0.5 * d.σ^t * t^2)

cf(d::Normal, t::Real) = exp(im * t * d.μ - 0.5 * d.σ^t * t^2)

modes(d::Normal) = [d.μ]

rand(d::Normal) = d.μ + d.σ * randn()

skewness(d::Normal) = 0.0

std(d::Normal) = d.σ

var(d::Normal) = d.σ^2

fit_mle{T <: Real}(::Type{Normal}, x::Array{T}) = Normal(mean(x), std(x))
