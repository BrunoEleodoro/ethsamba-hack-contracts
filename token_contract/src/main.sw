contract;

use std::{
    auth::msg_sender,
    call_frames::contract_id,
    context::balance_of,
    logging::log,
    storage::*,
    token::*,
};

use token_abi::Token;

const ZERO_B256 = 0x0000000000000000000000000000000000000000000000000000000000000000;

storage {
    owner: Address = Address {
        value: 0x0000000000000000000000000000000000000000000000000000000000000000,
    },
    mint_amount: u64 = 0,
    mint_list: StorageMap<Address, bool> = StorageMap {},
}

enum Error {
    AddressAlreadyMint: (),
    CannotReinitialize: (),
    MintIsClosed: (),
    NotOwner: (),
}

pub fn get_msg_sender_address_or_panic() -> Address {
    let sender = msg_sender();
    if let Identity::Address(address) = sender.unwrap() {
        address
    } else {
        revert(420);
    }
}

#[storage(read)]
fn validate_owner() {
    let sender = get_msg_sender_address_or_panic();
    require(storage.owner == sender, Error::NotOwner);
}

impl Token for Contract {
    #[storage(read)]
    fn mint_coins(mint_amount: u64) {
        validate_owner();
        mint(mint_amount);
    }

    #[storage(read)]
    fn burn_coins(burn_amount: u64) {
        validate_owner();
        burn(burn_amount);
    }

    #[storage(read)]
    fn transfer_coins(coins: u64, address: Address) {
        validate_owner();
        transfer_to_address(coins, contract_id(), address);
    }

    #[storage(read)]
    fn transfer_token_to_output(coins: u64, asset_id: ContractId, address: Address) {
        validate_owner();
        transfer_to_address(coins, asset_id, address);
    }

    //////////////////////////////////////
    // Mint public method
    //////////////////////////////////////
    #[storage(read, write)]
    fn mint(address: Address, amount: u64) {
        mint_to_address(amount, address);
    }

    //////////////////////////////////////
    // Read-Only methods
    //////////////////////////////////////
    #[storage(read)]
    fn get_mint_amount() -> u64 {
        storage.mint_amount
    }

    fn get_balance() -> u64 {
        balance_of(contract_id(), contract_id())
    }

    #[payable]
    fn get_token_balance(asset_id: ContractId) -> u64 {
        balance_of(asset_id, contract_id())
    }
}
