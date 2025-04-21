use namespace HH\Lib\{C, Vec};

// generics are a way to create reusable code components
// that can work with different data types
// they allow you to define a function or class that can operate on different types
// without having to write separate code for each type

// Generic class with a single type parameter
class Box<T> {
    public function __construct(private T $value) {}

    public function get(): T {
        return $this->value;
    }

    public function set(T $value): void {
        $this->value = $value;
    }

}

// Generic class with a type constraint
class NumberBox<T as num>{
    public function __construct(
        private T $value
    )
    {}

    public function get(): T
    {
        return $this->value;
    }

    public function increment(): void
    {
        $this->value++;
    }

}
// Generic function
// inout is used to indicate that the parameters can be modified
// and the changes will be reflected outside the function
// inout is passed by reference and usual parameters are passed by value
function swap<T>(inout T $a, inout T $b): void 
{
    $temp = $a;
    $a = $b;
    $b = $temp;
}

// Generic function with type constraint
function sumNumbers<T as num>(vec<T> $values): num
{
    if (C\is_empty($values)){
        return 0;
    }
    $result = $values[0];
    for ($i = 1; $i < count($values); $i++) {
        $result += $values[$i];
    }
    return $result;
}

<<__EntryPoint>>
function main(): void {
    // using the generic box class with different types
    $intBox = new Box<int>(42);
    echo "Int Box: " . $intBox->get() . "\n";

    $stringBox = new Box<string>("Hello, Abhinav!");
    echo "String Box: " . $stringBox->get() . "\n";

    // using the type constraint number box class
    $numberBox = new NumberBox<int>(10);
    echo "Number Box: " . $numberBox->get() . "\n";
    $numberBox->increment();
    echo "Incremented Number Box: " . $numberBox->get() . "\n";

    $floatNumberBox = new NumberBox<float>(10.5);
    echo "Float Number Box: " . $floatNumberBox->get() . "\n";
    $floatNumberBox->increment();
    echo "Incremented Float Number Box: " . $floatNumberBox->get() . "\n";

    // using the generic swap function
    $a = 5;
    $b = 10;
    echo "Before swap: a = $a, b = $b\n";
    swap(inout $a, inout $b);
    echo "After swap: a = $a, b = $b\n";

    // using generic function with type constraint
    $integers = vec[1, 2, 3, 4, 5];
    $floats = vec[1.1, 2.2, 3.3, 4.4, 5.5];

    echo "Sum of integers: " . sumNumbers($integers) . "\n";
    echo "Sum of floats: " . sumNumbers($floats) . "\n";

}