var _max = array_length(box_xscale) - 1;
frame = approach(frame, _max, _max / 12);

if (frame == _max)
    ready = true;

bar_shake = approach(bar_shake, 0, 1/15);
