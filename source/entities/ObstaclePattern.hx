package entities;

import flixel.util.FlxRandom;

class ObstaclePattern
{
    public var _delay:Float = 1.0;

    public function new()
    {
        _delay = _delay / Reg.speedMultiplier;
    }

    public function generate(HANDLER:Obstacles)
    {

    }

    public function getNextGenerateDelay():Float
    {
        return (_delay);
    }
}
