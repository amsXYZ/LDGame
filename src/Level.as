package  
{
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.events.ResizeEvent;
	import starling.core.Starling;
	import starling.filters.BlurFilter;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author Ruvipls
	 */
	public class Level extends State
	{
		
		public var GAME:Game;
		
		private var key_down:int = 83;
		private var key_up:int = 87;
		private var key_right:int = 68;
		private var key_left:int = 65;
		private var key_enter:int = 13;
		
		public var ch1:SoundChannel = new SoundChannel();
		public var SoundMenu:Sound = new Assets.SoundMenu() as Sound;
		
		private var capa0:Sprite;
		private var capa1:Sprite;
		private var capa2:Sprite;
		
		// ATRIBUTOS PROPORCIONADOS POR CAPA 0
		
		/* NO HAY NINGUNO, SÓLO REACCIONA A OTROS ATRIBUTOS ESTA CAPA */
		
		// ATRIBUTOS PROPORCIONADOS POR CAPA 1
		
		private var CAPA_1_BOTON_IZQ:Boolean = false;
		private var CAPA_1_BOTON_DER:Boolean = false;
		
		// ATRIBUTOS PROPORCIONADOS POR CAPA 2
		
		private var CAPA_2_BOTON_ESPACIO:Boolean = false;
		private var CAPA_2_BOTON_FLECHA_IZQ:Boolean = false;
		private var CAPA_2_BOTON_FLECHA_DER:Boolean = false;
		private var CAPA_2_BOTON_FLECHA_ARR:Boolean = false;
		private var CAPA_2_BOTON_FLECHA_ABA:Boolean = false;
		private var CAPA_2_MOUSE_CLICKED:Boolean = false;
		
		private var leftHand:Sprite;
		private var rightHand:Sprite;
		
		// ATRIBUTOS PROPORCIONADOS GLOBALMENTE
		
		private var GLOBAL_BOTON_ESPACIO:Boolean = false;
		private var GLOBAL_BOTON_W:Boolean = false;
		private var GLOBAL_BOTON_A:Boolean = false;
		private var GLOBAL_BOTON_S:Boolean = false;
		private var GLOBAL_BOTON_D:Boolean = false;
		private var GLOBAL_MOUSE_CLICKED:Boolean = false;
		private var GLOBAL_MOUSE_X:Number = 0;
		private var GLOBAL_MOUSE_Y:Number = 0;
		
		// FIN ATRIBUTOS
		
		private var spawn:PDParticleSystem;
		
		private var colorin:uint = 0xFFFFFF;
		
		public function Level(game_origen:Game) 
		{
			GAME = game_origen;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			addEventListener(TouchEvent.TOUCH, onTouch);
			//this.touchable = false;

		}
		
		private function onStageResize(e:ResizeEvent):void {
			GAME.true_x = e.width / 2 - GAME.true_width / 2;
			GAME.true_y = e.height / 2 - GAME.true_height / 2;
			Starling.current.viewPort.x = GAME.true_x;
			Starling.current.viewPort.y = GAME.true_y;
		}
		
		private function onAddedToStage():void {
			stage.addEventListener(ResizeEvent.RESIZE, this.onStageResize);
			ch1 = SoundMenu.play(0, 9999);
			
			capa0 = new Sprite();
			var i:Image = new Image(Assets.getAtlas().getTexture("capa0"));
			capa0.addChild(i);
			addChild(capa0);
			capa0.x = GAME.true_width/2 - capa0.width/2;
			capa0.y = 58;
			
			capa1 = new Sprite();
			i = new Image(Assets.getAtlas().getTexture("capa1"));
			capa1.addChild(i);
			addChild(capa1);
			capa1.x = GAME.true_width/2 - capa1.width/2;
			capa1.y = 40;
			
			capa2 = new Sprite();
			i = new Image(Assets.getAtlas().getTexture("capa2"));
			capa2.addChild(i);
			addChild(capa2);
			capa2.x = 0;
			capa2.y = 0;
			
			leftHand = new Sprite();
			i = new Image(Assets.getAtlas().getTexture("righthand"));
			leftHand.addChild(i);
			capa2.addChild(leftHand);
			
			
			
			
			/*
			var text_field:TextField = new TextField(400, 200, "LOL", "Verdana", 30, 0x000000, true);
			addChild(text_field);
			*/
		}
		
		private function onTouch(e:TouchEvent):void {		
			var touch:Touch = e.getTouch(this);
			if (touch && touch.phase == TouchPhase.HOVER) {
				GLOBAL_MOUSE_X = touch.globalX;
				GLOBAL_MOUSE_Y = touch.globalY;
				trace("X: " + GLOBAL_MOUSE_X + "// Y: " + GLOBAL_MOUSE_Y);
			}
			if (touch && touch.phase == TouchPhase.BEGAN) {
				GLOBAL_MOUSE_CLICKED = true;
			}
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void {
			
			if (Input.isPressed(Input.SPACE)) GLOBAL_BOTON_ESPACIO = true;
			else GLOBAL_BOTON_ESPACIO = false;
			
			if (Input.isDown(Input.UP)) GLOBAL_BOTON_W = true;
			else GLOBAL_BOTON_W = false;
			
			if (Input.isDown(Input.LEFT)) GLOBAL_BOTON_A = true;
			else GLOBAL_BOTON_A = false;

			if (Input.isDown(Input.DOWN)) GLOBAL_BOTON_S = true;
			else GLOBAL_BOTON_S = false;
			
			if (Input.isDown(Input.RIGHT)) GLOBAL_BOTON_D = true;
			else GLOBAL_BOTON_D = false;
			
			if (GLOBAL_MOUSE_CLICKED) trace ("CLICKED");
			
			leftHand.x = GLOBAL_MOUSE_X;
			leftHand.y = GLOBAL_MOUSE_Y;
			
			GLOBAL_BOTON_ESPACIO = false;
			GLOBAL_BOTON_W = false;
			GLOBAL_BOTON_A = false;
			GLOBAL_BOTON_S = false;
			GLOBAL_BOTON_D = false;
			GLOBAL_MOUSE_CLICKED = false;
		}
		
	}

}