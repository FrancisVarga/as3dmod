package {
	import away3d.containers.View3D;
	import away3d.core.base.Mesh;
	import away3d.primitives.Cube;
	
	import com.as3dmod.ModifierStack;
	import com.as3dmod.plugins.away3d.LibraryAway3d;
	import com.as3dmod.util.Log;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;	

	public class Away3dDemo extends Sprite {

		private var view:View3D;
		private var c:Mesh;
		private var m:ModifierStack;
		private var base:DemoBase;

		public function Away3dDemo() {
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.showDefaultContextMenu = false;
			stage.stageFocusRect = false;
			
			Log.init(this);
			base = new DemoBase();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			view = new View3D();
			view.x = stage.stageWidth / 2;
			view.y = stage.stageHeight / 2;
			addChild(view);
			
//			c = new Plane( { width:600, height:250, segmentsW:24, segmentsH:10 } );
//			var mt:WireColorMaterial = new WireColorMaterial(0x27590e);
//			mt.wirecolor = 0x49a51c;
//			c.material = mt;
//			c.bothsides = true;
//			c.rotationX = -20;
//			c.rotationY = 45;
//			view.scene.addChild(c);
			c = new Cube({width:100, height:400, depth:100});
			c.quarterFaces();			c.quarterFaces();			c.quarterFaces();
			view.scene.addChild(c);
			
			m = new ModifierStack(new LibraryAway3d(), c);
			
			base.cubeSetup(m);

			addEventListener(Event.ENTER_FRAME, render);
		}

		private function render(event:Event):void {
			base.onRenderCube();
			m.apply();
			view.render();
		}
	}
}