package com.player03.vertexdata;

@:forward(bytesPerVertex, componentsPerVertex, attributes, array)
abstract VertexArray<T:Vertex>(T) {
	/**
	 * The number of vertices in this array.
	 */
	public var vertexCount(get, never):Int;
	
	/**
	 * The number of components in all the vertices in this array.
	 */
	public var componentCount(get, never):Int;
	
	public inline function new(?length:Int, ?array:ComponentArray, vertexClass:Class<T>) {
		this = Type.createInstance(vertexClass, [length, array]);
	}
	
	private inline function get_vertexCount():Int {
		return Std.int(this.array.length / this.componentsPerVertex);
	}
	@:arrayAccess private inline function get(index:Int):T {
		this.offset = this.componentsPerVertex * index;
		return this;
	}
	@:arrayAccess private inline function set(index:Int, value:T):Void {
		index *= this.componentsPerVertex;
		for(i in 0...this.componentsPerVertex) {
			setComponent(index + i, value.array[value.offset + i]);
		}
	}
	
	private inline function get_componentCount():Int {
		return this.array.length;
	}
	public inline function getComponent(index:Int):Float {
		return this.array[index];
	}
	public inline function setComponent(index:Int, value:Float):Float {
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
		return new VertexIterator(cast this, get_vertexCount());
	}
	
	/**
	 * Returns the named attribute for each vertex in this array.
	 */
	public function attributeIterator(attributeName:String):Iterator<Offset> {
		var size:Int = 0;
		for(i in 0...this.attributes.length) {
			if(this.attributes[i].name == attributeName) {
				size = this.attributes[i].size;
				break;
			}
		}
		switch(size) {
			case 1:
				return new Attribute1Iterator(cast this, attributeName, get_vertexCount());
			case 2:
				return new Attribute2Iterator(cast this, attributeName, get_vertexCount());
			case 3:
				return new Attribute3Iterator(cast this, attributeName, get_vertexCount());
			case 4:
				return new Attribute4Iterator(cast this, attributeName, get_vertexCount());
			default:
				return null;
		}
	}
}

class VertexIterator<T:Vertex> {
	private var vertices:VertexArray<T>;
	private var index:Int = 0;
	private var length:Int;
	
	public function new(vertices:VertexArray<T>, length:Int) {
		this.vertices = vertices;
		this.length = length;
	}
	
	public function hasNext():Bool {
		return index < length;
	}
	
	public function next():T {
		return vertices[index++];
	}
}

class AttributeIterator {
	private var vertices:VertexArray<Vertex>;
	private var attributeName:String;
	private var index:Int = 0;
	private var length:Int;
	
	public function new(vertices:VertexArray<Vertex>, attributeName:String, length:Int) {
		this.vertices = vertices;
		this.attributeName = attributeName;
		this.length = length;
	}
	
	public inline function hasNext():Bool {
		return index < length;
	}
}

class Attribute1Iterator extends AttributeIterator {
	/**
	 * Bonus functionality: returns the attribute for the given vertex.
	 * Does not interfere with iteration.
	 */
	public inline function get(index:Int):Attribute1 {
		return vertices[index++].getAttribute1(attributeName);
	}
	
	public inline function next():Attribute1 {
		return vertices[index++].getAttribute1(attributeName);
	}
}

class Attribute2Iterator extends AttributeIterator {
	/**
	 * Bonus functionality: returns the attribute for the given vertex.
	 * Does not interfere with iteration.
	 */
	public inline function get(index:Int):Attribute2 {
		return vertices[index++].getAttribute2(attributeName);
	}
	
	public inline function next():Attribute2 {
		return vertices[index++].getAttribute2(attributeName);
	}
}

class Attribute3Iterator extends AttributeIterator {
	/**
	 * Bonus functionality: returns the attribute for the given vertex.
	 * Does not interfere with iteration.
	 */
	public inline function get(index:Int):Attribute3 {
		return vertices[index++].getAttribute3(attributeName);
	}
	
	public inline function next():Attribute3 {
		return vertices[index++].getAttribute3(attributeName);
	}
}

class Attribute4Iterator extends AttributeIterator {
	/**
	 * Bonus functionality: returns the attribute for the given vertex.
	 * Does not interfere with iteration.
	 */
	public inline function get(index:Int):Attribute4 {
		return vertices[index++].getAttribute4(attributeName);
	}
	
	public inline function next():Attribute4 {
		return vertices[index++].getAttribute4(attributeName);
	}
}
