package org.hyzhak.starling.display
{
	import feathers.core.DisplayListWatcher;
	import feathers.skins.IFeathersTheme;
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class FeatherExtensionTheme extends DisplayListWatcher implements IFeathersTheme
	{
		[Embed(source="/../assets/images/feathersExtension.png")]
		protected static const ATLAS_IMAGE:Class;
		
		[Embed(source="/../assets/images/feathersExtension.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;

		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		protected static const ORIGINAL_DPI_IPAD_RETINA:int = 264;
		
		public function FeatherExtensionTheme(root:DisplayObjectContainer, scaleToDPI:Boolean = true)
		{
			super(root)
			this._scaleToDPI = scaleToDPI;
			this.initialize();
		}
		
		protected var _originalDPI:int;
		
		public function get originalDPI():int
		{
			return this._originalDPI;
		}
		
		protected var _scaleToDPI:Boolean;
		
		public function get scaleToDPI():Boolean
		{
			return this._scaleToDPI;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Theme
		//
		//--------------------------------------------------------------------------
		
		protected var scale:Number = 1;
		
		protected var atlas:TextureAtlas;
		
		protected function initialize():void
		{
			this._originalDPI = DeviceCapabilities.dpi;
			if(this._scaleToDPI)
			{
				if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
				{
					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				}
				else
				{
					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}
			
			this.scale = DeviceCapabilities.dpi / this._originalDPI;
			
			this.atlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE(), false), XML(new ATLAS_XML()));
		}
	}
}