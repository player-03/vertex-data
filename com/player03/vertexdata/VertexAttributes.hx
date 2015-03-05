package com.player03.vertexdata;

import com.player03.vertexdata.Offset.ConcreteOffset;

#if 0
//USAGE EXAMPLE

//Sample vertex attributes, defining position (xyz) and color (rgb) for each
//vertex. Each PositionAndColor object will correspond to 6 consecutive
//values in the VertexData array.

//A constructor will be generated automatically for all subclasses of
//VertexAttributes, and if you define one yourself, it will be replaced.
//Variables of type "AttributeX" (where X is 1-4) will be instantiated
//automatically (and made public). All others will be ignored.
class MyAttributes extends VertexAttributes {
	var position:Attribute3;
	var color:Attribute3;
}

//To create a vertex array with position+color vertices:
//var data:VertexData<MyAttributes> = new VertexData(3, MyAttributes);

//To set the position of the first vertex:
//data[0].position.setXYZ(3, 4, 5);

//To print the y coordinate of the second vertex:
//trace(data[1].position.y);

//To set the color of the third vertex:
//data[2].color.rgb = 0x33FF66;
#end

@:autoBuild(com.player03.vertexdata.VertexAttributesBuilder.build())
class VertexAttributes extends ConcreteOffset {
	/**
	 * The number of bytes required to fully define a single vertex.
	 */
	public var bytesRequired(get, never):Int;
	
	/**
	 * The number of 32-bit floats required to fully define a single vertex.
	 */
	public var floatsRequired(default, null):Int;
	
	private inline function new(array:VertexDataArray, floatsRequired:Int, ?offset:Int = 0) {
		super(array, offset);
		this.floatsRequired = floatsRequired;
	}
	
	private inline function get_bytesRequired():Int {
		return floatsRequired * 4;
	}
	
	/**
	 * Dynamically look up a scalar attribute.
	 */
	public function getAttribute1(name:String):Attribute1 {
		return null; //Will be overridden by subclasses.
	}
	/**
	 * Dynamically look up a 2-component attribute
	 */
	public function getAttribute2(name:String):Attribute2 {
		return null;
	}
	/**
	 * Dynamically look up a 3-component attribute
	 */
	public function getAttribute3(name:String):Attribute3 {
		return null;
	}
	/**
	 * Dynamically look up a 4-component attribute
	 */
	public function getAttribute4(name:String):Attribute4 {
		return null;
	}
	
	public inline function clone():VertexAttributes {
		return new VertexAttributes(array, floatsRequired, offset);
	}
	private inline function cloneWithOffset(offset:Int):VertexAttributes {
		return new VertexAttributes(array, floatsRequired, offset);
	}
}
