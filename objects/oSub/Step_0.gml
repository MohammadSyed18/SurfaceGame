// Apply natural sinking
vspd += water_gravity;

// Limit fall speed
vspd = clamp(vspd, -max_fall_speed, max_fall_speed);

// Horizontal movement
hspd = 0;

if (keyboard_check(vk_left)) {
    hspd = -move_speed;
}

if (keyboard_check(vk_right)) {
    hspd = move_speed;
}





// Tap up to rise
if (keyboard_check(vk_up)) {
    vspd -= buoyancy_force;
}

// Hold down to sink faster
if (keyboard_check(vk_down)) {
    vspd += water_gravity;
}


// ==============================
// MOVEMENT + SAFE COLLISION
// ==============================

// Horizontal movement first
x += hspd;

if (place_meeting(x, y, oSolid)) {
    x -= hspd;   // Move back
    hspd = 0;
}

// Vertical movement second
y += vspd;

if (place_meeting(x, y, oSolid)) {
    y -= vspd;   // Move back
    vspd = 0;
}


// Stop at bottom of room (extra safety)
if (y > room_height - sprite_height / 2) {
    y = room_height - sprite_height / 2;
    vspd = 0;
}

// Check collision with any child of obj_parent_solid
if (place_meeting(x, y, oSpikes)) {
    // Teleport submarine to bottom-right corner
    x = room_width - sprite_width/2;
    y = room_height - sprite_height/2;
    
    // Optional: reset velocity so it doesn't keep moving
    hspd = 0;
    vspd = 0;
}





if keyboard_check(vk_right) {

    x_speed = move_speed; 

    image_xscale = .2967033; // flip heidi's sprite so she faces right

} else if keyboard_check(vk_left) {
    x_speed = -move_speed; 

    image_xscale = -.2967033; // reset her sprite so she faces left

}