def calc_time(length, pos, ant_num, speed, min, max):
    total_time = length / speed

    max = 0
    min = 0

    for i in range(ant_num):
        current_max = 0
        current_min = 0

        if pos[i] > (length / 2):
            current_max = pos[i] / speed
        else:
            current_max = (length - pos[i]) / speed;

        current_min = total_time - max

        if (max < current_max):
            max = current_max
        if (min > current_min):
            min = current_min

