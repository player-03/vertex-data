package com.player03.vertexdata;

@:forward
abstract Attribute(AttributeImpl) from AttributeImpl {
	public inline function new(data:Data, ?offset:Int = 0) {
		this = new AttributeImpl(data, offset);
	}
	
	@:arrayAccess private inline function getComponent(index:Int):Float {
		return this.data[this.offset + index];
	}
	
	@:arrayAccess private inline function setComponent(index:Int, value:Float):Float {
		this.data[this.offset + index] = value;
		return value;
	}
	
	public inline function clone():Attribute {
		return new Attribute(this.data, this.offset);
	}
}

class AttributeImpl {
	public var data(default, null):Data;
	public var offset:Int;
	
	public inline function new(data:Data, ?offset:Int = 0) {
		this.data = data;
		this.offset = offset;
	}
}

/**
 * An attribute containing only one Float component.
 */
@:forward(clone)
abstract Attribute1(Attribute) from Attribute to Attribute {
	public var value(get, set):Float;
	
	@:to private inline function get_value():Float {
		return this[0];
	}
	private inline function set_value(value:Float):Float {
		this[0] = value;
		return value;
	}
	
	public inline function toString():String {
		return '$value';
	}
}

/**
 * An attribute containing two Float components.
 */
@:forward(clone)
abstract Attribute2(Attribute) from Attribute to Attribute {
	public var u(get, set):Float;
	public var v(get, set):Float;
	
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	private inline function get_u():Float { return this[0]; }
	private inline function set_u(value:Float):Float { return this[0] = value; }
	private inline function get_v():Float { return this[1]; }
	private inline function set_v(value:Float):Float { return this[1] = value; }
	
	private inline function get_x():Float { return this[0]; }
	private inline function set_x(value:Float):Float { return this[0] = value; }
	private inline function get_y():Float { return this[1]; }
	private inline function set_y(value:Float):Float { return this[1] = value; }
	
	public inline function setUV(u:Float, v:Float):Void { set_u(u); set_v(v); }
	public inline function setXY(x:Float, y:Float):Void { set_x(x); set_y(y); }
	
	@:arrayAccess private inline function getFloat(index:Int):Float {
		return this[index];
	}
	@:arrayAccess private inline function setFloat(index:Int, value:Float):Float {
		return this[index] = value;
	}
	
	public inline function toString():String {
		return '[$u, $v]';
	}
}

/**
 * An attribute containing 3 Float components.
 */
@:forward(clone)
abstract Attribute3(Attribute) from Attribute to Attribute {
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

/**
 * An attribute containing 4 Float components.
 * 
 * Please note: the "w" and "a" properties both represent the *final*
 * component, not the first. This ordering was chosen to match the order
 * used by GLSL. If you find it confusing, just use getFloat() and
 * setFloat() instead.
 */
@:forward(getFloat, setFloat, clone)
abstract Attribute4(Attribute) from Attribute to Attribute {
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
