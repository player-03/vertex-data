package com.player03.vertexdata;

abstract VertexData<T:VertexAttributes>(T) {
	public inline function new(vertexCount:Int, attributesClass:Class<T>) {
		this = Type.createInstance(attributesClass, [vertexCount]);
	}
	
	@:arrayAccess private inline function get(index:Int):T {
		this.offset = this.floatsRequired * index;
		return this;
	}
	
	@:arrayAccess private inline function set(index:Int, value:T):Void {
		index *= this.floatsRequired;
		for(i in 0...this.floatsRequired) {
			setFloat(index + i, value.array[value.offset + i]);
		}
	}
	
	public inline function getFloat(index:Int):Float {
		return this.array[index];
	}
	
	public inline function setFloat(index:Int, value:Float):Float {
		return this.array[index] = value;
	}
	
	public inline function toString():String {
		var buffer:StringBuf = new StringBuf();
		for(i in 0...this.array.length) {
			if(i > 0) {
				buffer.add(", ");
			}
			buffer.add(this.array[i]);
		}
		return "[" + buffer.toString() + "]";
	}
	
	public inline function iterator():Iterator<T> {
		return new VertexDataIterator(cast this, Std.int(this.array.length / this.floatsRequired));
	}
}

class VertexDataIterator<T:VertexAttributes> {
	private var data:VertexData<T>;
	private var index:Int = 0;
	private var length:Int;
	
	public function new(data:VertexData<T>, length:Int) {
		this.data = data;
		this.length = length;
	}
	
	public function hasNext():Bool {
		return index < length;
	}
	
	public function next():T {
		return data[index++];
	}
}
