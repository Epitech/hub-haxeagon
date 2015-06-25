package entities;

class World
{
    public var _player:Player;
    public var _playerHex:PlayerHexagon;
    public var _backgroundShapes:Background;
    public var _obstacles:Obstacles = null;

    public var _globRotation:Float = 0.0;

    public var _rotationSpeed:Float = 1.25;

    public function new()
    {
    }

    public function updateGlobRotation():Void
    {
        _globRotation += _rotationSpeed * Reg.speedMultiplier;

        _player.updateGlobRotation(_globRotation);
        _playerHex.updateGlobRotation(_globRotation);
        _backgroundShapes.updateGlobRotation(_globRotation);
        if (_obstacles != null)
            _obstacles.updateGlobRotation(_globRotation);
    }
}
