/// @description Set up 3D things

// Bad things happen if you turn off the depth buffer in 3D
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

c_init();
c_world_create();

#region vertex format setup
// Vertex format: data must go into vertex buffers in the order defined by this
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vertex_format = vertex_format_end();
#endregion

#region create the grid
vbuffer = vertex_create_buffer();
vertex_begin(vbuffer, vertex_format);

// Create a checkerboard pattern on the floor
var s = 128;
for (var i = 0; i < room_width; i += s) {
    for (var j = 0; j < room_height; j += s) {
        if ((i % (s * 2) == 0 && j % (s * 2) == 0) || (i % (s * 2) > 0 && j % (s * 2) > 0)) {
            var color = c_aqua;
        } else {
            var color = c_white;
        }
        
        #region add data to the vertex buffer
        vertex_add_point(vbuffer, i, j, 0,                  0, 0, 1,        0, 0,       color, 1);
        vertex_add_point(vbuffer, i + s, j, 0,              0, 0, 1,        1, 0,       color, 1);
        vertex_add_point(vbuffer, i + s, j + s, 0,          0, 0, 1,        1, 1,       color, 1);

        vertex_add_point(vbuffer, i + s, j + s, 0,          0, 0, 1,        1, 1,       color, 1);
        vertex_add_point(vbuffer, i, j + s, 0,              0, 0, 1,        0, 1,       color, 1);
        vertex_add_point(vbuffer, i, j, 0,                  0, 0, 1,        0, 0,       color, 1);
        #endregion
    }
}

vertex_end(vbuffer);
#endregion

instance_create_depth(0, 0, 0, Player);

vb_player = load_model("player.d3d");

vb_cube = load_model("cube.d3d");
vb_octagon = load_model("octagon.d3d");
vb_forcefield = load_model("forcefield.d3d");

///////////////////////////////////////////////////

c_shape_cube = c_shape_create();
c_shape_begin_trimesh();
c_shape_load_trimesh("cube.d3d");
c_shape_end_trimesh(c_shape_cube);
c_shape_octagon = c_shape_create();
c_shape_begin_trimesh();
c_shape_load_trimesh("octagon.d3d");
c_shape_end_trimesh(c_shape_octagon);
c_shape_forcefield = c_shape_create();
c_shape_begin_trimesh();
c_shape_load_trimesh("forcefield.d3d");
c_shape_end_trimesh(c_shape_forcefield);

c_obj_cube = c_object_create(c_shape_cube, C_MASK_ALL, C_MASK_ALL);
c_world_add_object(c_obj_cube);
c_transform_position(400, 200, 0);
c_object_apply_transform(c_obj_cube);
c_transform_identity();

c_obj_cube_2 = c_object_create(c_shape_cube, C_MASK_ALL, C_MASK_ALL);
c_world_add_object(c_obj_cube_2);
c_transform_position(300, 300, 0);
c_object_apply_transform(c_obj_cube_2);
c_transform_identity();

c_obj_octagon = c_object_create(c_shape_octagon, C_MASK_ALL, C_MASK_ALL);
c_world_add_object(c_obj_octagon);
c_transform_position(600, 200, 0);
c_object_apply_transform(c_obj_octagon);
c_transform_identity();

c_obj_forcefield = c_object_create(c_shape_forcefield, C_MASK_BALL, C_MASK_BALL);
c_world_add_object(c_obj_forcefield);
c_transform_position(800, 0, 0);
c_object_apply_transform(c_obj_forcefield);
c_transform_identity();

#macro C_MASK_PLAYER        0x01
#macro C_MASK_BALL          0x02
#macro C_MASK_ALL           C_MASK_PLAYER | C_MASK_BALL