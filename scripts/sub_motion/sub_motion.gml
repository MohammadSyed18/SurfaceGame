/// Collision helpers run in the calling submarine instance's scope.
function sub_move_axis(_amount, _horizontal) {
    var _steps = max(1, ceil(abs(_amount)));
    var _increment = _amount / _steps;
    repeat (_steps) {
        var _next_x = x + (_horizontal ? _increment : 0);
        var _next_y = y + (_horizontal ? 0 : _increment);
        if (place_meeting(_next_x, _next_y, oSolid)) {
            if (_horizontal) hspd = 0; else vspd = 0;
            return false;
        }
        x = _next_x;
        y = _next_y;
    }
    return true;
}

function sub_apply_movement(_dt) {
    var _frames = _dt * 60;
    var _horizontal = keyboard_check(vk_right) - keyboard_check(vk_left);
    hspd = _horizontal * move_speed;
    vspd += water_gravity * _frames;
    if (keyboard_check(vk_up)) vspd -= buoyancy_force * _frames;
    if (keyboard_check(vk_down)) vspd += water_gravity * _frames;
    vspd = clamp(vspd, -max_fall_speed, max_fall_speed);
    sub_move_axis(hspd * _frames, true);
    sub_move_axis(vspd * _frames, false);
    // The bounding-box offsets include sprite scaling and facing direction.
    x = clamp(x, x - bbox_left, room_width - (bbox_right - x));
    y = clamp(y, y - bbox_top, room_height - (bbox_bottom - y));
    if (_horizontal != 0) image_xscale = abs(image_xscale) * sign(_horizontal);
}
