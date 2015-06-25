package entities;

class GlobalDependentEntity
{
    private var globalRotation:Float = 0.0;

    public function new()
    {

    }

    public function updateGlobRotation(rot:Float)
    {
        globalRotation = rot;
    }
}
