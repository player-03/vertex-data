package com.player03.vertexdata;

/**
 * ComponentArray is the type underlying everything else. This isn't
 * itself a vertex buffer, but it contains all the vertex data, and you
 * can upload it using VertexBuffer3D.uploadFromVector().
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
	//Float32Array is the preferred format to upload to OpenGL. Note: if
	//you enable this option, you'll need to use uploadFromFloat32Array()
	//rather than uploadFromVector(). (Or upload it directly if you're an
	//advanced user.)
	#if vertexBuffer_float32Array
		typedef ComponentArray = openfl.utils.Float32Array;
	#else
		typedef ComponentArray = openfl.Vector<Float>;
	#end
#elseif (lime && componentArrayIsFloat32Array)
	typedef ComponentArray = openfl.utils.Float32Array;
#else
	typedef ComponentArray = Array<Float>;
#end
