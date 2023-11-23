use anchor_lang::prelude::*;

declare_id!("GeqRnyZsQ3iShsMD11sB6rD9KtPCNHJ2y2hN5H4kdNoN");

#[program]
pub mod example {
    use super::*;

    pub fn initialize(_ctx: Context<Initialize>) -> Result<()> {
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize {}
