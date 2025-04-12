/**
 * The following is how you can do script inclusion in Hack
 * The Hack language uses the `require_once` statement to include files.
 */
require_once(__DIR__ . '/../../vendor/autoload.php'); // Autoload Hack classes

class Data {
    const int MAX_VALUE = 100; // constant value will be in CAPS and no $ sign in snake_case
    private int $value = 0; // variables will have $ sign and be in camelCase
}

interface ICollection {
    /*
     * This is a comment
     * that spans multiple lines
     */
}

/**
 * Top, Bottom, Left, Right, Center are enum case names
 * The enum case names are in PascalCase
 */
enum Position: int {
    Top = 0;
    Bottom = 1;
    Left = 2;
    Right = 3;
    Center = 4;
}

/**
 * function naming is in camelCase
 */
function compute(int $val): void {
    $count = $val + 1; // variable names are in camelCase
    /*
     ...
     */
}

/**
 * Placeholder variables
 */

function foo(int $x, int $_): void {
    // ...
}

// p.s. `__` double underscore is reserved for Hack's built-in functions