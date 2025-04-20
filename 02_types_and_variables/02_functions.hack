const int MAX_VAlUE = 1000;

// function to add two integers
function add(int $a, int $b): int {
  return $a + $b;
}

// function with optional parameter
function greet(string $name, string $greeting = "Hello"): string {
  return "$greeting, $name!";
}

// Function will nullable parameter and return type, ?string tells that the function can return null or a string
function findUser(int $id) : ?string {
    // Simulate a user lookup
    if ($id > 0 && $id < 10) {
        return "User" . $id;
    }
    return null;
}

<<__EntryPoint>>
function main(): void {
    // Calling functions
    $sum = add(5, 10);
    echo "Sum of 5 and 10 is: $sum\n";

    // using default parameter
    echo greet("Abhinav") . "\n"; // Hello, Abhinav!
    // using optional parameter
    echo greet("Abhinav", "Welcome") . "\n"; // Welcome, Abhinav!

    // using nullable return type
    $user = findUser(5);
    if ($user !== null) {
        echo "Found user: $user\n";
    } else {
        echo "User not found\n";
    }

    $nonExistentUser = findUser(15);
    if ($nonExistentUser !== null) {
        echo "Found user: $nonExistentUser\n";
    } else {
        echo "User not found\n";
    }

    // Using top level constant
    echo "Max value is: " . MAX_VAlUE . "\n";

}
