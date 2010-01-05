package {
	import alternativa.engine3d.controllers.CameraController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Mesh;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Scene3D;
	import alternativa.engine3d.display.View;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Box;
	
	import com.as3dmod.ModifierStack;
	import com.as3dmod.plugins.alternativa3d.LibraryAlternativa3d;
	import com.as3dmod.util.Log;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;		

	public class Alternativa3dDemo extends Sprite {

		private var scene:Scene3D;
		private var view:View;
		private var camera:Camera3D;
		private var cameraController:CameraController;
		private var c:Mesh;
		private var m:ModifierStack;
		private var base:DemoBase;

		public function Alternativa3dDemo() {
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Log.init(this);
			
			base = new DemoBase();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			scene = new Scene3D();
			scene.root = new Object3D();
			
			//			c = new Plane(600, 250, 12, 5, true, true, true);
			c = new Box(200, 200, 200, 5, 5, 5);
			c.cloneMaterialToAllSurfaces(new FillMaterial(0x27590e, 1, "normal", 0));
			scene.root.addChild(c);
			c.rotationX = -60 / 180 * Math.PI;
			c.rotationY = -45 / 180 * Math.PI;
			
			m = new ModifierStack(new LibraryAlternativa3d(), c);
			base.setupStack(m);

			camera = new Camera3D();
			camera.x = 0;
			camera.y = 0;
			camera.z = 500;
			scene.root.addChild(camera);
			
			view = new View();
			addChild(view);
			view.camera = camera;

			cameraController = new CameraController(stage);
			cameraController.camera = camera;
			cameraController.setDefaultBindings();
			cameraController.checkCollisions = false;
			cameraController.collisionRadius = 20;
			cameraController.lookAt(c.coords);
			cameraController.controlsEnabled = false;
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			view.width = stage.stageWidth;
			view.height = stage.stageHeight;
		}

		private function onEnterFrame(e:Event):void {
			base.onRender();
			m.apply();
			scene.calculate();
		}
	}
}