// Movement values are calibrated to a 60 Hz reference frame.
var frame_scale = clamp(delta_time / (1000000 / 60), 0, 3);
respawn_cooldown = max(0, respawn_cooldown - frame_scale);
var horizontal = keyboard_check(vk_right) - keyboard_check(vk_left);
hspd = horizontal * move_speed;
vspd += water_gravity * frame_scale;
if (keyboard_check(vk_up)) vspd -= buoyancy_force * frame_scale;
if (keyboard_check(vk_down)) vspd += water_gravity * frame_scale;
vspd = clamp(vspd, -max_fall_speed, max_fall_speed);

// Advance in subpixel increments so a fast frame cannot cross a thin wall.
var dx = hspd * frame_scale;
var steps_x = max(1, ceil(abs(dx)));
var step_x = dx / steps_x;
repeat (steps_x) {
    if (place_meeting(x + step_x, y, oSolid)) {
        hspd = 0;
        break;
    }
    x += step_x;
}
var dy = vspd * frame_scale;
var steps_y = max(1, ceil(abs(dy)));
var step_y = dy / steps_y;
repeat (steps_y) {
    if (place_meeting(x, y + step_y, oSolid)) {
        vspd = 0;
        break;
    }
    y += step_y;
}

// Bounds use the collision box, including sprite scale and facing direction.
x = clamp(x, x - bbox_left, room_width - (bbox_right - x));
y = clamp(y, y - bbox_top, room_height - (bbox_bottom - y));
if (horizontal != 0) image_xscale = abs(image_xscale) * sign(horizontal);

if (respawn_cooldown <= 0 && place_meeting(x, y, oSpikes)) {
    x = spawn_x;
    y = spawn_y;
    hspd = 0;
    vspd = 0;
    respawn_cooldown = 30;
}
image_alpha = respawn_cooldown > 0 ? 0.65 : 1;
