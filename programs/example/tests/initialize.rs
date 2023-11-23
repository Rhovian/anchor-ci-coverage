#![cfg(feature = "test-sbf")]

#[cfg(feature = "test-coverage")]
use grcov::LcovFile;
use anchor_lang::AccountDeserialize;
use solana_program_test::{ProgramTest, processor, tokio};
use anchor_client::{Client, Cluster, Program};

#[test]
fn test_initialize() {
  let client: Client = Client::new(Cluster::Localnet, Rc::clone(&key) as Rc<dyn Signer>);
  let program: Program = client.program(example::ID);
}
