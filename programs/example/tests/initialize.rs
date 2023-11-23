#![cfg(feature = "test-sbf")]

use anchor_client::{Client, Cluster, Program};
use anchor_lang::AccountDeserialize;
#[cfg(feature = "test-coverage")]
use grcov::LcovFile;
use solana_program_test::{processor, tokio, ProgramTest};

#[test]
fn test_initialize() {
    let client: Client = Client::new(Cluster::Localnet, Rc::clone(&key) as Rc<dyn Signer>);
    let program: Program = client.program(example::ID);
}
