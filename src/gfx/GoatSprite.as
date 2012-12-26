package gfx 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Slavjan
	 */
	public class GoatSprite extends Sprite
	{
		public var angle:Number = 0; //in rad
		public var targetX:int = 0;
		public var targetY:int = 0;
		public var isStopped:Boolean = true;
		public var speed:Number = 1;
		public var stopRad:Number = 3;
		public var bmp1:Bitmap;
		public var container:Sprite = new Sprite;
		
		public function GoatSprite() 
		{
			var bmpData:BitmapData = new BitmapData(100, 100);
			/*for (var i:int = 0; i < 2; i++) 
			{
				for (var j:int = 0; j < 3; j++) 
				{
					bmpData.copyPixels(Bitmaps._sheep.bitmapData, new Rectangle(j * 100, i * 100, 100, 100), new Point(0, 0));
				}				
			}*/			
			bmpData.copyPixels(Bitmaps._sheep.bitmapData, new Rectangle(0, 0, 100, 100), new Point(0, 0));
			bmp1 = new Bitmap(Bitmaps._sheep.bitmapData);
			
			bmp1.x = -50;
			bmp1.y = -50;
			bmp1.smoothing = true;
			container.addChild(bmp1);
			container.scaleX = 0.43;
			container.scaleY = 0.43;
			container.rotation = 90;
			addChild(container);
		}
		
		public function update (delta:Number/*in radians*/):void 
		{
			stopRad = delta * 3 / 4;
			if (isStopped)
				return;
				
			x += Math.cos(angle) * delta * speed;
			y += Math.sin(angle) * delta * speed;
			rotation = angle * 180 / Math.PI;
			if (Math.sqrt( Math.pow(targetX - this.x, 2) + Math.pow(targetY - this.y, 2) ) < stopRad)
			{
				
				//this.x = targetX;
				//this.y = targetY;
				this.x = targetX;
				this.y = targetY;
				stop();
			}
		}
		
		public function stop():void
		{
			isStopped = true;
			dispatchEvent(new Event("STOPPED"));
		}
		
		public function goToAndStop (targX:int, targY:int):void
		{
			targetX = targX;
			targetY = targY;
			angle = Math.atan( ( targY - this.y ) / ( targX - this.x ) );			
			angle = this.x > targX ? angle + Math.PI : angle;
			isStopped = false;
		}
		
	}

}