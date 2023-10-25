package core;

import math.Transform;
import math.Point;

class CharacterSystem extends ecs.System {

    public function new() {
        super();
        addComponentClass(Character);
        addComponentClass(Transform);
    }

    override public function updateSingle(dt:Float, e:ecs.Entity) {
        var character = e.get(core.Character);
        var transform = e.get(Transform);
        character.didFire = false;

        if(character.requestFire) {
            var interval = 1.0 / character.weapon.rate;

            if(character.timeSinceLastFire >= interval) {
                var weapon = character.weapon;
                character.timeSinceLastFire = 0;
                character.didFire = true;
                character.requestFire = false;

                if(weapon.type == "instant") {
                    var gap = 0.01;
                    var offset = (weapon.fireCount - 1) * gap * 0.5;

                    for(i in 0...weapon.fireCount) {
                        spawnBullet(transform, -offset + gap * i);
                    }
                } else {
                    throw "Unsupported";
                }
            }
        }

        if(character.requestOpen) {
            var doors = engine.getMatchingEntities(core.Door);

            for(e in doors) {
                var door_pos = e.get(math.Transform).position;
                var distance = math.Point.getSquareDistance(door_pos, transform.position);

                if(distance < 200 * 200) {
                    if(e.get(core.DoorChange) == null) {
                        var door_change = new core.DoorChange();
                        var door = e.get(core.Door);
                        door_change.opening = !door.open;

                        e.add(door_change);
                    }
                }
            }
        }

        character.timeSinceLastFire += dt;
    }

    private function spawnBullet(transform, angle_offset) {
        var b = new ecs.Entity();

        b.add(new core.Bullet());

        b.add(new math.Transform());

        b.get(Transform).copyFrom(transform);
        b.get(Transform).y -= 4;
        b.get(Transform).angle += angle_offset;
        engine.addEntity(b);
    }
}
