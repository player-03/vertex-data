package com.player03.vertexdata;

#if 0
//USAGE EXAMPLE

//Sample vertex attributes, defining position (xyz) and color (rgb) for each
//vertex. Each PositionAndColor object will correspond to 6 consecutive
//values in the VertexData array.

//A constructor will be generated automatically for all subclasses of
//VertexAttributes, and if you define one yourself, it will be replaced.
//All variables of type Float1, Float2, Float3, and Float4 will be
//instantiated automatically. All others will be ignored.
class PositionAndColor extends VertexAttributes<PositionAndColor> {
	var position:Float3;
	var color:Float3;
}

//To create a vertex array with position+color vextices:
//var data:VertexData<PositionAndColor> = new VertexData(3, PositionAndColor);
#end

@:autoBuild(com.player03.vertexdata.VertexAttributesBuilder.build())
@:allow(com.player03.vertexdata.VertexData)
class VertexAttributes<T:VertexAttributes<T>> {
	private var data:IndexInArray<T>;
	
	/**
	 * The offset of this vertex in the larger array.
	 */
	private var offset:Int = 0;
	
	/**
	 * The number of bytes required to fully define a single vertex.
	 */
	public var bytesRequired(get, never):Int;
	
	/**
	 * The number of 32-bit Floats required to fully define a single vertex.
	 */
	public var floatsRequired(default, null):Int;
	
	private function new(data:VertexData<T>, floatsRequired:Int) {
		this.data = new IndexInArray(data);
		this.floatsRequired = floatsRequired;
	}
	
	private inline function get_bytesRequired():Int {
		return floatsRequired * 4;
	}
}

class IndexInArray<T:VertexAttributes<T>> {
	public var array:VertexData<T>;
	public var index:Int;
	
	public function new(array:VertexData<T>, ?index:Int = 0) {
		this.array = array;
		this.index = index;
	}
	
	public inline function getFloat(index:Int):Float {
		return array.getFloat(this.index + index);
	}
	
	public inline function setFloat(index:Int, value:Float):Float {
		return array.setFloat(this.index + index, value);
	}
	
	public inline function clone():IndexInArray<T> {
		return new IndexInArray(array, index);
	}
}

abstract Float1<T:VertexAttributes<T>>(IndexInArray<T>) from IndexInArray<T> {
	public var floatValue(get, set):Float;
	
	@:to private inline function get_floatValue():Float {
		return this.getFloat(0);
	}
	
	private inline function set_floatValue(value:Float):Float {
		return this.setFloat(0, value);
	}
	
	public inline function toString():String {
		return '$floatValue';
	}
}

@:forward(getFloat, setFloat)
abstract Float2<T:VertexAttributes<T>>(IndexInArray<T>) from IndexInArray<T> {
	public var u(get, set):Float;
	public var v(get, set):Float;
	
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	private inline function get_u():Float { return this.getFloat(0); }
	private inline function set_u(value:Float):Float { return this.setFloat(0, value); }
	private inline function get_v():Float { return this.getFloat(1); }
	private inline function set_v(value:Float):Float { return this.setFloat(1, value); }
	
	private inline function get_x():Float { return this.getFloat(0); }
	private inline function set_x(value:Float):Float { return this.setFloat(0, value); }
	private inline function get_y():Float { return this.getFloat(1); }
	private inline function set_y(value:Float):Float { return this.setFloat(1, value); }
	
	public inline function toString():String {
		return '[$u, $v]';
	}
}

@:forward(getFloat, setFloat)
abstract Float3<T:VertexAttributes<T>>(IndexInArray<T>) from IndexInArray<T> {
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	
	public var r(get, set):Float;
	public var g(get, set):Float;
	public var b(get, set):Float;
	
	private inline function get_x():Float { return this.getFloat(0); }
	private inline function set_x(value:Float):Float { return this.setFloat(0, value); }
	private inline function get_y():Float { return this.getFloat(1); }
	private inline function set_y(value:Float):Float { return this.setFloat(1, value); }
	private inline function get_z():Float { return this.getFloat(2); }
	private inline function set_z(value:Float):Float { return this.setFloat(2, value); }
	
	private inline function get_r():Float { return this.getFloat(0); }
	private inline function set_r(value:Float):Float { return this.setFloat(0, value); }
	private inline function get_g():Float { return this.getFloat(1); }
	private inline function set_g(value:Float):Float { return this.setFloat(1, value); }
	private inline function get_b():Float { return this.getFloat(2); }
	private inline function set_b(value:Float):Float { return this.setFloat(2, value); }
	
	public inline function toString():String {
		return '[$x, $y, $z]';
	}
}

/**
 * Please note: the "w" and "a" properties represent the *final* slot,
 * not the first. This may conflict with what you're used to, and may or
 * may not also conflict with GLSL's ordering.
 * 
 * To avoid confusion, I suggest using getFloat() and setFloat() instead.
 */
@:forward(getFloat, setFloat)
abstract Float4<T:VertexAttributes<T>>(IndexInArray<T>) from IndexInArray<T> {
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var w(get, set):Float;
	
	public var r(get, set):Float;
	public var g(get, set):Float;
	public var b(get, set):Float;
	public var a(get, set):Float;
	
	private inline function get_x():Float { return this.getFloat(0); }
	private inline function set_x(value:Float):Float { return this.setFloat(0, value); }
	private inline function get_y():Float { return this.getFloat(1); }
	private inline function set_y(value:Float):Float { return this.setFloat(1, value); }
	private inline function get_z():Float { return this.getFloat(2); }
	private inline function set_z(value:Float):Float { return this.setFloat(2, value); }
	private inline function get_w():Float { return this.getFloat(3); }
	private inline function set_w(value:Float):Float { return this.setFloat(3, value); }
	
	private inline function get_r():Float { return this.getFloat(0); }
	private inline function set_r(value:Float):Float { return this.setFloat(0, value); }
	private inline function get_g():Float { return this.getFloat(1); }
	private inline function set_g(value:Float):Float { return this.setFloat(1, value); }
	private inline function get_b():Float { return this.getFloat(2); }
	private inline function set_b(value:Float):Float { return this.setFloat(2, value); }
	private inline function get_a():Float { return this.getFloat(3); }
	private inline function set_a(value:Float):Float { return this.setFloat(3, value); }
	
	public inline function toString():String {
		return '[$x, $y, $z, $w]';
	}
}
