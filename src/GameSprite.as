package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import gfx.CustomTextField;
	import lvls.*;
	import gfx.GoatSprite;
	import gfx.TerrainSprite;
	import gfx.VillainSprite;
	import mx.core.MovieClipLoaderAsset;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author Slavjan
	 */
	public class GameSprite extends Sprite
	{
		public static const SCENE_WIDTH:int = 792;
		public static const SCENE_HEIGHT:int = 594;
		public static const CEIL_TYPES:Object = { empty:0, grass:1 };
		public static var ceilSizeX:int = 18;
		public static var ceilSizeY:int = 18;
		
		public static var ceilsInWidth:int = 44;
		public static var ceilsInHeight:int = 33;
		
		public var villain:VillainSprite = new VillainSprite();
		public var speed:Number = 5;
		
		public var isUpPressed:Boolean = false;
		public var isDownPressed:Boolean = false;
		public var isLeftPressed:Boolean = false;
		public var isRightPressed:Boolean = false;
		
		public static var grid:Array = [[0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]];
		
		public static var curStatesArr:Array = [ ];
		public static var statesArr:Array = [[0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 5, 6, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 5, 6, 8, 8, 6, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 6, 8, 8, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 2, 0, 6, 8, 8, 7, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 2, 1, 0, 0, 4, 4, 5, 5, 5, 4, 2, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1], [0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 3, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 2, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 3, 3, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 4, 6, 6, 6, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 5, 8, 8, 8, 6, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 1, 0, 2, 0, 0, 0, 2, 0, 2, 0, 0, 0, 5, 8, 8, 8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 4, 7, 7, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 3, 0, 0, 5, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0, 2, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 2, 0, 0, 3, 3, 2, 2, 2, 3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 2, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]];		
		public static var isInfinite:Boolean = false;
		
		public var terrain:TerrainSprite;
		public var goats:Array = [new GoatSprite];
		public var goatSpeed:Number = 3;
		public var goatWait:int = 1000;
		public var frameCounter:int = 0;
		public var goatRadius:int = 300;
		public var goatSquareRadius:int = 50;
		public var goatNeighMin:int = 5;
		public var villainGrassInHand:int = 5;
		
		public var timer:Number = 0;
		public var timerTF:CustomTextField  = new CustomTextField ('0.000', 20, 0x0080FF,200, TextFormatAlign.LEFT); 
		public var grassTF:CustomTextField  = new CustomTextField ('tuffets: ', 20, 0x0080FF,200, TextFormatAlign.RIGHT); 
		
		public function GameSprite(mode:int) 
		{
			loadLevel(mode);
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);		
		}
		
		public function loadLevel (num:int):void
		{
			switch (num) 
			{
				case -1:
					grid = [].concat(infinite.GRID);
					statesArr = [].concat(infinite.STATES_ARR);
					isInfinite = infinite.infiniteMode;
					goatWait = 1000;
					villainGrassInHand = 9999;
					timerTF.x = 15;
					timerTF.y = 0;
					//addChild(timerTF);
					//timerTF.alpha = 0.7;
				break;
				case 1:
					grid = [].concat(Level1_44x33.GRID);
					statesArr = [].concat(Level1_44x33.STATES_ARR);
					isInfinite = Level1_44x33.infiniteMode;
					villainGrassInHand = 5;
				break;
				default:
			}
		}
		
		public function init (e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			goatSquareRadius = Math.max(Math.floor( goatRadius / ceilsInHeight ), Math.floor( goatRadius / ceilsInWidth ));
			for (var i:int = 0; i < ceilsInHeight; i++)
			{
				curStatesArr.push([]);
				//statesArr.push([]);
				for (var j:int = 0; j < ceilsInWidth; j++) 
				{
					curStatesArr[i].push( { } );
					//statesArr[i].push(0);
				}
			}
			/*grid = [];
			for (var i:int = 0; i < ceilsInHeight; i++) 
			{
				grid.push([]);
				for (var j:int = 0; j < ceilsInWidth; j++) 
				{
					grid[i].push(i !== 5 ? CEIL_TYPES.empty:CEIL_TYPES.grass);
				}
			}*/
			
			terrain = new TerrainSprite(SCENE_WIDTH, SCENE_HEIGHT, grid);
			addChild(terrain);
			villain.x = 50;
			villain.y = 50;
			addChild(villain);
			villain.carryingGrass = villainGrassInHand;
			goats[0].x = 700;
			goats[0].y = 300;
			addChild(goats[0]);
			if (isInfinite)
				addChild(timerTF);
				
			grassTF.x = SCENE_WIDTH - 200;
			grassTF.y = 0;
			grassTF.text = "tuffets: " + villain.carryingGrass.toString();
			addChild(grassTF);
				
			for (var k:int = 0; k < goats.length; k++) 
			{
				findNextTargetAndGo(goats[k]);
			}
			/*for (i = 0; i < ceilsInHeight; i++)
			{
				for (j = 0; j < ceilsInWidth; j++) 
				{
					checkAndSetField(j, i);
				}
			}*/
			trace(JSON.stringify(grid))
			trace(JSON.stringify(statesArr))
			addEventListener(Event.ENTER_FRAME, update);
			if (isInfinite) addEventListener(Event.ENTER_FRAME, accelerateGoat);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDownKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUpKey);
		}
		
		public function onDownKey (e:KeyboardEvent):void
		{
			//пробел - 32
			switch (e.keyCode) 
			{
				case 32:
					if (villain.x < SCENE_WIDTH && villain.y < SCENE_HEIGHT && villain.x >= 0 && villain.y >= 0)
					{
						changeCeilByVillain(getCeilIndHorisontal(villain.x), getCeilIndVertical(villain.y));
					}
					break;
				case 37:
					isLeftPressed = true;
				break;
				case 38:
					isUpPressed = true;
				break;
				case 39:
					isRightPressed = true;
				break;
				case 40:
					isDownPressed = true;
				break;
				default:
			}
		}
		
		public function onUpKey (e:KeyboardEvent):void
		{
			switch (e.keyCode) 
			{
				case 37:
					isLeftPressed = false;
				break;
				case 38:
					isUpPressed = false;
				break;
				case 39:
					isRightPressed = false;
				break;
				case 40:
					isDownPressed = false;
				break;
				default:
			}
		}
		
		public function update (e:Event = null):void
		{
			var updStr:String = createDirStr();
			for (var i:int = 0; i < goats.length; i++) 
			{
				goats[i].update(goatSpeed);
			}
			villain.update(updStr, speed);
			
		}
		
		public function accelerateGoat (e:Event = null):void
		{
			frameCounter++;
			if (frameCounter % 20 == 0)
			{
				goatWait = (int)(goatWait * 0.99);
				if(goatSpeed < 9 )goatSpeed += 0.1;
				frameCounter = 0;
			}
			timer = (Number)(getTimer() / 1000);
			timerTF.text = timer.toString();
		}
		
		public function findNextTargetAndGo (goat:GoatSprite):void
		{
			var goatIndX:int = getCeilIndHorisontal(goat.x);
			var goatIndY:int = getCeilIndVertical(goat.y);
			var minWay:int = goatRadius * 2;
			var minX:int = 0;
			var minY:int = 0;
			for (var i:int = Math.max(0, goatIndY - goatSquareRadius); i <= Math.min( ceilsInHeight - 1, goatIndY + goatSquareRadius ) ; i++) 
			{
				for (var j:int = Math.max(0, goatIndX - goatSquareRadius); j <= Math.min( ceilsInWidth - 1, goatIndX + goatSquareRadius ) ; j++) 
				{
					if (statesArr[i][j] >= goatNeighMin)
					{
						var grassDistance:Number = Math.sqrt( Math.pow(ceilTopLeftCoord(j, i).x - goat.x, 2) + Math.pow(ceilTopLeftCoord(j, i).y - goat.y, 2) );
						if ( grassDistance < minWay)
						{
							minWay = grassDistance;
							minX = j;
							minY = i;
						}
					}
				}
			}
			if (minWay <= goatRadius)
			{
				goat.goToAndStop(ceilCenterCoord(minX, minY).x, ceilCenterCoord(minX, minY).y);
				goat.addEventListener("STOPPED", onGoatStop);
			}
			else
			{
				dispatchEvent(new Event ("TO_SHEPHERD"));
				trace("To shepherd!!!");
				showGameEnd();
			}
		}
		
		public function onGoatStop (e:Event = null):void
		{
			changeCeilByGoat(getCeilIndHorisontal(e.currentTarget.targetX), getCeilIndVertical(e.currentTarget.targetY));
			setTimeout(function():void { findNextTargetAndGo(e.currentTarget as GoatSprite); }, goatWait);
			//e.currentTarget.stop();
			
			e.currentTarget.removeEventListener("STOPPED", onGoatStop);			
		}
		
		public function createDirStr ():String
		{
			var updStr:String = "";
			if (isUpPressed)
			{
				updStr += isDownPressed ? "":"u";
				if (isLeftPressed)
				{
					if (!isRightPressed)
					{
						updStr += "l";
					}
				}
				else
				{
					if (isRightPressed)
					{
						updStr += "r";
					}
				}
			}
			else
			{
				if (isDownPressed)
				{
					updStr += "d";
					if (isLeftPressed)
					{
						if (!isRightPressed)
						{
							updStr += "l";
						}
					}
					else
					{
						if (isRightPressed)
						{
							updStr += "r";
						}
					}
				}
				else
				{
					if (isLeftPressed)
					{
						if (!isRightPressed)
						{
							updStr += "l";
						}
					}
					else
					{
						if (isRightPressed)
						{
							updStr += "r";
						}
					}
				}
			}			
			return updStr;
		}
		
		public function getCeilIndVertical (coordY:int):int
		{
			return Math.floor(coordY / ceilSizeY);
		}
		
		public function getCeilIndHorisontal (coordX:int):int
		{
			return Math.floor(coordX / ceilSizeX);
		}		
		
		public static function ceilTopLeftCoord (indX:int, indY:int):Object
		{
			return { x:indX * ceilSizeX, y:indY * ceilSizeY };
		}
		
		public static function ceilCenterCoord (indX:int, indY:int):Object
		{
			return { x:Math.floor(indX * ceilSizeX + ceilSizeX / 2), y:Math.floor(indY * ceilSizeY + ceilSizeY / 2) };
		}
		
		public function checkAndSetField (indX:int, indY:int):void
		{
			if (indX < 0 || indY < 0 || indX >= ceilsInWidth || indY >= ceilsInHeight || grid[indY][indX] == CEIL_TYPES.empty)
			{
				return;
			}
			for (var i:int = 0; i < ceilsInHeight; i++) 
			{
				for (var j:int = 0; j < ceilsInWidth; j++) 
				{
					curStatesArr[i][j].num = 0; 
					curStatesArr[i][j].added = false;
				}
			}
			curStatesArr[indY][indX].added = true;
			waveSearch( [ { x:indX, y:indY } ] );
			for (i = 0; i < ceilsInHeight; i++) 
			{
				for (j = 0; j < ceilsInWidth; j++) 
				{
					if (curStatesArr[i][j].added)
					{
						statesArr[i][j] = curStatesArr[i][j].num;
					}
				}
			}
		}
		
		public static function waveSearch (indToCheck:Array):void
		{
			if (indToCheck.length == 0) return;
			var nextIndToCheck:Array = [];
			for (var i:int = 0; i < indToCheck.length; i++) 
			{
				if (indToCheck[i].x > 0)
				{
					if (indToCheck[i].y > 0 )
					{
						if (grid[indToCheck[i].y - 1][indToCheck[i].x - 1] !== GameSprite.CEIL_TYPES.empty )
						{
							curStatesArr[indToCheck[i].y][indToCheck[i].x].num++;
						}					
					}
					if (grid[indToCheck[i].y][indToCheck[i].x - 1] !== GameSprite.CEIL_TYPES.empty)
					{
						curStatesArr[indToCheck[i].y][indToCheck[i].x].num++;
						if (curStatesArr[indToCheck[i].y][indToCheck[i].x - 1].added == false) 
						{
							curStatesArr[indToCheck[i].y][indToCheck[i].x - 1].added = true;
							nextIndToCheck.push( { x:indToCheck[i].x - 1, y:indToCheck[i].y } );
						}
					}
					if (indToCheck[i].y < ceilsInHeight - 1 )
					{
						if (grid[indToCheck[i].y + 1][indToCheck[i].x - 1] !== GameSprite.CEIL_TYPES.empty )
						{
							curStatesArr[indToCheck[i].y][indToCheck[i].x].num++;							
						}					
					}
				}
				/////////////////////////////////////////////////////////////
				if (indToCheck[i].y > 0 )
				{
					if (grid[indToCheck[i].y - 1][indToCheck[i].x] !== GameSprite.CEIL_TYPES.empty )
					{
						curStatesArr[indToCheck[i].y][indToCheck[i].x].num++;
						if (curStatesArr[indToCheck[i].y - 1][indToCheck[i].x].added == false) 
						{
							curStatesArr[indToCheck[i].y - 1][indToCheck[i].x].added = true;
							nextIndToCheck.push( { x:indToCheck[i].x, y:indToCheck[i].y - 1 } );
						}
					}					
				}
				if (indToCheck[i].y < ceilsInHeight - 1 )
				{
					if (grid[indToCheck[i].y + 1][indToCheck[i].x] !== GameSprite.CEIL_TYPES.empty )
					{
						curStatesArr[indToCheck[i].y][indToCheck[i].x].num++;
						if (curStatesArr[indToCheck[i].y + 1][indToCheck[i].x].added == false) 
						{
							curStatesArr[indToCheck[i].y + 1][indToCheck[i].x].added = true;
							nextIndToCheck.push( { x:indToCheck[i].x , y:indToCheck[i].y + 1 } );
						}
					}					
				}
				///////////////////////////////////////////////
				if (indToCheck[i].x < ceilsInWidth - 1)
				{
					if (indToCheck[i].y > 0 )
					{
						if (grid[indToCheck[i].y - 1][indToCheck[i].x + 1] !== GameSprite.CEIL_TYPES.empty )
						{
							curStatesArr[indToCheck[i].y][indToCheck[i].x].num++;
						}					
					}
					if (grid[indToCheck[i].y][indToCheck[i].x + 1] !== GameSprite.CEIL_TYPES.empty)
					{
						curStatesArr[indToCheck[i].y][indToCheck[i].x].num++;
						if (curStatesArr[indToCheck[i].y][indToCheck[i].x + 1].added == false) 
						{
							curStatesArr[indToCheck[i].y][indToCheck[i].x + 1].added = true;
							nextIndToCheck.push( { x:indToCheck[i].x + 1, y:indToCheck[i].y } );
						}
					}
					if (indToCheck[i].y < ceilsInHeight - 1 )
					{
						if (grid[indToCheck[i].y + 1][indToCheck[i].x + 1] !== GameSprite.CEIL_TYPES.empty )
						{
							curStatesArr[indToCheck[i].y][indToCheck[i].x].num++;							
						}					
					}
				}
			}
			indToCheck = null;
			waveSearch(nextIndToCheck);
		}
		
		public function changeCeilByVillain (indX:int, indY:int):void
		{
			if (grid[indY][indX] == CEIL_TYPES.empty)
			{
				if (villain.carryingGrass > 0)
				{
					if(!isInfinite)
						villain.carryingGrass--;
					
					grassTF.text = "tuffets: " + villain.carryingGrass.toString();
					grid[indY][indX] = CEIL_TYPES.grass;
					terrain.changeTerrain(indX, indY, CEIL_TYPES.grass);
					checkAndSetField(indX, indY);
				}
			}				
			else if (grid[indY][indX] == CEIL_TYPES.grass)
			{
				if (!isInfinite)
					villain.carryingGrass++;
					
				grassTF.text = "tuffets: " + villain.carryingGrass.toString();
				grid[indY][indX] = CEIL_TYPES.empty;
				terrain.changeTerrain(indX, indY, CEIL_TYPES.empty);
				statesArr[indY][indX] = 0;
				checkAndSetField(indX - 1, indY - 1);
				checkAndSetField(indX - 1, indY);
				checkAndSetField(indX - 1, indY + 1);
				checkAndSetField(indX, indY - 1);
				checkAndSetField(indX, indY + 1);
				checkAndSetField(indX + 1, indY - 1);
				checkAndSetField(indX + 1, indY);
				checkAndSetField(indX + 1, indY + 1);
			}
			//trace(JSON.stringify(grid))
			//trace(JSON.stringify(statesArr))
		}
		
		public function changeCeilByGoat (indX:int, indY:int):void
		{
			if (grid[indY][indX] == CEIL_TYPES.grass)
			{
				grid[indY][indX] = CEIL_TYPES.empty;
				terrain.changeTerrain(indX, indY, CEIL_TYPES.empty);
				statesArr[indY][indX] = 0;
				checkAndSetField(indX - 1, indY - 1);
				checkAndSetField(indX - 1, indY);
				checkAndSetField(indX - 1, indY + 1);
				checkAndSetField(indX, indY - 1);
				checkAndSetField(indX, indY + 1);
				checkAndSetField(indX + 1, indY - 1);
				checkAndSetField(indX + 1, indY);
				checkAndSetField(indX + 1, indY + 1);
			}
			//trace(JSON.stringify(grid))
			//trace(JSON.stringify(statesArr))
		}
		
		public function showGameEnd ():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			
			if (isInfinite) removeEventListener(Event.ENTER_FRAME, accelerateGoat);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onDownKey);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onUpKey);
			showEndScreen();
		}
		
		public function showEndScreen ():void
		{
			var spr:Sprite = new Sprite;
			spr.graphics.beginFill(0x000000, 1);
			spr.graphics.drawRect(0, 0, SCENE_WIDTH, SCENE_HEIGHT);
			spr.graphics.endFill();
			addChild(spr);
			var tf:CustomTextField = new CustomTextField("You have last for " + timer.toString() + " seconds.\nGreat run!", 20, 0xCDFB82, 500);
			tf.x = 148;
			tf.y = 200;
			if (!isInfinite)			
			{								
				tf.text = "The sheep has leaved.\nWak-wak-wak-waaaaaaak";
			}
			addChild(tf);
			setTimeout(function():void { dispatchEvent(new Event ("ENDGAME")); }, 1000);
		}
		
		
		
	}
	
	
}