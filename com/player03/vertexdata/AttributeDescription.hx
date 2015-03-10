package com.player03.vertexdata;

class AttributeDescription {
	public var name(default, null):String;
	
	/**
	 * The number of components in the attribute.
	 */
	public var size(default, null):Int;
	
	public function new(name:String, size:Int) {
		this.name = name;
		this.size = size;
	}
}
