/// @description Insert description here

z = 0;
look_dir = 0;
look_pitch = 0;

c_shape = c_shape_create();
c_shape_add_sphere(c_shape, 16);
c_object = c_object_create(c_shape, C_MASK_ALL, C_MASK_PLAYER);