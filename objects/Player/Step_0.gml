/// @description Insert description here

look_dir -= (window_mouse_get_x() - window_get_width() / 2) / 10;
look_pitch -= (window_mouse_get_y() - window_get_height() / 2) / 10;
look_pitch = clamp(look_pitch, 10, 80);

window_mouse_set(window_get_width() / 2, window_get_height() / 2);

if (keyboard_check_direct(vk_escape)) {
    game_end();
}

var move_speed = 4;
var dx = 0;
var dy = 0;

if (keyboard_check(ord("A"))) {
    dx -= dsin(look_dir) * move_speed;
    dy -= dcos(look_dir) * move_speed;
}

if (keyboard_check(ord("D"))) {
    dx += dsin(look_dir) * move_speed;
    dy += dcos(look_dir) * move_speed;
}

if (keyboard_check(ord("W"))) {
    dx += dcos(look_dir) * move_speed;
    dy -= dsin(look_dir) * move_speed;
}

if (keyboard_check(ord("S"))) {
    dx -= dcos(look_dir) * move_speed;
    dy += dsin(look_dir) * move_speed;
}

if (!c_overlap_position(c_object, x + dx, y, z)) {
    x += dx;
}

if (!c_overlap_position(c_object, x, y + dy, z)) {
    y += dy;
}

if (mouse_check_button_pressed(mb_left)) {
    var ball = instance_create_depth(x, y, z + 16, Ball);
    ball.xspeed = 4 * dcos(look_dir);
    ball.yspeed = 4 * -dsin(look_dir);
    ball.zspeed = 4;
}