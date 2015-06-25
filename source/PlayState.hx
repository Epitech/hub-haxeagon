package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import entities.Player;
import entities.PlayerHexagon;
import entities.Background;
import entities.Obstacles;
import flixel.util.FlxTimer;
import flixel.util.FlxRandom;
import entities.World;
import flixel.text.FlxText;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

    private var _world:World;

    private var _songBeatTimer:FlxTimer;
    private var _timeSpent:Int = 0;
    private var _timeText:FlxText;
    private var _gameover:Bool = false;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
        FlxG.debugger.visible = true;

        _world = new World();
        _world._player = new Player(1024 / 2, 768 / 2);
        _world._player.allowControl = true;
        _world._playerHex = new PlayerHexagon(1024 / 2, 768 / 2);
        _world._backgroundShapes = new Background(1024 / 2, 768 / 2);
        _world._obstacles = new Obstacles();

        add(_world._backgroundShapes.sides);
        add(_world._playerHex.sprite);
        add(_world._player.sprite);
        add(_world._obstacles.sprite);

		super.create();
        _world._player.updateGlobRotation(_world._globRotation);
        _world._playerHex.updateGlobRotation(_world._globRotation);
        _world._backgroundShapes.updateGlobRotation(_world._globRotation);
        _world._obstacles.updateGlobRotation(_world._globRotation);

        var timer = new FlxTimer(7, updateRotationType, 0);
        updateSongBeating(null);

        // Generate UI
        _timeText = new FlxText(10, 10, 300, "Time: " + _timeSpent);
        _timeText.size = 45;
        add(_timeText);

        var timer = new FlxTimer(0.1, updateTime, 1);

	}

    private function updateTime(Timer:FlxTimer):Void
    {
        if (_gameover)
            return ;
        _timeSpent += 100;
        _timeText.text = "Time: " + (_timeSpent / 1000.0);
        var timer = new FlxTimer(0.1, updateTime, 1);
    }

    private function updateSongBeating(Timer:FlxTimer):Void
    {
        //_world._obstacles.bumpPositions();
        _world._playerHex.bumpScale();
        _songBeatTimer = new FlxTimer(0.3, updateSongBeating, 1);
    }

    private function updateRotationType(Timer:FlxTimer):Void
    {
        if (_world._rotationSpeed > 0) {
            _world._rotationSpeed = FlxRandom.floatRanged(-1.25, -1.75);
        } else {
            _world._rotationSpeed = FlxRandom.floatRanged(1.25, 1.75);
        }
    }


	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
        //_player = flixel.util.FlxDestroyUtil.destroy(_player);
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();

        _world.updateGlobRotation();
        _world._player.update(_world._obstacles);
        _world._playerHex.update();
        _world._backgroundShapes.update();
        _world._obstacles.update();

        if (_world._obstacles.hasHitWall(_world._player.getLocationSector())) {
            _gameover = true;
            Reg.score = _timeSpent;
            FlxG.switchState(new GameOverState());
        }
	}
}