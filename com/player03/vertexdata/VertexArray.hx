package com.player03.vertexdata;

@:forward(bytesPerVertex, componentsPerVertex, attributes, array)
abstract VertexArray(Vertex) {
	/**
	 * The number of vertices in this array.
	 */
	public var vertexCount(get, never):Int;
	
	/**
	 * The number of components in all the vertices in this array.
	 */
	public var componentCount(get, never):Int;
	
	public inline function new(vertexClass:Class<Vertex>, ?length:Int, ?array:ComponentArray) {
		this = Type.createInstance(vertexClass, [length, array]);
	}
	
	private inline function get_vertexCount():Int {
		return Std.int(this.array.length / this.componentsPerVertex);
	}
	@:arrayAccess private inline function get(index:Int):Vertex {
		this.offset = this.componentsPerVertex * index;
		return this;
	}
	@:arrayAccess private inline function set(index:Int, value:Vertex):Void {
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
	
	public inline function iterator():Iterator<Vertex> {
		return new VertexIterator(cast this);
	}
	
	/**
	 * Returns the named attribute for each vertex in this array. By
	 * default, it iterates over Offset objects, but you may cast them
	 * to Attribute1, Attribute2, Attribute3, or Attribute4. (If you do,
	 * it's your responsibility to make sure you cast them to the correct
	 * type.)
	 * 
	 * Also, it actually only iterates over a single Offset object. If
	 * you want to save the value at any one index, use the clone() method.
	 * 
	 * Bonus: you can store the AttributeIterator object and use the get()
	 * method to get the attribute at a specific index.
	 */
	public function attributeIterator(attributeName:String):AttributeIterator {
		return new AttributeIterator(cast this, attributeName);
	}
}

private class VertexIterator {
	private var vertices:VertexArray;
	private var index:Int = 0;
	private var length:Int;
	
	public function new(vertices:VertexArray) {
		this.vertices = vertices;
		length = vertices.vertexCount;
	}
	
	public function hasNext():Bool {
		return index < length;
	}
	
	public function next():Vertex {
		return vertices[index++];
	}
}

class AttributeIterator {
	private var vertices:VertexArray;
	private var attributeName:String;
	private var index:Int = 0;
	private var length:Int;
	private var offsetWithinVertex:Int;
	private var offsetToReturn:Offset;
	
	public function new(vertices:VertexArray, attributeName:String) {
		this.vertices = vertices;
		this.attributeName = attributeName;
		length = vertices.vertexCount;
		
		//Store the Offset object for later reuse.
		offsetToReturn = vertices[0].getAttribute(attributeName);
		
		//Because vertices[0] has an offset of 0, this value is equal to
		//the offset of the attribute.
		offsetWithinVertex = offsetToReturn.offset;
	}
	
	public inline function hasNext():Bool {
		return index < length;
	}
	
	/**
	 * Bonus functionality: returns the attribute for the given vertex.
	 * Does not interfere with iteration.
	 */
	public inline function get(index:Int):Offset {
		offsetToReturn.offset = vertices[index].offset + offsetWithinVertex;
		return offsetToReturn;
	}
	
	public inline function next():Offset {
		return get(index++);
	}
	
	public inline function iterator():AttributeIterator {
		return this;
	}
}

//Use these abstracts to automatically cast AttributeIterator's return values:

@:forward(hasNext)
abstract Attribute1Iterator(AttributeIterator) from AttributeIterator {
	public inline function new(vertices:VertexArray, attributeName:String) {
		this = new AttributeIterator(vertices, attributeName);
	}
	
	@:arrayAccess public inline function get(index:Int):Attribute1 {
		return this.get(index);
	}
	
	public inline function next():Attribute1 {
		return this.next();
	}
	
	public inline function iterator():Attribute1Iterator {
		return this;
	}
}
@:forward(hasNext)
abstract Attribute2Iterator(AttributeIterator) from AttributeIterator {
	public inline function new(vertices:VertexArray, attributeName:String) {
		this = new AttributeIterator(vertices, attributeName);
	}
	
	@:arrayAccess public inline function get(index:Int):Attribute2 {
		return this.get(index);
	}
	
	public inline function next():Attribute2 {
		return this.next();
	}
	
	public inline function iterator():Attribute2Iterator {
		return this;
	}
}
@:forward(hasNext)
abstract Attribute3Iterator(AttributeIterator) from AttributeIterator {
	public inline function new(vertices:VertexArray, attributeName:String) {
		this = new AttributeIterator(vertices, attributeName);
	}
	
	@:arrayAccess public inline function get(index:Int):Attribute3 {
		return this.get(index);
	}
	
	public inline function next():Attribute3 {
		return this.next();
	}
	
	public inline function iterator():Attribute3Iterator {
		return this;
	}
}
@:forward(hasNext)
abstract Attribute4Iterator(AttributeIterator) from AttributeIterator {
	public inline function new(vertices:VertexArray, attributeName:String) {
		this = new AttributeIterator(vertices, attributeName);
	}
	
	@:arrayAccess public inline function get(index:Int):Attribute4 {
		return this.get(index);
	}
	
	public inline function next():Attribute4 {
		return this.next();
	}
	
	public inline function iterator():Attribute4Iterator {
		return this;
	}
}
