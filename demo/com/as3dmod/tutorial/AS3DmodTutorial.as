package com.as3dmod.tutorial {
	import com.as3dmod.ModifierStack;
	import com.as3dmod.modifiers.Perlin;
	import com.as3dmod.plugins.pv3d.LibraryPv3d;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	import flash.display.Bitmap;
	import flash.events.Event;	

	public class AS3DmodTutorial extends BasicView {

		private var plane:Plane;
		private var mstack:ModifierStack;
//		private var bend:Bend;
//		private var phase:Phase;

		public function AS3DmodTutorial() {
			super(800, 600, true, false, CameraType.FREE);
			var mat:WireframeMaterial = new WireframeMaterial();
			mat.doubleSided = true;
			plane = new Plane(mat, 800, 800, 12, 12);
			plane.rotationX = 45;
			plane.rotationY = 45;
			scene.addChild(plane);
			mstack = new ModifierStack(new LibraryPv3d(), plane);
			
			var perlin:Perlin = new Perlin(2);
			mstack.addModifier(perlin);
			
			var b:Bitmap = new Bitmap(perlin.bitmap);
			b.scaleX = b.scaleY = 6;
			addChild(b);
//			var noise:Noise = new Noise(20);
//			mstack.addModifier(noise);
//			mstack.collapse();

//			bend = new Bend(0, 0.5);
//			mstack.addModifier(bend);
			
//			mstack.apply();
			startRendering();
//			phase = new Phase();
//			tweenA();
		}

		protected override function onRenderTick(event:Event = null):void {
//			phase.value += .05;
//			bend.force += .01;//			bend.force = phase.phasedValue;
			mstack.apply();
			super.onRenderTick(event);
		}
		
		private function tweenA():void {
//			Tweener.addTween(bend, {force:1, time:2, transition:"easeInOutElastic", onComplete:tweenB});
		}
		
		private function tweenB():void {
//			Tweener.addTween(bend, {force:-1, time:2, transition:"easeInOutElastic", onComplete:tweenA});
		}
	}
}
