package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;

using flixel.util.FlxSpriteUtil;

class PlayerHexagon extends GlobalDependentEntity
{
    public var sprite:FlxSprite;

    private var width:Float = 70.0;
    private var height:Float = 80.0;

    private var dynScale:Float = 1.00;

    public function new(X:Float=0, Y:Float=0)
    {
        super();

        X -= width / 2;
        Y -= height / 2;

        sprite = new FlxSprite(X, Y);
        sprite.makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);
        sprite.screenCenter();

        // Generate hexagon
        var vertices = new Array<FlxPoint>();
        vertices[0] = new FlxPoint(0.0, height * 0.25);
        vertices[1] = new FlxPoint(width * 0.5, 0.0);
        vertices[2] = new FlxPoint(width, height * 0.25);
        vertices[3] = new FlxPoint(width, height * 0.75);
        vertices[4] = new FlxPoint(width * 0.5, height);
        vertices[5] = new FlxPoint(0.0, height * 0.75);
        sprite.drawPolygon(vertices, FlxColor.WHITE);

        updatePosition();
    }

    private function movement():Void
    {
        updatePosition();
    }

    private function updatePosition():Void
    {
        sprite.angle = globalRotation;
        if (dynScale > 1.0)
            dynScale -= 0.1 * Reg.speedMultiplier;
        if (dynScale < 1.0)
            dynScale = 1.0;
        sprite.scale.x = dynScale;
        sprite.scale.y = dynScale;
    }

    public function bumpScale()
    {
        dynScale += 0.3 * Reg.speedMultiplier;
    }

    public function update():Void
    {
        movement();
    }
}