package entities.patterns;

import entities.ObstaclePattern;
import flixel.util.FlxRandom;

class SingleSidePattern extends ObstaclePattern
{
    public function new()
    {
        _delay = 1.0;
        super();

    }

    override public function generate(HANDLER:Obstacles)
    {
        var offset:Int = FlxRandom.intRanged(0, 5);

        HANDLER.pushObstacle(new Obstacle(HANDLER.sprite, 60 * (offset)));
        HANDLER.pushObstacle(new Obstacle(HANDLER.sprite, 60 * (offset + 1)));
        HANDLER.pushObstacle(new Obstacle(HANDLER.sprite, 60 * (offset + 2)));
        HANDLER.pushObstacle(new Obstacle(HANDLER.sprite, 60 * (offset + 3)));
        HANDLER.pushObstacle(new Obstacle(HANDLER.sprite, 60 * (offset + 4)));
    }
}
