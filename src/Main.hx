package;

import math.Point;

class Main {
    static public var context = new Context();
    static public var keys:Dynamic = {};
    static public var mx:Int = 0;

    static function main() {
        var canvas:js.html.CanvasElement = cast js.Browser.document.getElementById("canvas");
        var engine = new ecs.Engine();
        var cameraTransform = context.cameraTransform;
        {
            cameraTransform.position = [1024, 1024];
            cameraTransform.angle = 0;
            context.dataRoot = "../data/";
            context.renderer.initialize(cameraTransform);
            context.textureManager.initialize();
            context.level.load();
        }
        {
            engine.addSystem(new core.ControlSystem(), 1);
            engine.addSystem(new core.MoveSystem(), 2);
            engine.addSystem(new core.CameraSystem(), 3);
            engine.addSystem(new core.SpriteAnimationSystem(), 9);
            engine.addSystem(new core.SpriteSystem(), 10);
            {
                for(i in 0...128) {
                    var e = new ecs.Entity();
                    e.add(new core.Sprite());
                    e.get(core.Sprite).heightOffset = 10;
                    e.add(new math.Transform());
                    e.get(math.Transform).position = [Math.random() * 2000, Math.random() * 2000];
                    e.get(math.Transform).angle = Math.random() * Math.PI * 2;
                    e.add(new core.SpriteAnimation());
                    e.get(core.SpriteAnimation).name = "grell-idle";
                    engine.addEntity(e);
                }

                var e = new ecs.Entity();
                e.add(new math.Transform());
                e.add(new core.Player());
                e.add(new core.Control());
                e.add(new core.Camera());
                e.get(math.Transform).position = [1024, 1024];
                engine.addEntity(e);
            }
        }
        function setupControls() {
            canvas.onclick = e->canvas.requestPointerLock();
            canvas.onmousemove = function(e) {
                mx += e.movementX;
            }
            untyped onkeydown = onkeyup = function(e) {
                keys[e.key] = e.type[3] == 'd';
            }
            canvas.oncontextmenu = e->false;
        }
        setupControls();
        function loop(t:Float) {
            context.level.update();
            context.renderer.clear();
            var texture = context.textureManager.get("shotgun/0");
            context.renderer.pushQuad(texture, [1024 / 2 - 320, 640 - 400], [640, 400]);
            /* context.renderer.pushSprite(texture, [312, 356]); */
            engine.update(1/60.0);
            context.renderer.draw(context.level);
            context.renderer.flush();
            js.Browser.window.requestAnimationFrame(loop);
        }
        loop(0);
    }
}
