const int MAX_USERS = 100;
<<__EntryPoint>>
function main(): void {
  // Basic variables with type inference
  $intValue = 42;
  $floatValue = 3.14159;
  $stringValue = "Hello, Hack!";
  $boolValue = true;
  
  // Printing variables
  echo "Integer: $intValue\n";
  echo "Float: $floatValue\n";
  echo "String: $stringValue\n";
  echo "Boolean: " . ($boolValue ? "true" : "false") . "\n";
  
  // Hack naming conventions for variables
  $userCount = 10;       // camelCase for variables
  $isActive = false;     // boolean variables often start with "is", "has", etc.
  
  // Constants are usually uppercase with underscores
  // Constants at function level don't need type annotations
  
  echo "Max users: " . MAX_USERS . "\n";
}