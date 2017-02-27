package com.player03.vertexdata;

/**
 * ComponentArray is the type underlying everything else. This isn't
 * itself a vertex buffer, but it contains all the vertex data, and you
 * can upload it using either VertexBuffer3D.uploadFromVector() or
 * VertexBuffer3D.uploadFromTypedArray().
 */

#if customComponentArrayType
	//Defining this will allow you to make a custom typedef specific to
	//your project. Just add a source file to your project named
	//"com/player03/vertexdata/CustomComponentArray.hx".
	//WARNING: This is not recommended unless you know what you're doing.
	typedef ComponentArray = com.player03.vertexdata.CustomComponentArray;
#elseif flash
	typedef ComponentArray = flash.Vector<Float>;
#elseif openfl
	//Float32Array is the preferred format to upload to OpenGL.
	typedef ComponentArray = openfl.utils.Float32Array;
#elseif lime
	typedef ComponentArray = lime.utils.Float32Array;
#else
	typedef ComponentArray = Array<Float>;
#end
