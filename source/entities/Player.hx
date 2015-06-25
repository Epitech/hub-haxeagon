package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import Utils;

using flixel.util.FlxSpriteUtil;

class Player extends GlobalDependentEntity
{
    public static var originDistance:Float = 60;    // Distance of the player from the center
    public static var size:Int = 12;

    private var position: FlxPoint;

    public var sprite:FlxSprite;

    public var speed:Float = 7.0;
    public var rotation:Float = 0;
    public var allowControl:Bool = false;

    public var originPivot:FlxPoint;

    public function new(X:Float=0, Y:Float=0)
    {
        super();

        speed *= Reg.speedMultiplier;

        originPivot = new FlxPoint();
        originPivot.x = X;
        originPivot.y = Y;

        sprite = new FlxSprite(X, Y);
        sprite.makeGraphic(size, size, FlxColor.TRANSPARENT, true);
        sprite.drawTriangle(0, 0, size, FlxColor.WHITE);

        updatePosition();
    }

    private function movement(OBS:Obstacles):Void
    {
        var _left:Bool = false;
        var _right:Bool = false;

        if (allowControl)
        {
            _left = FlxG.keys.anyPressed(["LEFT", "A"]);
            _right = FlxG.keys.anyPressed(["RIGHT", "D"]);

            if (_left && _right)
                _left = _right = false;
            if (_left || _right)
            {
                if (OBS != null)
                {
                    if (_left && OBS.canMove(rotation - speed))
                        rotation -= speed;
                    else if (_right && OBS.canMove(rotation + speed))
                        rotation += speed;
                }
                else
                {
                    if (_left)
                        rotation -= speed;
                    else if (_right)
                        rotation += speed;
                }
            }
        }
        updatePosition();
    }

    private function updatePosition():Void
    {
        var pt:FlxPoint = new FlxPoint();
        var finalRot:Float = globalRotation + rotation;

        // Update position based on pivot rotation
        FlxAngle.rotatePoint(originDistance, 0, 0, 0, finalRot, pt);
        pt.add(originPivot.x, originPivot.y);
        sprite.setPosition(pt.x - 8, pt.y - 8);
        sprite.angle = finalRot + 90;
        flixel.util.FlxDestroyUtil.destroy(pt);
    }

    // Returns the sector from 0 to 6 depending of the active angle
    public function getLocationSector():Int
    {
        var ngId = Utils.degreeToSector(rotation);
        return (ngId);
    }

    public function update(OBS:Obstacles):Void
    {
        movement(OBS);
    }
}