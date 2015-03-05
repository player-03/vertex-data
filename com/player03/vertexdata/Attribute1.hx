package com.player03.vertexdata;

/**
 * A scalar attribute.
 * 
 * If you create a property of this type, it will be converted to a Float
 * at compile time. For instance, if you define "var alpha:Attribute1" in
 * your subclass of VertexAttributes, you'll be able to set it this way:
 * 
 * vertices[0].alpha = 0.5;
 * 
 * However, if you look up the property dynamically (using getAttribute1()),
 * it will not be converted. To set alpha to 0.5, you'd run this:
 * 
 * vertices[0].getAttribute1("alpha").value = 0.5
 */
abstract Attribute1(Offset) from Offset {
	public var value(get, set):Float;
	
	@:to private inline function get_value():Float {
		return this[0];
	}
	private inline function set_value(value:Float):Float {
		return this[0] = value;
	}
	
	public inline function toString():String {
		return '$value';
	}
}
