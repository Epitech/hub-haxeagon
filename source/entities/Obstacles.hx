package entities;

import openfl.geom.Utils3D;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flash.display.Graphics;
import flixel.util.FlxTimer;
import flixel.util.FlxRandom;
import Utils;

import entities.patterns.SingleSidePattern;
import entities.patterns.SwipeSidePattern;

using Reg;
using flixel.util.FlxSpriteUtil;

class Obstacles extends GlobalDependentEntity
{
    private var obstacles:Array<Obstacle>;
    private var hitAngles:Array<Bool>;
    private var obstaclesPaterns:Array<ObstaclePattern>;

    public var sprite:FlxSprite;
    private var _timer:FlxTimer;

    public function new()
    {
        super();
        sprite = new FlxSprite();
        sprite.makeGraphic(Std.int(1600), Std.int(1600), FlxColor.TRANSPARENT, true);
        sprite.screenCenter();

        obstacles = new Array<Obstacle>();
        hitAngles = new Array<Bool>();
        obstaclesPaterns = new Array<ObstaclePattern>();

        // Duplicating paterns to define their occurence chances
        // Just a quick fix instead of defining chances per pattern
        obstaclesPaterns.push(new SingleSidePattern());
        obstaclesPaterns.push(new SingleSidePattern());
        obstaclesPaterns.push(new SingleSidePattern());
        obstaclesPaterns.push(new SwipeSidePattern());


        generateObstacles(_timer);
        resetColisions();
    }

    public function pushObstacle(OBS:Obstacle)
    {
        obstacles.push(OBS);
    }

    public function generateObstacles(Timer:FlxTimer):Void
    {
        var id = FlxRandom.intRanged(0, obstaclesPaterns.length - 1);
        var entry:ObstaclePattern = obstaclesPaterns[id];

        entry.generate(this);

        _timer = new FlxTimer(entry.getNextGenerateDelay(), generateObstacles, 1);
    }

    public function regenRender():Void
    {
        sprite.fill(FlxColor.TRANSPARENT);

        for (obs in obstacles)
        {
            obs.generatePoly();
        }
    }

    public function resetColisions():Void
    {
        for (i in 0...6)
        {
            hitAngles[i] = false;
        }
    }

    public function updatePositions():Void
    {
        sprite.angle = globalRotation;
        for (obs in obstacles)
        {
            obs.pct -= 0.005 * Reg.speedMultiplier;
            if (obs.isInHitRange()) {
                var ngId = Utils.degreeToSector(obs.locationAng);
                hitAngles[ngId] = true;
            }
        }
        for (obs in obstacles)
        {
            if (obs.pct <= 0.0) {
                obstacles.remove(obs);
                obs = null;
            }
        }
    }

    public function canMove(ANGLE:Float):Bool
    {
        var ngId = Utils.degreeToSector(ANGLE);
        return (hitAngles[ngId] == false);
    }

    public function hasHitWall(SECTOR:Int):Bool
    {
        return (hitAngles[SECTOR] == true);
    }

    public function bumpPositions():Void
    {
        for (obs in obstacles)
        {
            obs.pct += (0.015 * Reg.speedMultiplier);
        }
    }

    public function update():Void
    {
        resetColisions();
        updatePositions();
        regenRender();
    }
}
