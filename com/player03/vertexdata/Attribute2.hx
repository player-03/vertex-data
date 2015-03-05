package com.player03.vertexdata;

/**
 * An attribute containing two Float components.
 */
abstract Attribute2(Offset) from Offset {
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
