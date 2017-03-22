package com.player03.vertexdata;

@:forward
abstract VertexDefinition(Array<{name:String, size:Int}>) from Array<{name:String, size:Int}> {
	public var totalSize(get, never):Int;
	
	private inline function get_totalSize():Int {
		var size:Int = 0;
		for(a in this) {
			size += a.size;
		}
		return size;
	}
	
	@:arrayAccess
	private inline function get(index:Int):{name:String, size:Int} {
		return this[index];
	}
}
