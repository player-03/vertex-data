package com.player03.vertexdata;

#if customVertexDataArrayType
//Defining this will allow you to make a custom typedef specific to your project
//WARNING: This is not recommended unless you really know what you're doing.
#elseif flash
typedef VertexDataArrayType = flash.Vector<Float>;
#elseif openfl
typedef VertexDataArrayType = openfl.utils.Float32Array;
#else
typedef VertexDataArrayType = Array<Float>;
#end
