use anchor_client::{Client, Cluster};
use solana_sdk::signature::{read_keypair_file, Keypair, Signature};
use solana_sdk::pubkey::Pubkey;
use solana_sdk::signer::Signer;
use std::rc::Rc;
use std::error::Error;
use std::env;
use example::RustStation;
use solana_sdk::system_program;
use std::time::Duration;
use std::thread;

#[test]
fn test_initialize() -> Result<(), Box<dyn Error>> {
    let mut path = env::var("HOME")
    .expect("HOME environment variable not set");

    path.push_str("/.config/solana/id.json");

    let key: Keypair = read_keypair_file(path)?;
    let payer = Rc::new(key);

    let client = Client::new(Cluster::Localnet, payer.clone());
    let program = client.program(example::ID)?;
    
    // let program_id = program.id();
    // let program_address = program_id.to_string();
    // let airdrop_result = program
    // .rpc()
    // .request_airdrop(&program.payer(), 10000000);
 
    // assert!(airdrop_result.is_ok());

    let balance = program
        .rpc()
        .get_balance(&program.payer())
        .unwrap_or(0);
        
    println!("Payer balance: {} SOL", balance);   

    // Build, sign, and send program instruction
    let rust_station: Pubkey = RustStation::get_pda(&program.payer());
    let sig: Signature = program
        .request()
        .accounts(example::accounts::SignDemo {
            user: program.payer(),
            rust_station,
            system_program: system_program::ID,
        })
        .args(example::instruction::SignDemo {/* this ix has no args */})
        .send()?;

    println!("demo sig: {sig}");

    // Retrieve and validate state
    let rust_station_account: RustStation = program.account(rust_station)?;
    assert!(rust_station_account.oxidized);

    Ok(())
}
