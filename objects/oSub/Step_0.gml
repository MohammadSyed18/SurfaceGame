if (total_collectibles < 0) total_collectibles = instance_number(oDiamond) + instance_number(oDiamondA);
if (keyboard_check_pressed(ord("R"))) {
    room_restart();
    exit;
}
if (keyboard_check_pressed(ord("P")) && !game_over) paused = !paused;
if (paused || game_over) exit;
// Seconds come from the engine clock; long frames are capped for collision safety.
var _dt = clamp(delta_time / 1000000, 0, 0.05);
sub_apply_movement(_dt);
sub_update_resources(_dt);
if (!game_over) sub_update_collectibles(_dt);
