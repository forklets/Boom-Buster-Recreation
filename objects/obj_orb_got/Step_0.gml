image_alpha -= 0.065;
scale += 0.04;

if (image_alpha <= 0)
    instance_destroy();
