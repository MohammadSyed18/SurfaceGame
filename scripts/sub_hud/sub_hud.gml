function sub_draw_hud() {
    var _width = display_get_gui_width();
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(10, 25, 42));
    draw_rectangle(12, 12, min(_width - 12, 480), 108, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(24, 22, "Score " + string(score) + "    Best " + string(best_score));
    draw_text(24, 44, "Hull " + string(health) + "/3    Diamonds " + string(collected) + "/" + string(total_collectibles));
    draw_set_color(make_color_rgb(35, 55, 70));
    draw_rectangle(24, 76, 310, 91, false);
    draw_set_color(oxygen < 25 ? c_orange : make_color_rgb(93, 224, 205));
    draw_rectangle(24, 76, 24 + 286 * (oxygen / oxygen_capacity), 91, false);
    draw_set_color(c_white);
    draw_text(320, 74, "Air " + string(floor(oxygen)));
    if (message_time > 0) draw_text(24, 120, message);
    if (paused || game_over) {
        draw_set_alpha(0.7);
        draw_set_color(c_black);
        draw_rectangle(0, 0, _width, display_get_gui_height(), false);
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(_width / 2, display_get_gui_height() / 2 - 24, game_over ? "Dive ended — press R to restart" : "Paused — press P to continue");
        draw_set_halign(fa_left);
    }
}
