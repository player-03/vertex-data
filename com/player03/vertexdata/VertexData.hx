package com.player03.vertexdata;

abstract VertexData<T:VertexAttributes<T>>(VertexDataClass<T>) {
	public inline function new(vertices:Int, attributesClass:Class<T>) {
		this = new VertexDataClass<T>(vertices, attributesClass);
	}
	
	@:arrayAccess private inline function get(index:Int):T {
		this.attributes.offset = this.attributes.floatsRequired * index;
		return this.attributes;
	}
	
	public inline function getFloat(index:Int):Float {
		return this.array[index];
	}
	
	public inline function setFloat(index:Int, value:Float):Float {
		return this.array[index] = value;
	}
}

/**
 * Because abstracts cannot have member variables.
 */
class VertexDataClass<T:VertexAttributes<T>> {
	public var attributes:T;
	public var array:VertexDataArrayType;
	
	public function new(vertices:Int, attributesClass:Class<T>) {
		attributes = Type.createInstance(attributesClass, [cast this]);
		
		array = new VertexDataArrayType(vertices * attributes.floatsRequired);
	}
}
