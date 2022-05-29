#include <iostream>
#include <cstdlib>
#include <cmath>

double function_3d(long long x, long long y) {
    return 3*x + 4*y;
}


unsigned int monte_carlo_estimate_3d(unsigned int low_x, unsigned int up_x, unsigned int low_y, unsigned int up_y,
                                         unsigned int low_t, unsigned int up_t, unsigned int iterations) {
    unsigned int rand_x, rand_y, rand_t;
    double function_val;
    int points = 0;

    double box = (up_x - low_x) * (up_y - low_y) * (up_t - low_t);
    for (int i = 0; i < iterations; i++)
    {
        rand_x = static_cast<unsigned int>(low_x + (float(rand())/RAND_MAX) * (up_x - low_x));
        rand_y = static_cast<unsigned int>(low_y + (float(rand())/RAND_MAX) * (up_y - low_y));
        rand_t = static_cast<unsigned int>(low_t + (float(rand())/RAND_MAX) * (up_t - low_t));

        function_val = function_3d(rand_x, rand_y);

        if (rand_t <= function_val) {
            points++;
        }
    }
    return points;
}

int main()
{
    unsigned int lower_x, upper_x, lower_y, upper_y, upper_t, lower_t;
    double lowX, upX, lowY, upY;
	int iterations;

	lower_x = 0;
    lower_y = 0;
    upper_x = pow(2, 16);
    upper_y = pow(2, 16);
    lower_t = 0;
    upper_t = pow(2, 19);
	iterations = 10000;

    unsigned int points_under = monte_carlo_estimate_3d(lower_x, upper_x, lower_y, upper_y, lower_t, upper_t, iterations);

    std::cout << "Points under: " << points_under << std::endl;

	return 0;
}
