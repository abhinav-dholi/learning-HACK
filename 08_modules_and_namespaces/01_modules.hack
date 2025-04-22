// Defining a namespace for this file
namespace Tutorial\ModuleExample;

// Import classes/functions from another namespace
use namespace HH\Lib\Str;

// Class in our current namespace
class Greeter {
    public function __construct(private string $greeting) {}

    public function greet(string $name): string {
        return $this->greeting.", ".$name."!";
    }
}

// Function in our current namespace
function format_name(string $first, string $last): string {
    return Str\format("%s %s", $first, Str\uppercase($last));
}

// Different ways to import
use namespace HH\Lib\{Math, Vec, Dict}; // Multiple imports
use type HH\Lib\Dict\MergeErrorMode; // Specific type import

<<__EntryPoint>>
function main(): void {
    // Using our namespace's class
    $greeter = new Greeter("Hello");
    echo $greeter->greet("World")."\n";

    // Using our namespace's function
    echo format_name("john", "doe")."\n";

    // Using functions from imported namespaces
    $numbers = vec[5, 1, 9, 3, 7];
    $max = Math\max($numbers);
    echo "Max number: ".$max."\n";

    // Fully qualified name without import
    $sorted = \HH\Lib\Vec\sort($numbers);
    echo "Sorted numbers: ".\implode(", ", $sorted)."\n";

    // Module example (simulated since modules are a newer feature)
    echo "\nSimulated Module Example:\n";
    echo "In a real module definition, you would use:\n";
    echo "new module example_module {}\n\n";

    echo "And in a file belonging to the module:\n";
    echo "module example_module;\n\n";

    echo "Modules add an 'internal' visibility keyword:\n";
    echo "internal class InternalHelper {} // Only visible within the module\n";
}