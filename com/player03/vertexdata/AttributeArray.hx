package com.player03.vertexdata;

import com.player03.vertexdata.Attribute;

/**
 * Iterates over all instances of a given attribute.
 */
@:forward
abstract AttributeArray(AttributeArrayImpl) from AttributeArrayImpl {
	public inline function new(data:Data, offset:Int, stride:Int, length:Int) {
		this = new AttributeArrayImpl(new Attribute(data), offset, stride, length);
	}
	
	@:arrayAccess private inline function get(index:Int):Attribute {
		this.attribute.offset = this.offset + index * this.stride;
		return this.attribute;
	}
	
	public inline function clone():AttributeArray {
		return new AttributeArray(this.attribute.data, this.offset, this.stride, this.length);
	}
	
	public inline function iterator():AttributeIterator {
		return new AttributeIterator(this);
	}
}
class AttributeArrayImpl {
	public var attribute(default, null):Attribute;
	public var offset:Int;
	public var stride:Int;
	public var length:Int;
	
	public function new(attribute:Attribute, offset:Int, stride:Int, length:Int) {
		this.attribute = attribute;
		this.offset = offset;
		this.stride = stride;
		this.length = length;
	}
}
private class AttributeIterator {
	public var array:AttributeArray;
	public var index:Int = 0;
	
	public inline function new(array:AttributeArray) {
		this.array = array;
	}
	
	public inline function hasNext():Bool {
		return index < array.length;
	}
	
	public inline function next():Attribute {
		return array[index];
	}
}

@:forward(clone, length)
abstract Attribute1Array(AttributeArray) from AttributeArray {
	@:arrayAccess private inline function get(index:Int):Attribute1 {
		return this[index];
	}
	
	public inline function iterator():Attribute1Iterator {
		return new Attribute1Iterator(this);
	}
}
private class Attribute1Iterator {
	public var array:Attribute1Array;
	public var index:Int = 0;
	
	public inline function new(array:Attribute1Array) {
		this.array = array;
	}
	
	public inline function hasNext():Bool {
		return index < array.length;
	}
	
	public inline function next():Attribute1 {
		return array[index];
	}
}

@:forward(clone, length)
abstract Attribute2Array(AttributeArray) from AttributeArray {
	@:arrayAccess private inline function get(index:Int):Attribute2 {
		return this[index];
	}
	
	public inline function iterator():Attribute2Iterator {
		return new Attribute2Iterator(this);
	}
}
private class Attribute2Iterator {
	public var array:Attribute2Array;
	public var index:Int = 0;
	
	public inline function new(array:Attribute2Array) {
		this.array = array;
	}
	
	public inline function hasNext():Bool {
		return index < array.length;
	}
	
	public inline function next():Attribute2 {
		return array[index];
	}
}

@:forward(clone, length)
abstract Attribute3Array(AttributeArray) from AttributeArray {
	@:arrayAccess private inline function get(index:Int):Attribute3 {
		return this[index];
	}
	
	public inline function iterator():Attribute3Iterator {
		return new Attribute3Iterator(this);
	}
}
private class Attribute3Iterator {
	public var array:Attribute3Array;
	public var index:Int = 0;
	
	public inline function new(array:Attribute3Array) {
		this.array = array;
	}
	
	public inline function hasNext():Bool {
		return index < array.length;
	}
	
	public inline function next():Attribute3 {
		return array[index];
	}
}

@:forward(clone, length)
abstract Attribute4Array(AttributeArray) from AttributeArray {
	@:arrayAccess private inline function get(index:Int):Attribute4 {
		return this[index];
	}
	
	public inline function iterator():Attribute4Iterator {
		return new Attribute4Iterator(this);
	}
}
private class Attribute4Iterator {
	public var array:Attribute4Array;
	public var index:Int = 0;
	
	public inline function new(array:Attribute4Array) {
		this.array = array;
	}
	
	public inline function hasNext():Bool {
		return index < array.length;
	}
	
	public inline function next():Attribute4 {
		return array[index];
	}
}
