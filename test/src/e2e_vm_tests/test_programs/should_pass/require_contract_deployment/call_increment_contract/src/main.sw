script;

use increment_abi::Incrementor;
use dynamic_contract_call::*;

#[cfg(experimental_new_encoding = false)]
const CONTRACT_ID = 0x080ca4b6a4661d3cc2138f733cbe54095ce8b910eee73d913c1f43ecad6bf0d2;
#[cfg(experimental_new_encoding = true)]
const CONTRACT_ID = 0x45f1f78e4c108017591a3334e84c63ee7be0aca9e5a521ecf7c6fd801462e0f8;

fn main() -> bool {
    let the_abi = abi(Incrementor, CONTRACT_ID);

    let initial = the_abi.get();

    let result = the_abi.increment(5);
    assert(result == initial + 5);

    let result = the_abi.increment_or_not(None);
    assert(result == initial + 5);

    let result = the_abi.increment(5);
    assert(result == initial + 10);

    let result = the_abi.get();
    assert(result == initial + 10);

    log(result);

    // Call the fallback fn
    let result = dynamic_contract_call(CONTRACT_ID);
    assert(result == 444444444);

    true
}

fn log(input: u64) {
    asm(r1: input, r2: 42) {
        log r1 r2 r2 r2;
    }
}
