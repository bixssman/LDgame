package gfx 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Slavjan
	 */
	public class VillainSprite extends Sprite
	{
		public var carryingGrass:int = 999990;
		public var speed:Number = 1;
		
		public var bmp1:Bitmap;
		public var container:Sprite = new Sprite;
		
		public function VillainSprite() 
		{
			var bmpData:BitmapData = new BitmapData(100, 100);
			/*for (var i:int = 0; i < 2; i++) 
			{
				for (var j:int = 0; j < 3; j++) 
				{
					bmpData.copyPixels(Bitmaps._sheep.bitmapData, new Rectangle(j * 100, i * 100, 100, 100), new Point(0, 0));
				}				
			}*/			
			bmpData.copyPixels(Bitmaps._villain.bitmapData, new Rectangle(0, 0, 100, 100), new Point(0, 0));
			bmp1 = new Bitmap(Bitmaps._villain.bitmapData);
			
			bmp1.x = -50;
			bmp1.y = -50;
			bmp1.smoothing = true;
			container.addChild(bmp1);
			container.scaleX = 0.4;
			container.scaleY = 0.4;
			addChild(container);
		}
		
		public function update (direction:String, delta:Number):void
		{
			switch (direction) 
			{
				case "u":
					this.y -= delta * speed;
					rotation = 0;
					break;
				case "d":					
					this.y += delta * speed;
					rotation = 180;
					break;
				case "l":	
					this.x -= delta * speed;
					rotation = -90;
					break;
					
				case "r":
					this.x += delta * speed;
					rotation = 90;
					break;
				case "dr":	
					this.x += Math.SQRT1_2 * delta * speed;
					this.y += Math.SQRT1_2 * delta * speed;
					rotation = 135;
					break;
				case "ur":					
					this.x += Math.SQRT1_2 * delta * speed;
					this.y -= Math.SQRT1_2 * delta * speed;
					rotation = 45;
					break;
				case "dl":	
					this.x -= Math.SQRT1_2 * delta * speed;
					this.y += Math.SQRT1_2 * delta * speed; 
					rotation = -135;
					break;
				case "ul":	
					this.x -= Math.SQRT1_2 * delta * speed;
					this.y -= Math.SQRT1_2 * delta * speed;
					rotation = -45;
					break;
			}
		}
		
	}

}