package com.player03.vertexdata;
import com.player03.vertexdata.Offset.ConcreteOffset;

/**
 * Represents an offset within an array, as if the previous
 * values had been removed from the array. C programmers could
 * just use a pointer to accomplish this, but this needs to
 * support other languages than just C.
 */
@:forward
abstract Offset(ConcreteOffset) from ConcreteOffset {
	public inline function new(array:ComponentArray, ?offset:Int = 0) {
		this = new ConcreteOffset(array, offset);
	}
	
	@:arrayAccess private inline function getFloat(index:Int):Float {
		return this.array[this.offset + index];
	}
	
	@:arrayAccess private inline function setFloat(index:Int, value:Float):Float {
		this.array[this.offset + index] = value;
		return value;
	}
	
	public inline function clone():Offset {
		return new Offset(this.array, this.offset);
	}
}

/**
 * Because abstracts can't store two values at once.
 */
class ConcreteOffset {
	public var array:ComponentArray;
	public var offset:Int;
	
	public inline function new(array:ComponentArray, ?offset:Int = 0) {
		this.array = array;
		this.offset = offset;
	}
}
