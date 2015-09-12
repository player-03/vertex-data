package com.player03.vertexdata;

import com.player03.vertexdata.Offset.ConcreteOffset;

#if 0
//USAGE EXAMPLE

//Sample vertex attributes, defining position (xyz) and color (rgb) for each
//vertex. Each MyVertex object will correspond to 6 consecutive values in
//the VertexArray.

//A constructor will be generated automatically for all subclasses of
//Vertex, and if you define your own constructor, it will be replaced.
//Variables of type "AttributeX" (where X is 1-4) will be instantiated
//automatically (and made public). All others will be ignored.
class MyVertex extends Vertex {
	var position:Attribute3;
	var color:Attribute3;
}

//To create a vertex array with three position+color vertices:
//var vertices:VertexArray<MyVertex> = new VertexArray(3, MyVertex);

//To set the position of the first vertex:
//vertices[0].position.setXYZ(3, 4, 5);

//To print the y coordinate of the second vertex:
//trace(vertices[1].position.y);

//To set the color of the third vertex:
//vertices[2].color.rgb = 0x33FF66;
#end

@:autoBuild(com.player03.vertexdata.VertexBuilder.build()) @:keepSub
class Vertex extends ConcreteOffset {
	private static var componentsByClass:Map<String, Int>;
	
	/**
	 * Look up the "componentsPerVertex" value that would be generated if
	 * the given subclass was instantiated, without actually
	 * instantiating it.
	 */
	public static inline function getComponentsPerVertex(subclass:Class<Vertex>):Int {
		return componentsByClass.get(Type.getClassName(subclass));
	}
	
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
	public var attributes(default, null):Array<AttributeDescription>;
	
	/**
	 * An Offset object that can be updated and returned, allowing the
	 * Vertex to avoid creating a new object every time an attribute is
	 * accessed. Additionally, the array property will already have been
	 * set, so only offsetToReturn.offset will need to be updated.
	 */
	private var offsetToReturn:Offset;
	
	private inline function new(?length:Int, ?array:ComponentArray, componentsPerVertex:Int, attributes:Array<AttributeDescription>, ?offset:Int = 0) {
		if(array == null) {
			if(length != null) {
				array = new ComponentArray(length * componentsPerVertex);
			} else {
				throw "You must specify either a length or an array!";
			}
		}
		
		super(array, offset);
		
		this.componentsPerVertex = componentsPerVertex;
		this.attributes = attributes;
		offsetToReturn = new Offset(array);
	}
	
	private inline function get_bytesPerVertex():Int {
		return componentsPerVertex * 4;
	}
	
	/**
	 * Dynamically look up an attribute without knowing the number of
	 * components in advance. This is meant to help with iterating
	 * through attributes.
	 * 
	 * If you know the number of components at compile-time, use the
	 * corresponding "getAttributeX" method instead.
	 * 
	 * This will invalidate the value returned by any previous call to a
	 * getAttribute() function, unless you used clone() to make a copy.
	 */
	public function getAttribute(name:String):Offset {
		var size:Int = 0;
		for(i in 0...this.attributes.length) {
			if(attributes[i].name == name) {
				size = attributes[i].size;
				break;
			}
		}
		switch(size) {
			case 1:
				return getAttribute1(name);
			case 2:
				return getAttribute2(name);
			case 3:
				return getAttribute3(name);
			case 4:
				return getAttribute4(name);
			default:
				return null;
		}
	}
	
	/**
	 * Dynamically look up a scalar attribute. This will invalidate the
	 * value returned by any previous call to a getAttribute() function,
	 * unless you used clone() to make a copy.
	 */
	public function getAttribute1(name:String):Attribute1 {
		return null;
	}
	/**
	 * Dynamically look up a 2-component attribute. This will invalidate
	 * the value returned by any previous call to a getAttribute()
	 * function, unless you used clone() to make a copy.
	 */
	public function getAttribute2(name:String):Attribute2 {
		return null;
	}
	/**
	 * Dynamically look up a 3-component attribute. This will invalidate
	 * the value returned by any previous call to a getAttribute()
	 * function, unless you used clone() to make a copy.
	 */
	public function getAttribute3(name:String):Attribute3 {
		return null;
	}
	/**
	 * Dynamically look up a 4-component attribute. This will invalidate
	 * the value returned by any previous call to a getAttribute()
	 * function, unless you used clone() to make a copy.
	 */
	public function getAttribute4(name:String):Attribute4 {
		return null;
	}
	
	public function hasAttribute(name:String):Bool {
		for(i in 0...this.attributes.length) {
			if(attributes[i].name == name) {
				return true;
			}
		}
		return false;
	}
	
	public inline function clone():Vertex {
		return new Vertex(array, componentsPerVertex, attributes, offset);
	}
	private inline function cloneWithOffset(offset:Int):Vertex {
		return new Vertex(array, componentsPerVertex, attributes, offset);
	}
}
