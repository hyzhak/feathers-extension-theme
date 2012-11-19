package org.hyzhak.starling.display
{
	import feathers.core.DisplayListWatcher;
	import feathers.display.Image;
	import feathers.skins.IFeathersTheme;
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import org.hyzhak.starling.display.knob.KnobControl;
	
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
			_scaleToDPI = scaleToDPI;
			initialize();
		}
		
		protected var _originalDPI:int;
		
		public function get originalDPI():int
		{
			return _originalDPI;
		}
		
		protected var _scaleToDPI:Boolean;
		
		public function get scaleToDPI():Boolean
		{
			return _scaleToDPI;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Theme
		//
		//--------------------------------------------------------------------------
		
		protected var scale:Number = 1;
		
		protected var atlas:TextureAtlas;
		
		private var knobControlBg:Texture;
		private var knobControlButton:Texture;
		private var knobControlButtonHotspot:Texture;
		
		protected function initialize():void
		{
			_originalDPI = DeviceCapabilities.dpi;
			if(_scaleToDPI)
			{
				if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
				{
					_originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				}
				else
				{
					_originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}
			
			scale = DeviceCapabilities.dpi / _originalDPI;
			
			atlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE(), false), XML(new ATLAS_XML()));
			
			knobControlBg = atlas.getTexture("knob-control-bg");
			knobControlButton = atlas.getTexture("knob-control-button");
			knobControlButtonHotspot = atlas.getTexture("knob-control-button-hotspot");
			
			setInitializerForClass(KnobControl, knobInitializer);
		}
		
		private function knobInitializer(knob:KnobControl):void
		{
			var backgroundSkin:Image = new Image(knobControlBg);
			backgroundSkin.scaleX = scale;
			backgroundSkin.scaleY = scale;
			knob.backgroundSkin = backgroundSkin;
			
			var knobSkin:Image = new Image(knobControlButton);
			knobSkin.scaleX = scale;
			knobSkin.scaleY = scale;
			knob.knobSkin = knobSkin
				
			var buttonHotspotSkin:Image = new Image(knobControlButtonHotspot);
			buttonHotspotSkin.scaleX = scale;
			buttonHotspotSkin.scaleY = scale;
			knob.buttonHotspotSkin = buttonHotspotSkin;
		}
	}
}