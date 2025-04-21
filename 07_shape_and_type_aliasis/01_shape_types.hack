// Type aliases create alternative names for types
// the `type` creates a transparent alias (interchangeable with the original type)

type UserId = int;
type Username = string;

// the `newtype` creates an opaque alias (not interchangeable with the original type) -> stronger type safety
// `as` adds a constraint
newtype PositiveInt as int = int;
newtype Email as string = string;

// Validator function for the opaque type
function create_positive_int(int $value): ?PositiveInt
{
    if ($value > 0) {
        return $value as PositiveInt;
    }
    return null;
}

function create_email(string $value): ?Email
{
    if (filter_var($value, FILTER_VALIDATE_EMAIL)) {
        return $value as Email;
    }
    return null;
}

// Shapes ate similar to structs in other languages
// they are used to define a structure with named fields
// they are fixed collection of named values
type UserData = shape(
    'id' => UserId,
    'name' => Username,
    'email' => Email,
    ?'age' => int
);

// function taking and returning a shape
function update_user_data(
    UserData $user,
    ?string $new_name = null,
    ?int $new_age = null,
): UserData
{
    // create a copy of the user
    $updated_user = $user;

    // update the fields if provided
    if ($new_name !== null) {
        $updated_user['name'] = $new_name;
    }
    if ($new_age !== null) {
        $updated_user['age'] = $new_age;
    }

    return $updated_user;
}

// function using an open shape (... allows additional fields)
type ConfigShape = shape(
    'debug' => bool,
    'timeout' => int,
    ... // The "..." operator allows for additional fields
);

function process_config(ConfigShape $config): void
{
    echo "Debug Mode: " . ($config['debug'] ? 'On' : 'Off') . "\n";
    echo "Timeout: " . $config['timeout'] . " seconds\n";

    // with open shapes, we can access additional fields with Shapes::idx()
    $cache_time = Shapes::idx($config, 'cache_time', 60);
    echo "Cache Time: " . (string)$cache_time . " seconds\n";
}

<<__EntryPoint>>

function main(): void
{
    // using type aliases
    $user_id = 1234; // type inferred as UserId (transparently as int)
    echo "User ID: " . $user_id . "\n";

    // using opaque type aliases
    $positive = create_positive_int(42);
    if ($positive !== null) {
        echo "Positive Int: " . $positive . "\n";
    } else {
        echo "Invalid Positive Int\n";
    }

    $invalid_positive = create_positive_int(-1);
    if ($invalid_positive !== null) {
        echo "Positive Int: " . $invalid_positive . "\n";
    } else {
        echo "Invalid Positive Int\n";
    }

    $email = create_email("abhinav.dholi@email.com");
    if ($email !== null) {
        echo "Email: " . $email . "\n";
    } else {
        echo "Invalid Email\n";
    }

    // create a shape
    $user = shape(
        'id' => 1001,
        'name' => 'Abhinav',
        'email' => $email ?? "invalid", // using null coalescing operator
        // age is optional
    );

    // accessing shape fields
    echo "User ID: " . $user['id'] . "\n";
    echo "User Name: " . $user['name'] . "\n";
    echo "User Email: " . $user['email'] . "\n";

    // updating shape
    $updated_user = update_user_data($user, null, 30);
    echo "Updated User Details:\n";
    echo "User ID: " . $updated_user['id'] . "\n";
    echo "User Name: " . $updated_user['name'] . "\n";
    echo "User Email: " . $updated_user['email'] . "\n";
    echo "User Age: " . ($updated_user['age'] ?? 'Not Provided') . "\n";

    // using open shape
    $config = shape(
        'debug' => true,
        'timeout' => 30,
        'cache_time' => 120, // additional field not in the shape type
        'log_level' => 'debug', 
    );

    echo "Config Details:\n";
    process_config($config);
}