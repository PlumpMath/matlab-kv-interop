#pragma once

#include <cstdint>
#include <cmath>
#include <tuple>

double pow2(int n)
{
	double x = 1.0;

	if(n > 0){
		while(n-- != 0)
			x *= 2.0;
	}else if(n < 0){
		while(n++ != 0)
			x /= 2.0;
	}

	return x;
}

double todouble(int sign, int exponent, ::std::uint64_t significand)
{
	return (sign == 1 ? -1 : 1) * ::pow2(exponent) * static_cast<double>(significand);
}

::std::tuple<int, int, ::std::uint64_t> fromdouble(double x)
{
	int sign = (::std::signbit(x) ? 1 : 0);

	x = ::std::abs(x);

	if(x < 1.0){
		int i = 0;

		while(::std::int64_t(x) != x){
			x *= 2.0;
			i--;
		}

		return ::std::make_tuple(sign, i, ::std::uint64_t(x));
	}else{
		int i = 0;

		while(x > 1.0){
			x /= 2.0;
			i++;
		}

		return ::std::make_tuple(sign, i - 53, ::std::uint64_t(x * ::pow2(53)));
	}
}
