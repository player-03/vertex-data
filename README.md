# Vertex Data

If you work directly with OpenGL or Stage3D, you may be familiar with the need for [interleaved vertex data](http://iphonedevelopment.blogspot.com/2009/06/opengl-es-from-ground-up-part-8.html). For instance, a simple shader might require six repeating values: `[x, y, z, r, g, b, x, y, z, r, g, b, ...]`.

This format is convenient for the computer and allows for fast rendering, but it's harder for humans to keep track of. That's where this library comes in.

```haxe
class BasicVertexArray extends VertexArray {
    public var positions:Attribute3Array;
    public var colors:Attribute3Array;
}

class Main extends Sprite {
    //...
    
    public function init() {
        //Allocate 3 vertices.
        var vertices = new BasicVertexArray(3);
        
        //Even though the two types of data are interleaved, you can iterate
        //through them separately.
        for(i in 0...vertices.positions.length) {
            vertices.positions[i].x = 100 * i;
            vertices.positions[i].z = 50;
            
            if((i % 2) == 0) {
                vertices.positions[i].y = 40;
            }
        }
        for(color in vertices.colors) {
            color.rgb = 0xFFFFFF;
        }
        
        //Alternatively, you can access each vertex individually. However, this
        //is slightly slower, and code completion isn't available.
        var vertex:Vertex = vertices.getVertex(2);
        vertex["position"][2] += 0.001;
        vertex["color"][0] = 0.5;
        
        //Either way, your changes modify the underlying array!
        trace(vertices.data); //[0, 40, 50, 1, 1, 1, 100, 0, 50, 1, 1, 1, 200, 40, 50.001, 0.5, 1, 1]
        
        //Once everything is ready, the array can be uploaded directly.
        vertexBuffer.uploadFromVector(vertices.data, 0, vertices.length);
    }
}
```
