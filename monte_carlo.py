import math
import random

def func(x: int, y: int):
    return 3*x + 4*y

def monte_carlo(x_1: int, x_2: int, y_1: int, y_2: int, t_1: int, t_2: int, N):
    x_1 = 0
    x_2 = 2**16

    y_1 = 0
    y_2 = 2**16

    t_1 = 0
    t_2 = 2**19

    N = 10000

    area_box = (x_2 - x_1) * (y_2 - y_1)
    in_area = 0

    for i in range(N):
        xrand = random.randint(x_1, x_2)
        yrand = random.randint(y_1, y_2)
        trand = random.randint(t_1, t_2)
        if trand < func(xrand, yrand):
            in_area += 1

    integral = (in_area / N) * area_box

    return {"integral": integral, "in_area": in_area}