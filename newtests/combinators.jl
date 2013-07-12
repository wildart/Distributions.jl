using Base.Test
using Distributions

dpairs = {{LocationScaleFamily(Normal(), 2.0, 2.0), Normal(2.0, 2.0)},
          {LocationScaleFamily(Uniform(), 1.0, 2.0), Uniform(1.0, 3.0)}}

for dpair in dpairs
	d1, d2 = dpair[1], dpair[2]
	for x in -5.0:0.5:5.0
		@test_approx_eq pdf(d1, x) pdf(d2, x)
		@test_approx_eq cdf(d1, x) cdf(d2, x)
	end

	for p in 0.1:0.1:0.9
		@test_approx_eq quantile(d1, p) quantile(d2, p)
	end

	# Do a KS-test here
	# rand(d1, 10000)
	# rand(d2, 10000)
end
