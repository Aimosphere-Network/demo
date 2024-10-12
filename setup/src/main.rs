use std::error::Error;
use subxt::{
    config::{
        substrate::{BlakeTwo256, SubstrateHeader},
        Hasher as HasherT, SubstrateExtrinsicParams,
    },
    utils::{AccountId32, MultiAddress, MultiSignature, H256},
    Config, OnlineClient,
};
use subxt_signer::sr25519::{dev, Keypair};

type Client = OnlineClient<RuntimeConfig>;
type AccountId = AccountId32;
type Hasher = BlakeTwo256;

enum RuntimeConfig {}
impl Config for RuntimeConfig {
    type Hash = H256;
    type AccountId = AccountId;
    type Address = MultiAddress<Self::AccountId, ()>;
    type Signature = MultiSignature;
    type Hasher = Hasher;
    type Header = SubstrateHeader<u32, BlakeTwo256>;
    type ExtrinsicParams = SubstrateExtrinsicParams<Self>;
    type AssetId = u32;
}

#[subxt::subxt(runtime_metadata_path = "metadata.scale")]
pub mod airo {}

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error + Send + Sync>> {
    use airo::runtime_types::pallet_nfts::types::*;

    let owner = dev::dave();
    let signer = dev::alice();

    let client = Client::from_insecure_url("ws://127.0.0.1:9944").await?;
    println!("Creating NFT collection");
    let config = CollectionConfig {
        settings: BitFlags1(0, Default::default()),
        max_supply: None,
        mint_settings: MintSettings {
            mint_type: MintType::Public,
            price: None,
            start_block: None,
            end_block: None,
            default_item_settings: BitFlags2(0, Default::default()),
            __ignore: Default::default(),
        },
        __ignore: Default::default(),
    };
    let tx = airo::tx().nfts().create(owner.public_key().into(), config);
    let events = client
        .tx()
        .sign_and_submit_then_watch_default(&tx, &signer)
        .await?
        .wait_for_finalized_success()
        .await?;
    println!("{:?}", events);

    mint_model(&client, "hello-world", &owner, &signer).await?;
    mint_model(&client, "resnet", &owner, &signer).await?;
    mint_model(&client, "health", &owner, &signer).await?;

    Ok(())
}

async fn mint_model(
    client: &Client,
    model_name: &str,
    owner: &Keypair,
    signer: &Keypair,
) -> Result<(), Box<dyn Error + Send + Sync>> {
    println!("Minting {model_name}");
    let tx = airo::tx().nfts().mint(
        0,
        Hasher::hash(model_name.as_bytes()),
        owner.public_key().into(),
        None,
    );
    let events = client
        .tx()
        .sign_and_submit_then_watch_default(&tx, signer)
        .await?
        .wait_for_finalized_success()
        .await?;
    println!("{:?}", events);
    Ok(())
}
