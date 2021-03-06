#![allow(non_camel_case_types)]

use exocore::core::utils::path::child_to_abs_path;
use std::path::{Path, PathBuf};
use structopt::StructOpt;

#[derive(StructOpt)]
#[structopt(name = "exomind-gmail", about = "Exomind Gmail integration")]
pub struct Options {
    #[structopt(long, short, default_value = "info")]
    /// Logging level (off, error, warn, info, debug, trace)
    pub logging_level: String,

    #[structopt(long, short = "c", default_value = "gmail.yaml")]
    pub config: PathBuf,

    #[structopt(subcommand)]
    pub subcommand: SubCommand,
}

#[derive(StructOpt)]
pub enum SubCommand {
    start(StartOptions),
    list_accounts,
    login(LoginOptions),
    logout(LogoutOptions),
}

#[derive(StructOpt)]
pub struct StartOptions {
    #[structopt(long)]
    pub save_fixtures: bool,
}

#[derive(StructOpt)]
pub struct LoginOptions {
    pub email: String,
}

#[derive(StructOpt)]
pub struct LogoutOptions {
    pub email: String,
}

#[derive(Clone, Deserialize)]
pub struct Config {
    pub node_config: PathBuf,

    pub client_secret: PathBuf,

    pub tokens_directory: PathBuf,
}

impl Config {
    pub fn from_file(path: &Path) -> anyhow::Result<Config> {
        let file = std::fs::File::open(path)?;
        let mut config: Config = serde_yaml::from_reader(file)?;

        let config_dir = path
            .parent()
            .ok_or_else(|| anyhow!("Couldn't get config parent directory"))?;

        config.node_config = child_to_abs_path(config_dir, &config.node_config);
        config.client_secret = child_to_abs_path(config_dir, &config.client_secret);
        config.tokens_directory = child_to_abs_path(config_dir, &config.tokens_directory);

        Ok(config)
    }
}
