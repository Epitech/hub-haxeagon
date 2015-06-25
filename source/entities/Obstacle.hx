package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flash.display.Graphics;

using flixel.util.FlxSpriteUtil;

class Obstacle
{
    private var sprite:FlxSprite;           // The parent render sprite
    private var vertices:Array<FlxPoint>;   // Vertices of display

    public var locationAng:Float = 0.0;     // Angle location of the obstacle (ex: 0, 60, 120...)
    public var pctWidth:Float = 35.0;       // Size of the obstacle

    public var distance:Float = 1000.0;     // Distance from the center when life is 100%
    public var pct:Float = 1.00;            // Active life from 1.00 (max) to 0.00 (end)

    private var inHitRange:Bool = false;    // If obstacle is in the Hit range location (from player core distance)

    public function new(SPRITE:FlxSprite, ANG:Float=0)
    {
        sprite = SPRITE;
        locationAng = ANG;
        vertices = new Array<FlxPoint>();
    }

    public function generatePoly():Void
    {
        var pt:FlxPoint = new FlxPoint(0, 0);
        var locDistance = distance * pct;
        var mvtAng:Float = locationAng - 30.0;
        var color:Int = 0xffffffff;

        if (locDistance - pctWidth <= Player.originDistance &&
            locDistance > Player.originDistance - Player.size) {
            inHitRange = true;
            color = 0xffff0000;
        } else {
            inHitRange = false;
        }

        FlxAngle.rotatePoint(locDistance, 0, 0, 0, mvtAng, pt);
        vertices[0] = new FlxPoint(pt.x + sprite.width / 2, pt.y + sprite.height / 2);
        FlxAngle.rotatePoint(locDistance - pctWidth, 0, 0, 0, mvtAng, pt);
        vertices[1] = new FlxPoint(pt.x + sprite.width / 2, pt.y + sprite.height / 2);
        mvtAng += 60.0;
        FlxAngle.rotatePoint(locDistance - pctWidth, 0, 0, 0, mvtAng, pt);
        vertices[2] = new FlxPoint(pt.x + sprite.width / 2, pt.y + sprite.height / 2);
        FlxAngle.rotatePoint(locDistance, 0, 0, 0, mvtAng, pt);
        vertices[3] = new FlxPoint(pt.x + sprite.width / 2, pt.y + sprite.height / 2);
        sprite.drawPolygon(vertices, color);
    }

    public function movement():Void
    {
        updatePosition();
        generatePoly();
    }

    public function isInHitRange():Bool
    {
        return (inHitRange);
    }

    private function updatePosition():Void
    {

    }
}
