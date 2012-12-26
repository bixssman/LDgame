package gfx 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Slavjan
	 */
	public class TerrainSprite  extends Sprite
	{
		public var ceils:Array = [];
		public var marginLeft:int = 3;
		public var marginTop:int = 3;
		
		public var grassNum:int = 4;
		public var anotherNum:int = 17;
		
		public function TerrainSprite(w:int, h:int, grid:Array) 
		{
			var spr:Sprite = new Sprite;
			spr.graphics.beginBitmapFill(Bitmaps._groundTexture.bitmapData);
			spr.graphics.drawRect(0, 0, GameSprite.SCENE_WIDTH, GameSprite.SCENE_HEIGHT);
			spr.graphics.endFill();
			addChild(spr);
			var terData:BitmapData = new BitmapData(GameSprite.SCENE_WIDTH, GameSprite.SCENE_HEIGHT);
			for (var l:int = 0; l < Math.ceil(GameSprite.SCENE_HEIGHT / Bitmaps._groundTexture.height); l++) 
			{
				for (var k:int = 0; k < Math.ceil(GameSprite.SCENE_WIDTH / Bitmaps._groundTexture.width) ; k++) 
				{
					terData.copyPixels(Bitmaps._groundTexture.bitmapData, new Rectangle(0, 0, Bitmaps._groundTexture.width, Bitmaps._groundTexture.height), new Point(k * Bitmaps._groundTexture.width, l * Bitmaps._groundTexture.height));
				}
			}
			
			//0xDAC447
			var seed:Number = Math.floor(Math.random() * 100);
			terData.noise(seed, 200, 255, ( BitmapDataChannel.GREEN | BitmapDataChannel.BLUE | BitmapDataChannel.RED ));// | BitmapDataChannel.BLUE | BitmapDataChannel.RED ), false);
			var terrain:Bitmap = new Bitmap (terData);
			terrain.alpha = 0.2;
			terData = null;
			addChild(terrain);
			/*var myBitmapDataObject:BitmapData = new BitmapData(640, 480);
			var seed:Number = Math.floor(Math.random() * 100);
			//myBitmapDataObject.perlinNoise(
			myBitmapDataObject.noise(seed, 200, 255, (BitmapDataChannel.GREEN | BitmapDataChannel.BLUE | BitmapDataChannel.RED ), false);
			//  (320, 240, 8, seed, true, true, 7, false, null);
			var myBitmap:Bitmap = new Bitmap(myBitmapDataObject);
			addChildAt(myBitmap, 0);*/
			
			for (var i:int = 0; i < grid.length; i++) 
			{
				ceils.push([]);
				for (var j:int = 0; j < grid[i].length; j++) 
				{
					
					switch (grid[i][j]) 
					{
						case GameSprite.CEIL_TYPES.grass:
							var bdw:int = 12;
							var bdh:int = 12;
							var isBetween:Boolean = false;
							
							if (j < grid[i].length - 1 && grid[i][j + 1] == GameSprite.CEIL_TYPES.grass)
							{
								bdw = 19;
								if (i < grid.length - 1 && j < grid[i].length && grid[i + 1][j + 1] == GameSprite.CEIL_TYPES.grass && grid[i + 1][j] == GameSprite.CEIL_TYPES.grass)
								{
									isBetween = true;
								}
							}
							if (i < grid.length - 1 && grid[i + 1][j] == GameSprite.CEIL_TYPES.grass)
							{
								bdh = 19;
							}
							var bmpData:BitmapData = new BitmapData(bdw, bdh, true, 0xffffff);
							switch (((i * i + j) % anotherNum) % grassNum)
							{
								case 0:
									bmpData.copyPixels(Bitmaps._grassNoise1.bitmapData, new Rectangle(0, 0, 12, 12), new Point(0, 0));
									break;
								case 1:
									bmpData.copyPixels(Bitmaps._grassNoise2.bitmapData, new Rectangle(0, 0, 12, 12), new Point(0, 0));
									break;
								case 2:
									bmpData.copyPixels(Bitmaps._grassNoise3.bitmapData, new Rectangle(0, 0, 12, 12), new Point(0, 0));
									break;
								case 3:
									bmpData.copyPixels(Bitmaps._grassNoise4.bitmapData, new Rectangle(0, 0, 12, 12), new Point(0, 0));
									break;
								default:
									
							}
							if (bdw > 12)
							{
								bmpData.copyPixels(Bitmaps._grassRL1.bitmapData, new Rectangle(0, 0, 8, 12), new Point(11, 0));
							}
							if (bdh > 12)
							{
								bmpData.copyPixels(Bitmaps._grassUD1.bitmapData, new Rectangle(0, 0, 12, 8), new Point(0, 11));
							}
							if (isBetween)
							{
								bmpData.copyPixels(Bitmaps._grassRL1.bitmapData, new Rectangle(0, 0, 6, 6), new Point(12, 12));
							}
							
							ceils[i].push (new Bitmap(bmpData));
							bmpData = null;
							ceils[i][j].x = GameSprite.ceilTopLeftCoord(j, i).x + marginLeft;
							ceils[i][j].y = GameSprite.ceilTopLeftCoord(j, i).y + marginTop;
							addChild(ceils[i][j]);
						break;
						case GameSprite.CEIL_TYPES.empty:
							ceils[i].push (null); //new Bitmap(Bitmaps._empty.bitmapData));
						break;
					default:
						spr = new Sprite;
						spr.graphics.beginFill(0x000019 * grid[i][j], 1);
						spr.graphics.drawRect(0, 0, GameSprite.ceilSizeX - marginLeft, GameSprite.ceilSizeY - marginTop);
						spr.graphics.endFill();
						ceils[i].push (spr);
						ceils[i][j].x = GameSprite.ceilTopLeftCoord(j, i).x + marginLeft;
						ceils[i][j].y = GameSprite.ceilTopLeftCoord(j, i).y + marginTop;
						addChild(ceils[i][j]);
					}
					
				}
			}
			
		}
		
		public function changeTerrain (indX:int, indY:int, type:int):void		
		{
			freeCeil(indX, indY);
			var i:int = indY;
			var j:int = indX;
			var startV:int = 0;
			var startH:int = 0;
			switch (type) 
			{
				case GameSprite.CEIL_TYPES.empty:
					freeCeil(indX, indY); // new Bitmap ( Bitmaps._empty.bitmapData);
				break;
				case GameSprite.CEIL_TYPES.grass:
					//ceils[indY][indX] = new Bitmap ( Bitmaps._grass.bitmapData);
					var bdw:int = 12;
					var bdh:int = 12;
					
					var isBetweenTL:Boolean = false;
					var isBetweenTR:Boolean = false;
					var isBetweenDR:Boolean = false;
					var isBetweenDL:Boolean = false;
					
					if (j < GameSprite.grid[i].length - 1 && GameSprite.grid[i][j + 1] == GameSprite.CEIL_TYPES.grass)
					{
						bdw = 19;
						if (j > 0 && GameSprite.grid[i][j - 1] == GameSprite.CEIL_TYPES.grass)
						{
							bdw = 26;
							startH = 6;
							if (i < GameSprite.grid.length - 1 && j > 0 && GameSprite.grid[i + 1][j - 1] == GameSprite.CEIL_TYPES.grass && GameSprite.grid[i + 1][j] == GameSprite.CEIL_TYPES.grass)
							{
								isBetweenDL = true;
							}
							if (i > 0 && j > 0 && GameSprite.grid[i - 1][j - 1] == GameSprite.CEIL_TYPES.grass && GameSprite.grid[i - 1][j] == GameSprite.CEIL_TYPES.grass)
							{
								isBetweenTL = true;
							}
						}
						if (i > 0 && GameSprite.grid[i - 1][j] == GameSprite.CEIL_TYPES.grass)
						if (i > 0 && j < GameSprite.grid[i].length && GameSprite.grid[i - 1][j + 1] == GameSprite.CEIL_TYPES.grass && GameSprite.grid[i - 1][j] == GameSprite.CEIL_TYPES.grass)
						{
							isBetweenTR = true;
						}
						if (i < GameSprite.grid.length - 1 && j < GameSprite.grid[i].length && GameSprite.grid[i + 1][j + 1] == GameSprite.CEIL_TYPES.grass && GameSprite.grid[i + 1][j] == GameSprite.CEIL_TYPES.grass)
						{
							isBetweenDR = true;
						}
					}
					else if (j > 0 && GameSprite.grid[i][j - 1] == GameSprite.CEIL_TYPES.grass)
					{
						bdw = 19;
						startH = 6;
						if (i < GameSprite.grid.length - 1 && j > 0 && GameSprite.grid[i + 1][j - 1] == GameSprite.CEIL_TYPES.grass && GameSprite.grid[i + 1][j] == GameSprite.CEIL_TYPES.grass)
							{
								isBetweenDL = true;
							}
							if (i > 0 && j > 0 && GameSprite.grid[i - 1][j - 1] == GameSprite.CEIL_TYPES.grass && GameSprite.grid[i - 1][j] == GameSprite.CEIL_TYPES.grass)
							{
								isBetweenTL = true;
							}
					}
					if (i < GameSprite.grid.length - 1 && GameSprite.grid[i + 1][j] == GameSprite.CEIL_TYPES.grass)
					{
						bdh += 7;
					}
					if (i > 0 && GameSprite.grid[i - 1][j] == GameSprite.CEIL_TYPES.grass)
					{
						startV = 6;
						bdh += 7;
					}
					var bmpData:BitmapData = new BitmapData(bdw, bdh, true, 0xffffff);
					if (isBetweenTL)
					{
						bmpData.copyPixels(Bitmaps._grassBetween1.bitmapData, new Rectangle(0, 0, 6, 6), new Point(0, 0));
					}
					if (startV > 0)
					{
						bmpData.copyPixels(Bitmaps._grassUD1.bitmapData, new Rectangle(0, 0, 12, startV + 1), new Point(startH, 0));
					}
					if (isBetweenTR)
					{
						bmpData.copyPixels(Bitmaps._grassBetween1.bitmapData, new Rectangle(0, 0, 6, 6), new Point(startH + 12, 0));						
					}
					if (startH > 0)
					{
						bmpData.copyPixels(Bitmaps._grassRL1.bitmapData, new Rectangle(0, 0, startH + 1, 12), new Point(0, startV));						
					}
					if (j < GameSprite.grid[i].length - 1 && GameSprite.grid[i][j + 1] == GameSprite.CEIL_TYPES.grass)
					{
						bmpData.copyPixels(Bitmaps._grassRL1.bitmapData, new Rectangle(0, 0, 8, 12), new Point(startH + 12, startV));						
					}
					if (isBetweenDL)
					{
						bmpData.copyPixels(Bitmaps._grassBetween1.bitmapData, new Rectangle(0, 0, 6, 6), new Point(0, startV+12));
					}
					if (i < GameSprite.grid.length - 1 && GameSprite.grid[i + 1][j] == GameSprite.CEIL_TYPES.grass)
					{
						bmpData.copyPixels(Bitmaps._grassUD1.bitmapData, new Rectangle(0, 0, 12, 8), new Point(startH, startV+12));
					}
					if (isBetweenDR)
					{
						bmpData.copyPixels(Bitmaps._grassBetween1.bitmapData, new Rectangle(0, 0, 6, 6), new Point(startH + 12, startV+12));	
					}
					bmpData.copyPixels(Bitmaps._grassNoise1.bitmapData, new Rectangle(0, 0, 12, 12), new Point(startH, startV));
					ceils[indY][indX] = new Bitmap ( bmpData);
					bmpData = null;
					ceils[indY][indX].x = GameSprite.ceilTopLeftCoord(indX, indY).x + marginLeft - startH;
					ceils[indY][indX].y = GameSprite.ceilTopLeftCoord(indX, indY).y + marginTop - startV;
					addChild(ceils[indY][indX]);
				break;
				
			default:
				ceils[indY][indX] = new Bitmap ( Bitmaps._empty.bitmapData);
				ceils[indY][indX].x = GameSprite.ceilTopLeftCoord(indX, indY).x + marginLeft - startH;
				ceils[indY][indX].y = GameSprite.ceilTopLeftCoord(indX, indY).y + marginTop - startV;
				addChild(ceils[indY][indX]);
			}
			
		}
		
		public function freeCeil(indX:int, indY:int):void
		{
			if (ceils[indY][indX] is Bitmap && contains(ceils[indY][indX]))
				removeChild(ceils[indY][indX]);
				
			ceils[indY][indX] = null;
		}
	}

}