function sub_save_best() {
    best_score = max(best_score, score);
    ini_open("surface_progress.ini");
    ini_write_real("progress", "best_score", best_score);
    ini_close();
}

function sub_take_damage(_reason) {
    if (respawn_cooldown > 0 || game_over) return;
    health -= 1;
    combo = 0;
    message = _reason;
    message_time = 2;
    if (health <= 0) {
        health = 0;
        game_over = true;
        hspd = 0;
        vspd = 0;
        sub_save_best();
        return;
    }
    x = spawn_x;
    y = spawn_y;
    hspd = 0;
    vspd = 0;
    oxygen = max(oxygen, oxygen_capacity * 0.5);
    respawn_cooldown = 1.5;
}

function sub_update_resources(_dt) {
    respawn_cooldown = max(0, respawn_cooldown - _dt);
    message_time = max(0, message_time - _dt);
    if (bbox_top <= surface_y) {
        oxygen = min(oxygen_capacity, oxygen + 25 * _dt);
        if (keyboard_check_pressed(ord("C")) && !place_meeting(x, y, oSpikes) && !place_meeting(x, y, oSolid)) {
            spawn_x = x;
            spawn_y = y;
            message = "Surface checkpoint saved";
            message_time = 2;
        }
    } else {
        oxygen = max(0, oxygen - oxygen_use * _dt);
        if (keyboard_check_pressed(ord("C"))) {
            message = "Reach the surface to set a checkpoint";
            message_time = 2;
        }
    }
    if (oxygen <= 0) sub_take_damage("Out of air — return to the surface");
    if (place_meeting(x, y, oSpikes)) sub_take_damage("Watch the spikes");
    image_alpha = respawn_cooldown > 0 ? 0.65 : 1;
}
