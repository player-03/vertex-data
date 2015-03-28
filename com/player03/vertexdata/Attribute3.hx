package com.player03.vertexdata;

/**
 * An attribute containing 3 Float components.
 */
@:forward(clone)
abstract Attribute3(Offset) from Offset to Offset {
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	
	public var r(get, set):Float;
	public var g(get, set):Float;
	public var b(get, set):Float;
	
	/**
	 * Converts the float values to/from integer format.
	 * 
	 * For instance, "rgb = 0xFF8000" will set r=1, g=0.5, and b=0.
	 */
	public var rgb(get, set):Int;
	
	private inline function get_x():Float { return this[0]; }
	private inline function set_x(value:Float):Float { return this[0] = value; }
	private inline function get_y():Float { return this[1]; }
	private inline function set_y(value:Float):Float { return this[1] = value; }
	private inline function get_z():Float { return this[2]; }
	private inline function set_z(value:Float):Float { return this[2] = value; }
	
	private inline function get_r():Float { return this[0]; }
	private inline function set_r(value:Float):Float { return this[0] = value; }
	private inline function get_g():Float { return this[1]; }
	private inline function set_g(value:Float):Float { return this[1] = value; }
	private inline function get_b():Float { return this[2]; }
	private inline function set_b(value:Float):Float { return this[2] = value; }
	
	private inline function get_rgb():Int {
		return Std.int(r * 0xFF) << 16
			| Std.int(g * 0xFF) << 8
			| Std.int(b * 0xFF);
	}
	private inline function set_rgb(value:Int):Int {
		r = ((value >> 16) & 0xFF) / 0xFF;
		g = ((value >> 8) & 0xFF) / 0xFF;
		b = (value & 0xFF) / 0xFF;
		return value;
	}
	
	public inline function setXYZ(x:Float, y:Float, z:Float):Void { set_x(x); set_y(y); set_z(z); }
	public inline function setRGB(r:Float, g:Float, b:Float):Void { set_r(r); set_g(g); set_b(b); }
	
	@:arrayAccess private inline function getFloat(index:Int):Float {
		return this[index];
	}
	@:arrayAccess private inline function setFloat(index:Int, value:Float):Float {
		return this[index] = value;
	}
	
	public inline function toString():String {
		return '[$x, $y, $z]';
	}
}
