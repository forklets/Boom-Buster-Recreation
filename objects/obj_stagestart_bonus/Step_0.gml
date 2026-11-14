timer_logic(0);
go_alpha = use_curve(acurv_basics, go_percent, "ease_in", 0, 1);
go_scale = use_curve(acurv_basics, go_percent, "ease_in", 2, 1);
go_percent = approach(go_percent, 1, 0.1);
