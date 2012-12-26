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
	public class AdventureButton extends Sprite
	{
		public var state1:Bitmap = new Bitmap(Bitmaps._adventureButton.bitmapData);
		public var state2:Bitmap = new Bitmap(Bitmaps._adventureButton2.bitmapData);
		public var callback:Function;
		
		public function AdventureButton(callback:Function) 
		{
			this.callback = callback;
			buttonMode = true;
			useHandCursor = true;
			
			addChild(state1);
			addChild(state2);
			state2.visible = false;
			addEventListener(MouseEvent.CLICK, callback);
			addEventListener(MouseEvent.MOUSE_DOWN, changeStateOn2);
			addEventListener(MouseEvent.MOUSE_OUT, changeStateOn1);
		}
		
		public function onClick (e:Event = null):void
		{
			callback();
		}
		
		public function changeStateOn2 (e:Event = null):void
		{
			state1.visible = false;
			state2.visible = true;
		}
		
		public function changeStateOn1 (e:Event = null):void
		{
			state1.visible = true;
			state2.visible = false;
		}
		
		public function free ():void
		{
			while (numChildren)
				removeChildAt(0);
				
			
			
			removeEventListener(MouseEvent.CLICK, callback);
			removeEventListener(MouseEvent.MOUSE_DOWN, changeStateOn2);
			removeEventListener(MouseEvent.MOUSE_UP, changeStateOn1);					
			
			callback = null;
		}
		
	}

}