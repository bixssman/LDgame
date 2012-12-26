package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gfx.AdventureButton;
	import gfx.Bitmaps;
	import gfx.SurvivalButton;

	/**
	 * ...
	 * @author Slavjan
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		public var advButt:AdventureButton;
		public var survButt:SurvivalButton;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			startScreen ();
			// entry point
		}
		
		public function startScreen (e:Event = null):void
		{
			/*var spr:Sprite = new Sprite;
			spr.graphics.beginFill(0x000000, 1);
			spr.graphics.drawRect(0, 0, 800, 600);
			spr.graphics.endFill();
			addChild(spr);*/
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
			terData.noise(seed, 0, 255, ( BitmapDataChannel.GREEN | BitmapDataChannel.BLUE | BitmapDataChannel.RED ));// | BitmapDataChannel.BLUE | BitmapDataChannel.RED ), false);
			var terrain:Bitmap = new Bitmap (terData);
			terrain.alpha = 0.3;
			terData = null;
			addChild(terrain);
			
			
			advButt = new AdventureButton(onAdvClick);
			advButt.x = 247;
			advButt.y = 150;
			addChild(advButt);
			
			survButt = new SurvivalButton(onSurvivalClick);
			survButt.x = 247;
			survButt.y = 350;
			addChild(survButt);
		}
		
		public function onAdvClick (e:Event = null):void
		{
			while (numChildren)
				removeChildAt(0);
				
			advButt.free();
			var sss:GameSprite = new GameSprite( 1);
			sss.addEventListener("ENDGAME", startScreen);
			addChild(sss);
		}

		public function onSurvivalClick (e:Event = null):void
		{
			while (numChildren)
				removeChildAt(0);
				
			survButt.free();	
			var sss:GameSprite = new GameSprite( -1);
			sss.addEventListener("ENDGAME", startScreen);
			addChild(sss);
		}
		
		

	}

}