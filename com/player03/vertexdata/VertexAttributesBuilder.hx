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
		var floatType:ComplexType = TPath({pack:[], name:"Float"});
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
					default:
						//Nothing.
				}
			}
			
			var floatCount:Int = 0;
			if(path != null && (path.pack.length == 0
					|| path.pack.join(".") == "com.player03.vertexdata")) {
				for(count in 1...5) {
					if(path.name == 'Attribute$count') {
						floatCount = count;
						attributeFieldNames.push(field.name);
						break;
					}
				}
			}
			
			//If floatCount was set, the field represents an attribute
			//and should be processed as such.
			if(floatCount > 0) {
				//Make it public, associate a getter and setter, and
				//change the type to Float if it's a scalar.
				field.access = [APublic];
				field.kind = FProp("get", "set",
					floatCount > 1 ? type : floatType);
				
				//Special case: return and set scalar values directly.
				if(floatCount == 1) {
					var getterBody:Expr = macro return array[offset + $v{offset}];
					fields.push({
						name:"get_" + field.name,
						pos:getterBody.pos,
						access:[APrivate, AInline],
						kind:FFun({
							args:[],
							ret:floatType,
							params:[],
							expr:getterBody
						})
					});
					
					var setterBody:Expr = macro return array[offset + $v{offset}] = value;
					fields.push({
						name:"set_" + field.name,
						pos:setterBody.pos,
						access:[APrivate, AInline],
						kind:FFun({
							args:[{
								name:"value",
								type:floatType
							}],
							ret:floatType,
							params:[],
							expr:setterBody
						})
					});
				} else {
					var getterBody:Expr = macro
						return new com.player03.vertexdata.Offset(array, offset + $v{offset});
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
					
					var setterBody:Expr = macro {
						for(i in 0...$v{floatCount}) {
							array[offset + $v{offset} + i] = value[i];
						}
						return value;
					};
					fields.push({
						name:"set_" + field.name,
						pos:setterBody.pos,
						access:[APrivate, AInline],
						kind:FFun({
							args:[{
								name:"value",
								type:type
							}],
							ret:type,
							params:[],
							expr:setterBody
						})
					});
				}
				
				offset += floatCount;
			}
		}
		
		//Renaming for clarity.
		var floatsPerVertex:Int = offset;
		
		//Remove the constructor, if it exists.
		for(i in 0...fields.length) {
			if(fields[i].name == "new") {
				fields.splice(i, 1);
				break;
			}
		}
		
		//Add a custom constructor.
		var constructorBody:Expr = macro 
			super(new com.player03.vertexdata.VertexDataArray(vertexCount * $v{floatsPerVertex}), $v{floatsPerVertex});
		fields.push({
			name:"new",
			pos:constructorBody.pos,
			access:[APublic],
			kind:FFun({
				args:[{
					name:"vertexCount",
					type:TPath({
						pack:[],
						name:"Int"
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
				macro var buffer:StringBuf = new StringBuf()
			];
			
			var attributeName:String;
			var first:Bool = true;
			for(i in 0...attributeFieldNames.length) {
				attributeName = attributeFieldNames[i];
				if(!first) {
					toStringExprs.push(macro buffer.add(", "));
				}
				toStringExprs.push(macro buffer.add($v{attributeName} + ":" + $i{attributeName}));
				first = false;
			}
			toStringExprs.push(macro return "{" + buffer.toString() + "}");
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
