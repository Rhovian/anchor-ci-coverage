#![feature(once_cell)] 
use anchor_lang::AccountDeserialize;
use solana_program_test::*;

mod initialize {
  #[tokio::test]
  async fn test_initialize() {
    let (mut banks_client, payer, recent_blockhash) = ProgramTest::new(
      "leveller",
      leveller::id(),
      processor!(leveller::process),
    ).start().await;

    let txn = Transaction::new_signed_with_payer(
      &[Instruction {
        program_id,  
        accounts: vec![],
        data: leveller::instruction::Initialize {}.data(), 
      }],
      Some(&payer.pubkey()),
      &[&payer],
      recent_blockhash  
    );

    banks_client.process_transaction(txn).await.unwrap();
  }
}
