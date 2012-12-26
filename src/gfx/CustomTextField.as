package gfx 
{
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Slavjan
	 */
	public class CustomTextField extends TextField
	{
		
		public function CustomTextField(text:String, size:uint, textColor:uint = 0xdfffee, width:int = -1, align:String = TextFormatAlign.CENTER) 
		{
			width = width;
			multiline = true;
			var tf:TextFormat = new TextFormat(null, size, textColor, false, false, true, null, null, align);
			defaultTextFormat = tf;
			this.text = text;
			this.mouseEnabled = false;
			
			
			if (width < 0)
			{
				this.width = textWidth;				
			}
			else
			{
				this.width = width;
			}
		}
		
	}

}