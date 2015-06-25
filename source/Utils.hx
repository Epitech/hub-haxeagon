package ;

class Utils
{
    public static function degreeToSector(ANG:Float)
    {
        ANG += 30.0;
        ANG = ANG % 360;
        if (ANG < 0.0) {
            ANG = 360.0 + ANG;
        }
        return Std.int(ANG / 60);
    }
}
