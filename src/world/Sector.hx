package world;

class Sector {
    public var floorTextureName:String;
    public var floorTexture:display.Framebuffer;
    public var walls:Array<Wall> = [];
    public var bottom:Float = 0;
    public var top:Float = 3;

    public function new() {
    }


    public function contains(p:math.Point) {
        for(wall in walls) {
            if(!math.Utils.isPointOnRight(wall.a, wall.b, p)) {
                return false;
            }
        }

        return true;
    }
}
