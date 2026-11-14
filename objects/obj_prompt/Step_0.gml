if (prompt)
{
    prompt_alpha = approach(prompt_alpha, 1, 1/15);
    prompt_swap_delay--;
    
    if (prompt_swap_delay == 0)
    {
        prompt_swap_delay = prompt_swap_delay_count;
        prompt_ind = !prompt_ind;
    }
}
else
{
    prompt_alpha = approach(prompt_alpha, 0, 0.1);
}
