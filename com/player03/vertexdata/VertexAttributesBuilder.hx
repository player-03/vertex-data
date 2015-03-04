package com.player03.vertexdata;

import haxe.macro.Context;
import haxe.macro.Expr;

class VertexAttributesBuilder {
	public static function build():Array<Field> {
		var fields:Array<Field> = Context.getBuildFields();
		
		//This macro will be called for both the base class and subclasses,
		//but it shouldn't modify the base class.
		if(Context.getLocalClass().toString() == "com.player03.vertexdata.VertexAttributes") {
			trace("main class");
			return fields;
		}
		var className:String = Context.getLocalClass().get().name;
		
		//Iterate through all the FloatX fields, defining getters and setters.
		var attributeFieldNames:Array<String> = [];
		var offset:Int = 0;
		for(field in fields) {
			var type:Null<ComplexType> = null;
			switch(field.kind) {
				case FVar(t, _):
					type = t;
				case FProp(_, _, t, _):
					type = t;
				default:
					//Nothing.
			}
			
			var path:TypePath = null;
			if(type != null) {
				switch(type) {
					case TPath(p):
						path = p;
					case TExtend(p, fields):
						trace(p);
						trace(fields);
					default:
						//Nothing.
				}
			}
			
			var floatCount:Int = 0;
			if(path != null && (path.pack.length == 0
					|| path.pack.join(".") == "com.player03.vertexdata")) {
				for(count in 1...5) {
					if(path.name == 'Float$count') {
						floatCount = count;
						attributeFieldNames.push(field.name);
						break;
					}
				}
			}
			
			//If floatCount was set, the field represents an attribute
			//and should be processed as such.
			if(floatCount > 0) {
				//Make it public, and associate a getter and setter.
				field.access = [APublic];
				field.kind = FProp("get", "null", type);
				
				//The getter.
				var getterBody:Expr = macro {
					data.index = offset + $v{offset};
					return data;
				};
				
				fields.push({
					name:"get_" + field.name,
					pos:getterBody.pos,
					access:[APrivate, AInline],
					kind:FFun({
						args:[],
						ret:type,
						params:[],
						expr:getterBody
					})
				});
				
				offset += floatCount;
			}
		}
		
		//Remove the constructor, if it exists.
		for(i in 0...fields.length) {
			if(fields[i].name == "new") {
				fields.splice(i, 1);
				break;
			}
		}
		
		//Add a custom constructor.
		var constructorBody:Expr = macro {
			super(data, $v{offset});
		};
		
		fields.push({
			name:"new",
			pos:constructorBody.pos,
			access:[APublic],
			kind:FFun({
				args:[{
					name:"data",
					type:TPath({
						pack:["com", "player03", "vertexdata"],
						name:"VertexData",
						params:[for(param in Context.getLocalClass().get().superClass.params)
							TPType(Context.toComplexType(param))]
					})
				}],
				ret:null,
				params:[],
				expr:constructorBody
			})
		});
		
		//Add a "toString" function.
		var toStringExists:Bool = false;
		for(field in fields) {
			if(field.name == "toString") {
				toStringExists = true;
				break;
			}
		}
		
		if(!toStringExists) {
			var toStringExprs:Array<Expr> = [
				macro var string:StringBuf = new StringBuf()
			];
			toStringExprs.push(macro string.add($v{className} + ":{"));
			
			var attributeName:String;
			var first:Bool = true;
			for(i in 0...attributeFieldNames.length - 1) {
				attributeName = attributeFieldNames[i];
				if(!first) {
					toStringExprs.push(macro string.add(", "));
				}
				toStringExprs.push(macro string.add($v{attributeName} + ":" + $i{attributeName}.toString()));
				first = false;
			}
			toStringExprs.push(macro string.add("}"));
			toStringExprs.push(macro return string.toString());
			var toStringBody:Expr = macro $b{toStringExprs};
			
			fields.push({
				name:"toString",
				pos:toStringBody.pos,
				access:[APublic],
				kind:FFun({
					args:[],
					ret:TPath({pack:[], name:"String"}),
					params:[],
					expr:toStringBody
				})
			});
		}
		
		return fields;
	}
}
