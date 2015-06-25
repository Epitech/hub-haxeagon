package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;

using flixel.util.FlxSpriteUtil;

class Background extends GlobalDependentEntity
{
    public var sides:FlxSprite;

    public var width:Float = 2000.0;
    public var height:Float = 2000.0;

    public function new(X:Float=0, Y:Float=0)
    {
        super();
        var pt:FlxPoint = new FlxPoint(-100, 0);
        var ang:Float = 150.0;

        sides = new FlxSprite(X - width / 2, Y - height / 2);
        sides.makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);
        sides.screenCenter();

        for (i in 0...6)
        {
            // Create the sprite and its render
            var vertices = new Array<FlxPoint>();

            vertices[0] = new FlxPoint(width / 2, height / 2);
            FlxAngle.rotatePoint(width, 0, 0, 0, ang, pt);
            vertices[1] = new FlxPoint(pt.x + width / 2, pt.y + height / 2);
            ang -= 60.0;
            FlxAngle.rotatePoint(width, 0, 0, 0, ang, pt);
            vertices[2] = new FlxPoint(pt.x + width / 2, pt.y + height / 2);
            if (i % 2 == 1) {
                sides.drawPolygon(vertices, 0x80ff0000);
            } else {
                sides.drawPolygon(vertices, 0x70ff0000);
            }
        }
    }

    private function movement():Void
    {
        updatePosition();
    }

    private function updatePosition():Void
    {
        var rot:Float = 0.0;

        sides.angle = rot + globalRotation;
    }

    public function update():Void
    {
        movement();
    }
}
