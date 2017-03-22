package com.player03.vertexdata;

import com.player03.vertexdata.Attribute;
import com.player03.vertexdata.AttributeArray.AttributeArrayImpl;

@:autoBuild(com.player03.vertexdata.VertexArrayBuilder.build())
class VertexArray {
	/**
	 * The number of vertices in this array.
	 */
	public var length(get, never):Int;
	
	/**
	 * The number of components in all the vertices in this array.
	 */
	public var componentCount(get, never):Int;
	
	/**
	 * The number of bytes required to fully define a single vertex.
	 */
	public var bytesPerVertex(get, never):Int;
	
	/**
	 * The number of 32-bit floats required to fully define a single vertex.
	 */
	public var componentsPerVertex(default, null):Int;
	
	/**
	 * A list of the attributes used by this vertex, in the correct order.
	 */
	public var definition(default, null):VertexDefinition;
	
	public var attributes(default, null):Map<String, AttributeArray>;
	
	public var data(default, null):Data;
	
	public function new(?length:Int, ?data:Data, definition:VertexDefinition) {
		componentsPerVertex = definition.totalSize;
		
		if(data == null) {
			if(length != null) {
				data = new Data(length * componentsPerVertex);
			} else {
				throw "You must specify either a length or an array!";
			}
		}
		
		this.data = data;
		this.definition = definition;
		
		attributes = new Map();
		var offset:Int = 0;
		for(d in definition) {
			attributes[d.name] = new AttributeArray(data, offset, componentsPerVertex, length);
			offset += d.size;
		}
	}
	
	private inline function get_bytesPerVertex():Int {
		return componentsPerVertex * 4;
	}
	
	public inline function hasAttribute(name:String):Bool {
		return attributes.exists(name);
	}
	
	private inline function get_length():Int {
		return Std.int(data.length / componentsPerVertex);
	}
	
	public function getVertex(index:Int):Vertex {
		for(d in definition) {
			attributes[d.name][index];
		}
		return this;
	}
	
	public inline function getAttribute(name:String, index:Int):Attribute {
		return attributes[name][index];
	}
	
	private inline function get_componentCount():Int {
		return data.length;
	}
	public inline function getComponent(index:Int):Float {
		return data[index];
	}
	public inline function setComponent(index:Int, value:Float):Float {
		return data[index] = value;
	}
	
	public inline function toString():String {
		var buffer:StringBuf = new StringBuf();
		for(i in 0...data.length) {
			if(i > 0) {
				buffer.add(", ");
			}
			buffer.add(data[i]);
		}
		return "[" + buffer.toString() + "]";
	}
	
	public inline function iterator():Iterator<Vertex> {
		return new VertexIterator(this);
	}
	
	public inline function clone():VertexArray {
		return new VertexArray(data, definition);
	}
}

private class VertexIterator {
	private var vertices:VertexArray;
	private var index:Int = 0;
	private var length:Int;
	
	public function new(vertices:VertexArray) {
		this.vertices = vertices;
		length = vertices.length;
	}
	
	public function hasNext():Bool {
		return index < length;
	}
	
	public function next():Vertex {
		return vertices.getVertex(index++);
	}
}

abstract Vertex(VertexArray) from VertexArray {
	@:arrayAccess
	public inline function get(name:String):Attribute {
		return (cast this.attributes[name]:AttributeArrayImpl).attribute;
	}
}
