package com.player03.vertexdata;

import haxe.macro.Context;
import haxe.macro.Expr;

class VertexArrayBuilder {
	public static function build():Array<Field> {
		var fields:Array<Field> = Context.getBuildFields();
		
		var constructorExprs:Array<Expr> = [ macro null ];
		var vertexDefinition:Array<Expr> = [];
		
		//Iterate through all the AttributeX fields, defining getters and setters.
		var nameMatcher:EReg = ~/Attribute([1-4])Array/;
		for(field in fields) {
			var path:TypePath = null;
			switch(field.kind) {
				case FVar(TPath(p), _) | FProp(_, _, TPath(p), _):
					path = p;
				default:
			}
			
			if(path != null && (path.pack.length == 0
					|| path.pack.join(".") == "com.player03.vertexdata")
					&& nameMatcher.match(path.name)) {
				#if !display
					//Since this field is an array, it may be named differently than the
					//attribute.
					var name:String = field.name;
					if(StringTools.endsWith(name, "s")) {
						name = name.substr(0, name.length - 1);
					} else if(StringTools.endsWith(name, "Array")) {
						name = name.substr(0, name.length - 5);
					}
					
					//Prefer the explicitly-defined name if available.
					for(m in field.meta) {
						if((m.name == "attribute" || m.name == ":attribute")
								&& m.params != null && m.params.length > 0) {
							switch(m.params[0].expr) {
								case EConst(CString(n)):
									name = n;
								default:
							}
						}
					}
					
					//Record the data for later.
					var size:Int = Std.parseInt(nameMatcher.matched(1));
					constructorExprs.push(macro $i{name} = attributes[$v{name}]);
					vertexDefinition.push(macro {name:$v{name}, size:$v{size}});
				#end
				
				field.access = [APublic];
				field.kind = FProp("default", "null", TPath(path));
			} else if(StringTools.startsWith(path.name, "Attribute")
					&& !StringTools.endsWith(path.name, "Array")) {
				var keep:Bool = false;
				for(m in field.meta) {
					if(m.name == ":keep") {
						keep = true;
						break;
					}
				}
				
				if(!keep) {
					Context.warning(path.name + " should be " + path.name + "Array. (Use @:keep to suppress this message.)", field.pos);
				}
			} else if(field.name == "new") {
				Context.error("Don't define the constructor in a VertexArray subclass.", field.pos);
			}
		}
		
		#if !display
			if(vertexDefinition.length == 0) {
				Context.error("At least one attribute array must be defined! (Example: var positions:Attribute3Array)", Context.currentPos());
			}
		#end
		
		//Add a static "vertexDefinition" variable.
		var vertexDefinitionExpr:Expr = macro $a{vertexDefinition};
		fields.push({
			name:"vertexDefinition",
			pos:vertexDefinitionExpr.pos,
			access:[APublic, AStatic],
			kind:FProp("default", "null", macro:com.player03.vertexdata.VertexDefinition,
				vertexDefinitionExpr)
		});
		
		//Add the constructor.
		constructorExprs[0] = macro
			super(length, data, vertexDefinition);
		var constructorBody:Expr = macro $b{constructorExprs};
		fields.push({
			name:"new",
			pos:constructorBody.pos,
			access:[APublic],
			kind:FFun({
				args:[{
					name:"length",
					type:TPath({
						pack:[],
						name:"Int"
					}),
					opt:true
				}, {
					name:"data",
					type:TPath({
						pack:["com", "player03", "vertexdata"],
						name:"Data"
					}),
					opt:true
				}],
				ret:null,
				params:[],
				expr:constructorBody
			})
		});
		
		return fields;
	}
}
