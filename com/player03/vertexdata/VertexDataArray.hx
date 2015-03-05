package com.player03.vertexdata;

#if customVertexDataArray
//Defining this will allow you to make a custom typedef specific to your project
//WARNING: This is not recommended unless you really know what you're doing.
#elseif flash
typedef VertexDataArray = flash.Vector<Float>;
#elseif openfl
typedef VertexDataArray = openfl.utils.Float32Array;
#else
typedef VertexDataArray = Array<Float>;
#end
