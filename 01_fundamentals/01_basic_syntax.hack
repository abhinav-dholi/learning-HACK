const float PI = 3.14; // constant type value

<< __EntryPoint>>
function main(): void {

    
    // define some variables
    $name = "user";
    $age = 25;

    echo "Hello, $name! You are $age years old.\n";

    echo "Area of circle with radius 5: " . calculateAreaOfCircle((float)5) . "\n";
}

function calculateAreaOfCircle(float $radius): float {
    return PI * $radius * $radius;
}

