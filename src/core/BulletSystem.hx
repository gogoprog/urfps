package core;

import math.Point;
import math.Transform;

class BulletSystem extends ecs.System {

    var hittables:Array<ecs.Entity>;

    public function new() {
        super();
        addComponentClass(Bullet);
        addComponentClass(Transform);
    }

    override public function update(dt:Float) {
        hittables = engine.getMatchingEntities(Hittable);
        super.update(dt);
    }

    override public function updateSingle(dt:Float, e:ecs.Entity) {
        /* var bullet = e.get(core.Bullet); */
        var transform = e.get(Transform);
        var direction:Point = [];
        direction.setFromAngle(transform.angle);
        var end = transform.position + direction * 1000;

        for(h in hittables) {
            var htransform = h.get(Transform);
            var hobject = h.get(Object);
            var collides = math.Utils.lineCircleIntersection(transform.position, end, htransform.position, hobject.radius);

            if(collides) {
                var hittable = h.get(Hittable);
                hittable.life -= 100;
            }
        }

        engine.removeEntity(e);
    }
}
