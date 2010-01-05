package  com.as3dmod.demo.skew {	import com.as3dmod.ModifierStack;
	import com.as3dmod.modifiers.Skew;
	import com.as3dmod.plugins.pv3d.LibraryPv3d;
	import com.as3dmod.util.Log;
	import com.as3dmod.util.ModConstant;
	import com.as3dmod.util.Phase;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.view.BasicView;
	
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;		
	/**	 * AS3Dmod demo<br>	 * Modifier: Skew<br>	 * Engine: Papervision<br>	 * <br>	 * <a href="http://www.everydayflash.com/flash/as3dmod/demo/skew.html">See it here</a><br>	 * 	 * @author bartekd	 */	public class SkewDemo extends BasicView {		private var cube:Cube;		private var stack:ModifierStack;		private var skew:Skew;		private var phase:Phase;		private var forceMultiplier:Number = 300;		public function SkewDemo() {			stage.quality = StageQuality.LOW;			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.align = StageAlign.TOP_LEFT;			stage.stageFocusRect = false;						super(700, 500, false, false, CameraType.TARGET);						Log.init(this);						var ml:MaterialsList = new MaterialsList();			var wm:WireframeMaterial = new WireframeMaterial(0xff0000);			ml.addMaterial(wm, "all");			cube = new Cube(ml, 300, 300, 700, 6, 20, 6);			scene.addChild(cube);						stack = new ModifierStack(new LibraryPv3d(), cube);			skew = new Skew();			stack.addModifier(skew);			phase = new Phase();						stage.addEventListener(KeyboardEvent.KEY_UP, onKey);			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);			startRendering();		}				private function onKey(e:KeyboardEvent):void {			switch(e.keyCode) {				case 76: 					skew.constraint = ModConstant.LEFT; 					break;				case 82: 					skew.constraint = ModConstant.RIGHT; 					break;				case 78: 					skew.constraint = ModConstant.NONE; 					break;								case 88:					skew.skewAxis = ModConstant.X;					break;				case 89:					skew.skewAxis = ModConstant.Y;					break;				case 90:					skew.skewAxis = ModConstant.Z;					break;				case 65:					skew.swapAxes = !skew.swapAxes;					break;				case 66:					skew.inverseFalloff = !skew.inverseFalloff;					break;									case 83: 					skew.oneSide = !skew.oneSide;					break;			}		}				private function onKeyDown(e:KeyboardEvent):void {				switch(e.keyCode) {							case Keyboard.UP:					forceMultiplier += 5;					break;				case Keyboard.DOWN:					forceMultiplier -= 5;					break;				case Keyboard.LEFT:					skew.falloff -= .05;					break;				case Keyboard.RIGHT:					skew.falloff += .05;					break;				case 81:					skew.power -= 0.1;					break;				case 87:					skew.power += 0.1;					break;			}		}		protected override function onRenderTick(event:Event = null):void {			phase.value += 0.05;			skew.force = phase.phasedValue * forceMultiplier;			skew.offset = 1 - mouseY / stage.stageHeight;			stack.apply();						cube.rotationY = ((mouseX / stage.stageWidth) - .5) * 180;						super.onRenderTick(event);		}	}}