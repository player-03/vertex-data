package com.player03.vertexdata;

#if customComponentArrayType
//Defining this will allow you to make a custom typedef specific to your project.
//Just put a "com/player03/vertexdata/CustomComponentArray.hx" file in your
//project's source folder.
//WARNING: This is not recommended unless you really know what you're doing.
typedef ComponentArray = com.player03.vertexdata.CustomComponentArray;
#elseif flash
/**
 * The type underlying everything else. This isn't itself a vertex buffer,
 * but it contains all the same data, and you can upload it using
 * VertexBuffer3D.uploadFromVector().
 */
typedef ComponentArray = flash.Vector<Float>;
#elseif openfl
typedef ComponentArray = openfl.Vector<Float>;
#else
typedef ComponentArray = Array<Float>;
#end
