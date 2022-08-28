package math;

abstract Point(Array<Float>) from Array<Float> to Array<Float> {
    public function new(x, y) {
        this = [x, y];
    }
    public var x(get, set):Float;
    inline function get_x() return this[0];
    inline function set_x(value) return this[0] = value;
    public var y(get, set):Float;
    inline function get_y() return this[1];
    inline function set_y(value) return this[1] = value;

    @:op(A * B)
    @:commutative
    inline static public function mulOp(a:Point, b:Float) {
        return new Point(a.x * b, a.y * b);
    }

    @:op(A / B)
    @:commutative
    inline static public function divOp(a:Point, b:Float) {
        return new Point(a.x / b, a.y / b);
    }

    @:op(A + B)
    inline static public function addOp(a:Point, b:Point) {
        return new Point(a.x + b.x, a.y + b.y);
    }

    @:op(A - B)
    inline static public function minOp(a:Point, b:Point) {
        return new Point(a.x - b.x, a.y - b.y);
    }

    public function getAngle() : Float{
        return Math.atan2(this[1], this[0]);
    }

    public function getLength() : Float{
        return Math.sqrt(this[0] * this[0] + this[1] * this[1]);
    }

    public function getSquareLength() : Float{
        return this[0] * this[0] + this[1] * this[1];
    }
}