namespace Tutorial\Utils;

use namespace HH\Lib\Str;

// Simple utility class
class StringUtils {
    public static function capitalize(string $text): string {
        if ($text === '') {
            return '';
        }
        return Str\uppercase(Str\slice($text, 0, 1)).Str\slice($text, 1);
    }
}