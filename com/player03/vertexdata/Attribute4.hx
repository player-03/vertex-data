package com.player03.vertexdata;

/**
 * An attribute containing 4 Float components.
 * 
 * Please note: the "w" and "a" properties both represent the *final*
 * component, not the first. This ordering was chosen to match the order
 * used by GLSL. If you find it confusing, just use getFloat() and
 * setFloat() instead.
 */
@:forward(getFloat, setFloat)
abstract Attribute4(Offset) from Offset {
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var w(get, set):Float;
	
	public var r(get, set):Float;
	public var g(get, set):Float;
	public var b(get, set):Float;
	public var a(get, set):Float;
	
	/**
	 * Converts the float values to/from integer format. Note that the
	 * byte order of the integer (ARGB) is different from the order of
	 * the float values (RGBA).
	 * 
	 * For instance, "argb = 0xFF008000" will set r=0, g=0.5, b=0, and a=1.
	 */
	public var argb(get, set):Int;
	
	private inline function get_x():Float { return this[0]; }
	private inline function set_x(value:Float):Float { return this[0] = value; }
	private inline function get_y():Float { return this[1]; }
	private inline function set_y(value:Float):Float { return this[1] = value; }
	private inline function get_z():Float { return this[2]; }
	private inline function set_z(value:Float):Float { return this[2] = value; }
	private inline function get_w():Float { return this[3]; }
	private inline function set_w(value:Float):Float { return this[3] = value; }
	
	private inline function get_r():Float { return this[0]; }
	private inline function set_r(value:Float):Float { return this[0] = value; }
	private inline function get_g():Float { return this[1]; }
	private inline function set_g(value:Float):Float { return this[1] = value; }
	private inline function get_b():Float { return this[2]; }
	private inline function set_b(value:Float):Float { return this[2] = value; }
	private inline function get_a():Float { return this[3]; }
	private inline function set_a(value:Float):Float { return this[3] = value; }
	
	private inline function get_argb():Int {
		return Std.int(a * 0xFF) << 24
			| Std.int(r * 0xFF) << 16
			| Std.int(g * 0xFF) << 8
			| Std.int(b * 0xFF);
	}
	private inline function set_argb(value:Int):Int {
		a = (value >>> 24) / 0xFF;
		r = ((value >> 16) & 0xFF) / 0xFF;
		g = ((value >> 8) & 0xFF) / 0xFF;
		b = (value & 0xFF) / 0xFF;
		return value;
	}
	
	public inline function setXYZW(x:Float, y:Float, z:Float, w:Float):Void {
		set_x(x);
		set_y(y);
		set_z(z);
		set_w(w);
	}
	public inline function setRGBA(r:Float, g:Float, b:Float, a:Float):Void {
		set_r(r);
		set_g(g);
		set_b(b);
		set_a(a);
	}
	
	@:arrayAccess private inline function getFloat(index:Int):Float {
		return this[index];
	}
	@:arrayAccess private inline function setFloat(index:Int, value:Float):Float {
		return this[index] = value;
	}
	
	public inline function toString():String {
		return '[$x, $y, $z, $w]';
	}
}
