package com.player03.vertexdata;

/**
 * Data is the array underlying everything else. This isn't itself a
 * vertex buffer, but it contains all the vertex data, and you can
 * upload it with VertexBuffer3D.uploadFromVector() if you're using
 * Flash or OpenFL.
 */

#if customComponentArrayType
	//Defining this will allow you to make a custom typedef specific to
	//your project. Just add a source file to your project named
	//"com/player03/vertexdata/CustomComponentArray.hx".
	//WARNING: This is not recommended unless you know what you're doing.
	typedef Data = com.player03.vertexdata.CustomComponentArray;
#elseif (flash || openfl)
	typedef Data = flash.Vector<Float>;
#elseif lime
	typedef Data = lime.utils.Float32Array;
#else
	@:forward
	abstract Data(Array<Float>) from Array<Float> to Array<Float> {
		public inline function new(length:Int) {
			this = [for(i in 0...length) 0.0];
		}
	}
#end
