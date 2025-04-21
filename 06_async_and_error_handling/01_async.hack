use namespace HH\Lib\{Str, Vec};

// a basic async function

async function fetchData(string $id): Awaitable<string> {
    await HH\Asio\usleep(1000);
    return "Data for ID: ".$id;
}

// function that makes multiple async calls in sequence
async function fetchSequential(vec<string> $ids): Awaitable<vec<string>> {
    $results = vec[];
    foreach ($ids as $id) {
        // Each await blocks the execution until complete - this is slow
        $data = await fetchData($id);
        $results[] = $data;
    }
    return $results;
}

// Function that makes multiple async calls in parallel - this is fast
async function fetchParallel(vec<string> $ids): Awaitable<vec<string>> {
    // create a vec of awaitables
    $awaitables = Vec\map($ids, $id ==> fetchData($id));

    // wait for all of them to complete then return
    return await Vec\from_async($awaitables);
}

// Using async/await with a try/catch block for error handling
async function fetchWithErrorHandling(string $id): Awaitable<string> {
    try {
        if ($id === "error") {
            throw new \Exception("Error fetching data for ID: ".$id);
        }
        return await fetchData($id);
    } catch (\Exception $e) {
        return "Error: ".$e->getMessage();
    }
}

// Example of concurrent block syntax (Modern Hack)
async function fetchWithConcurrent(
    vec<string> $ids,
): Awaitable<(string, string)> {
    // concurrent block allows multiple async calls to be made in parallel
    // and waits for all of them to complete
    concurrent {
        $first = await fetchData($ids[0]);
        $second = await fetchData($ids[1]);
    }

    return tuple($first, $second);
}

// To use await in main -> we make main async
<<__EntryPoint>>
async function main(): Awaitable<void> {
    // Async functions mush be awaited and joined
    // since main is async we can use await

    // Sequential fetch (slow)
    $start = microtime(true);
    $sequentialResults = await fetchSequential(vec["1", "2", "3"]);
    $end = microtime(true);
    echo "Sequential fetch took: ".($end - $start)." seconds\n";

    foreach ($sequentialResults as $data) {
        echo $data."\n";
    }

    // Parallel fetch (fast)
    $start = microtime(true);
    $parallelResults = await fetchParallel(vec["1", "2", "3"]);
    $end = microtime(true);
    echo "Parallel fetch took: ".($end - $start)." seconds\n";

    foreach ($parallelResults as $data) {
        echo $data."\n";
    }

    // Error handling
    $errorResult = await fetchWithErrorHandling("error");
    echo $errorResult."\n";

    // using the concurrent block
    try {
        $concurrentResults = await fetchWithConcurrent(vec["4", "5"]);
        echo "\n Concurrent results: \n" . $concurrentResults[0] . "\n" . $concurrentResults[1] . "\n";
    }

    catch (\Exception $e) {
        echo "Concurrent Block not supported - Caught exception: ".$e->getMessage()."\n";
    }

}