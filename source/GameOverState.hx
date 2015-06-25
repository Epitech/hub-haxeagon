package ;

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
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;

using flixel.util.FlxSpriteUtil;

class GameOverState extends FlxState
{
    private var _world:World;
    private var _songBeatTimer:FlxTimer;

    private var _btnPlay:FlxButton;
    private var _btnBackMenu:FlxButton;

    private function clickRestart():Void
    {
        FlxG.switchState(new PlayState());
    }

    private function clickBack():Void
    {
        FlxG.switchState(new MenuState());
    }

    /**
	 * Function that is called up when to state is created to set it up.
	 */
    override public function create():Void
    {
        _world = new World();
        _world._player = new Player(1024 / 2, 768 / 2);
        _world._player.allowControl = false;
        _world._playerHex = new PlayerHexagon(1024 / 2, 768 / 2);
        _world._backgroundShapes = new Background(1024 / 2, 768 / 2);
        //_world._obstacles = new Obstacles();

        add(_world._backgroundShapes.sides);
        add(_world._playerHex.sprite);
        add(_world._player.sprite);
        //add(_world._obstacles.sprite);

        // Generate UI
        var text = new FlxText(10, 10, 700, "Game Over");
        text.screenCenter();
        text.size = 45;
        text.alignment = "center";
        text.y *= 0.5;
        add(text);

        text = new FlxText(10, 10, 700, "Survived " + (Reg.score / 1000) + "s");
        text.screenCenter();
        text.size = 45;
        text.alignment = "center";
        text.y *= 0.7;
        add(text);

        _btnPlay = new FlxButton(0, 0, "Restart", clickRestart);
        //_btnPlay.label.size = 45;
        //_btnPlay.label.color = 0xffffffff;
        _btnPlay.scale.x = 2.0;
        _btnPlay.scale.y = 2.0;
        _btnPlay.screenCenter();
        _btnPlay.x *= 1.3;
        _btnPlay.y *= 1.3;
        add(_btnPlay);

        _btnBackMenu = new FlxButton(0, 0, "Back to Menu", clickBack);
        //_btnPlay.label.size = 45;
        //_btnPlay.label.color = 0xffffffff;
        _btnBackMenu.scale.x = 2.0;
        _btnBackMenu.scale.y = 2.0;
        _btnBackMenu.screenCenter();
        _btnBackMenu.x *= 0.7;
        _btnBackMenu.y *= 1.3;
        add(_btnBackMenu);

        super.create();
        _world._player.updateGlobRotation(_world._globRotation);
        _world._playerHex.updateGlobRotation(_world._globRotation);
        _world._backgroundShapes.updateGlobRotation(_world._globRotation);
        //_world._obstacles.updateGlobRotation(_world._globRotation);

        updateSongBeating(null);

    }

    private function updateSongBeating(Timer:FlxTimer):Void
    {
        //_world._obstacles.bumpPositions();
        _world._playerHex.bumpScale();
        _songBeatTimer = new FlxTimer(0.3, updateSongBeating, 1);
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
        _world._player.update(null);
        _world._playerHex.update();
        _world._backgroundShapes.update();
        //_world._obstacles.update();
    }
}
