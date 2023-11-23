#![cfg(feature = "test-sbf")]

use anchor_client::{Client, Cluster, Program};
use anchor_lang::AccountDeserialize;

#[test]
fn test_initialize() -> Result<(), Box<dyn Error>>{
    let key: Rc<Keypair> = Rc::new(
        read_keypair_file("../../example.json").unwrap(),
    );

    let client: Client = Client::new(Cluster::Localnet, Rc::clone(&key) as Rc<dyn Signer>);
    let program: Program = client.program(example::ID);

    Ok(())
}
