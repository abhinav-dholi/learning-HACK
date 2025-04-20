use namespace HH\Lib\{Vec, Dict, Keyset, C};

<<__EntryPoint>>
function main(): void {
    // Hack has three main collection types: vec, dict, and keyset

    // vec is an ordered collection of values (like python list and Java ArrayList)
    $numbers = vec[1, 2, 3, 4, 5];
    echo "First element of vec: ".$numbers[0]."\n"; // 1
    echo "Last element of vec: ".$numbers[count($numbers) - 1]."\n"; // 5

    // Adding to a vec (creates a new vec)
    $numbers = Vec\concat($numbers, vec[6, 7]);
    echo "After adding elements: ".implode(", ", $numbers)."\n"; // 1, 2, 3, 4, 5, 6, 7
    // Removing from a vec (creates a new vec)
    $numbers = Vec\filter($numbers, $x ==> $x !== 3);
    echo "After removing element 3: ".implode(", ", $numbers)."\n"; // 1, 2, 4, 5, 6, 7

    // dict -- key-value pairs (like python dict and Java HashMap)
    $userScores = dict[
        "Abhinav" => 95,
        "John" => 85,
        "Bob" => 90,
    ];

    echo "Score of Abhinav: ".$userScores["Abhinav"]."\n"; // 95

    // modifying a dict
    $updatedScores = Dict\merge(
        $userScores,
        dict["Alice" => 88, "Bob" => 92] // adds Alice and updates Bob's score
    );
    \print_r($updatedScores); // prints the updated scores

    // keyset -- a collection of unique keys (like python set and Java HashSet)
    $uniqueNames = keyset["Abhinav", "Alice", "Bob", "Abhinav"];
    echo "Unique names: ".implode(", ", $uniqueNames)."\n"; // Abhinav, Alice, Bob

    // Common operations on collections

    // 1. check if an element exists
    if (C\contains($numbers, 3)) {
        echo "3 is in the vec\n";
    } else {
        echo "3 is not in the vec\n";
    }

    if (C\contains_key($userScores, "John")) {
        echo "underscores contains John\n";
    }

    // 2. filtering an element
    $highScores = Vec\filter($userScores, $score ==> $score >= 90);
    echo "Students with high scores: " . C\count($highScores) . "\n"; // 3

    // 3. transforming elements
    $doubledNumbers = Vec\map($numbers, $num ==> $num * 2);
    echo "Doubled numbers: ";
    foreach ($doubledNumbers as $n) {
        echo $n . " ";
    }
    echo "\n"; // 2, 4, 8, 10, 12, 14

    // 4. reducing a collection to a single value -> the part that you're thinking of is a lambda function (grow up)
    $sum = C\reduce($numbers, ($acc, $n) ==> $acc + $n, 0);
    echo "Sum of numbers: $sum\n"; // 28

    // 5. Get keys and values from a dict
    $studentNames = vec[];
    foreach ($userScores as $name => $_) {
        $studentNames[] = $name;
    }
    echo "Student names: ";

    foreach ($studentNames as $name) {
        echo $name . " ";
    }
    echo "\n"; // Abhinav, John, Bob, Alice


}
