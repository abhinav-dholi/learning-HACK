use namespace HH\Lib\Str;

// a simple class definition
class User {
    // constructor with promoted properties (automatically creates member variables)
    public function __construct(
        private int $id,
        private string $name,
        private int $age = 0 // Optional Parameter

    ){}

    // Getters
    // Note: -> In Hack is like . in java or python
    // It is used to access properties and methods of an object
    public function getId(): int {
        return $this->id;
    }
    public function getName(): string {
        return $this->name;
    }
    public function getAge(): int {
        return $this->age;
    }

    // Setters
    public function setAge(int $age): void {
        if ($age < 0) {
            throw new \InvalidArgumentException("Age cannot be negative");
        }
        $this->age = $age;
    }

    // Method that returns a string
    public function getDescription(): string {
        return "User ID: " . $this->id . ", Name: " . $this->name . ", Age: " . $this->age;
    }
}

// A class that extends another class

class AdminUser extends User {
    // Additional Constructor Parameter
    public function __construct(
        int $id,
        string $name,
        private string $role,
        int $age = 0
    ){
        // Call the parent constructor -> this will call the constructor of the User class
        // and set the id, name, and age properties
        // The parent constructor is called with the parameters of the User class
        parent::__construct($id, $name, $age);
    }

    // Getter for the new property
    public function getRole(): string {
        return $this->role;
    }

    // Overriding the getDescription method
    <<__Override>>
    public function getDescription(): string {
        // Call the parent method to get the base description
        $baseDescription = parent::getDescription();
        // Add the role to the description
        return $baseDescription . ", Role: " . $this->role;
    }
}

// Interface declaration
interface Displayable {
    public function display(): string;
}

// Class implementing the interface
class DisplayableUser extends User implements Displayable {
    public function display(): string {
        return "Displayable User - ID: " . $this->getId() . ", Name: " . $this->getName() . ", Age: " . $this->getAge();
    }
}

// Abstract class example
abstract class Employee {
    public function __construct(
        protected string $name,
        protected int $salary
    ){}

    // Abstract method to be implemented by child class
    abstract public function calculateBonus(): float;
    public function getAnnualSalary(): int {
        return $this->salary * 12;
    }
}

// Concrete class extending the abstract class
class Manager extends Employee {
    public function calculateBonus(): float {
        // Example bonus calculation
        return $this->salary * 0.1; // 10% of the monthly salary
    }
}

<<__EntryPoint>>
function main(): void {
    // Create a User Instance
    $user = new User(1, "Abhinav", 23);
    echo $user->getDescription() . "\n";

    // Create an AdminUser Instance
    $adminUser = new AdminUser(2, "Bob", "Administrator", 30);
    echo $adminUser->getDescription() . "\n";

    // Try setting an invalid age
    try {
        $user->setAge(-5);
    } catch (\InvalidArgumentException $e) {
        echo "Error: " . $e->getMessage() . "\n";
    }

    // Update age with a valid value
    $user->setAge(25);
    echo "Updated User Age: " . $user->getAge() . "\n";

    // using an interface
    $displayableUser = new DisplayableUser(3, "Charlie", 28);
    echo $displayableUser->display() . "\n";

    // Using the abstract class
    $manager = new Manager("Alice", 5000);
    echo "Manager Annual Salary: " . $manager->getAnnualSalary() . "\n";
    echo "Manager Bonus: " . $manager->calculateBonus() . "\n";

}
