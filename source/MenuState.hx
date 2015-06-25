package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import entities.Player;
import entities.PlayerHexagon;
import entities.Background;
import entities.World;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var _btnPlay:FlxButton;
	private var _btnQuit:FlxButton;

	private var _world:World;

	private function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}

	private function clickQuit():Void
	{
		Sys.exit(0);
	}

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		var text;

        _world = new World();
        _world._player = new Player(1024 / 2, 768 / 2);
        _world._player.allowControl = false;
        _world._playerHex = new PlayerHexagon(1024 / 2, 768 / 2);
        _world._backgroundShapes = new Background(1024 / 2, 768 / 2);
        //_world._obstacles = new Obstacles();
        add(_world._backgroundShapes.sides);
        add(_world._playerHex.sprite);
        add(_world._player.sprite);

        // Generate UI
        text = new FlxText(10, 10, 300, "Haxeagon");
        text.screenCenter();
        text.size = 45;
        text.alignment = "center";
        text.y *= 0.5;
        add(text);

        _btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		//_btnPlay.label.size = 45;
		//_btnPlay.label.color = 0xffffffff;
		_btnPlay.scale.x = 2.0;
		_btnPlay.scale.y = 2.0;
		_btnPlay.screenCenter();
		_btnPlay.x *= 0.7;
		_btnPlay.y *= 1.3;
		add(_btnPlay);

		_btnQuit = new FlxButton(100, 0, "Quit", clickQuit);
		//_btnQuit.label.size = 45;
		//_btnQuit.label.color = 0xffffffff;
		_btnQuit.scale.x = 2.0;
		_btnQuit.scale.y = 2.0;
		_btnQuit.screenCenter();
		_btnQuit.x *= 1.3;
		_btnQuit.y *= 1.3;
		add(_btnQuit);


		//add(_world._obstacles.sprite);

		super.create();
		_world._player.updateGlobRotation(_world._globRotation);
		_world._playerHex.updateGlobRotation(_world._globRotation);
		_world._backgroundShapes.updateGlobRotation(_world._globRotation);
		//_world._obstacles.updateGlobRotation(_world._globRotation);

	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		_btnPlay = flixel.util.FlxDestroyUtil.destroy(_btnPlay);
		_btnQuit = flixel.util.FlxDestroyUtil.destroy(_btnQuit);
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
	}	
}