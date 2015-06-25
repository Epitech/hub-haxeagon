package entities.patterns;

import entities.ObstaclePattern;
import flixel.util.FlxTimer;
import flixel.util.FlxRandom;

using Reg;

class SwipeSidePattern extends ObstaclePattern
{
    private var _offset:Int = 0;
    private var _count:Int = 0;
    private var _maxCount:Int = 6;
    private var _actDelay:Float = 0.4;
    private var _activeHandle:Obstacles;

    public function new()
    {
        super();
        _delay = _actDelay * (_maxCount + 1);
        _delay = _delay / Reg.speedMultiplier;
    }

    override public function generate(HANDLER:Obstacles)
    {
        var offset:Int = FlxRandom.intRanged(0, 1);
        _activeHandle = HANDLER;
        _offset = offset;
        _count = 0;
        generateSide(null);
    }

    private function generateSide(TIMER:FlxTimer)
    {
        _count++;
        if (_count > _maxCount)
            return ;

        _offset++;
        if (_offset > 1)
            _offset = 0;
        _activeHandle.pushObstacle(new Obstacle(_activeHandle.sprite, 60 * (_offset)));
        _activeHandle.pushObstacle(new Obstacle(_activeHandle.sprite, 60 * (_offset + 2)));
        _activeHandle.pushObstacle(new Obstacle(_activeHandle.sprite, 60 * (_offset + 4)));

        var _timer = new FlxTimer(getNextGenerateDelay() / (_maxCount + 1), generateSide, 1);
    }
}
