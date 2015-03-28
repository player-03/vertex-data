# Vertex Data

If you work directly with OpenGL, Stage3D, or Tilesheet, you may be familiar with the need for [interleaved vertex data](http://iphonedevelopment.blogspot.com/2009/06/opengl-es-from-ground-up-part-8.html). For instance, Tilesheet "[expects a repeating set of three values: the X and Y coordinates, followed by the tileID that should be rendered](http://www.openfl.org/documentation/api/openfl/display/Tilesheet.html#drawTiles)."

That's simple enough, but depending on your use case the array may repeat after four, five, or even eleven values. At eleven, the pattern is `[x, y, tileID, a, b, c, d, red, green, blue, alpha, x, y, tileID, a, b, c, d, red, green, blue, alpha, ...]`. Updating all that is [as tricky as it sounds](https://github.com/matthewswallace/openfl-tilelayer/blob/master/haxelib/aze/display/TileLayer.hx#L131).

This library is designed to help. Here's how you'd deal with the three-attribute case:

    class MyTile extends Vertex {
        public var position:Attribute2;
        public var tileID:Attribute1;
    }
    
    class Main extends Sprite {
        private var tilesheet:Tilesheet;
        private var tileData:VertexArray<MyTile>;
        
        public function new() {
            super();
            
            initTilesheet();
            
            //Allocate data representing 5 tiles.
            tileData = new VertexArray(5, MyTile);
            
            //You can treat tileData as an array of MyTile objects...
            for(i in 0...5) {
                tileData[i].position.x = i * 64;
                tileData[i].position.y = i * 50;
                tileData[i].tileID = i;
            }
            
            //...but your changes modify the underlying array!
            trace(tileData); //[0, 0, 0, 64, 50, 1, 128, 100, 2, 192, 150, 3, 256, 200, 4]
            
            //If you prefer, you can print it this way.
            for(tile in tileData) {
                trace(tile);
            }
            //Output:
            //{position:[0, 0], tileID:0}
            //{position:[64, 50], tileID:1}
            //{position:[128, 100], tileID:2}
            //{position:[192, 150], tileID:3}
            //{position:[256, 200], tileID:4}
            
            //Now to draw the tiles.
            tilesheet.drawTiles(graphics, tileData.array, true, 0, 5);
        }
    }

Now adding color and alpha to the mix:

    class MyTile extends Vertex {
        public var position:Attribute2;
        public var tileID:Attribute1;
        public var color:Attribute3;
        public var alpha:Attribute1;
    }
    
    class Main extends Sprite {
        private var tilesheet:Tilesheet;
        private var tileData:VertexArray<MyTile>;
        
        public function new() {
            super();
            
            initTilesheet();
            
            tileData = new VertexArray(3, MyTile);
            for(tile in tileData) {
                tile.position.x = 100;
                tile.position.y = 100;
                tile.tileID = 5;
                tile.color.rgb = 0xFF9900;
                tile.alpha = 0.5;
            }
            
            //You can modify specific values of specific tiles, if you like.
            tileData[0].position.y = -1;
            tileData[1].tileID = 6;
            
            //Alternate method of setting a color.
            tileData[2].color.r = 0;
            tileData[2].color.g = 1;
            tileData[2].color.b = 1;
            
            trace(tileData);
            for(tile in tileData) {
                trace(tile);
            }
            //Output:
            //[100, -1, 5, 1, 0.6, 0, 0.5, 100, 100, 6, 1, 0.6, 0, 0.5, 100, 100, 5, 0, 1, 1, 0.5]
            //{position:[-1, 100], tileID:5, color:[1, 0.6, 0], alpha:0.5}
            //{position:[100, 100], tileID:6, color:[1, 0.6, 0], alpha:0.5}
            //{position:[100, 100], tileID:5, color:[0, 1, 1], alpha:0.5}
            
            tilesheet.drawTiles(graphics, tileData.array, true, Tilesheet.TILE_RGB | Tilesheet.TILE_ALPHA, 3);
        }
    }
