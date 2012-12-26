package gfx 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Slavjan
	 */
	public class SurvivalButton extends Sprite
	{
		public var state1:Bitmap = new Bitmap(Bitmaps._survivalButton.bitmapData);
		public var callback:Function;
		
		public function SurvivalButton(callback:Function) 
		{
			this.callback = callback;
			buttonMode = true;
			useHandCursor = true;
			
			addChild(state1);
			addEventListener(MouseEvent.CLICK, callback);
		}
		
		public function onClick (e:Event = null):void
		{
			callback();
		}
		
		public function free ():void
		{
			while (numChildren)
				removeChildAt(0);
				
			
			
			removeEventListener(MouseEvent.CLICK, callback);				
			
			callback = null;
		}
		
	}

}