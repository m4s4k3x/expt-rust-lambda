use std::any::TypeId;
use std::{error, fmt};
use std::error::StdError;
use lambda_runtime::{ handler_fn, Context, Error, StdError};
use serde_json::{json, Value};
use serde::{Serialize, Deserialize};
use anyhow::Result;

#[derive(Serialize, Deserialize, Clone, Debug)]
struct Input {
    base_date: String,
    is_notify: bool,
}

#[derive(Serialize, Clone, Debug)]
struct OutputSuccess {
    message: String,
}

impl fmt::Display for OutputSuccess {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "({})", self.message)
    }
}

#[derive(Serialize, Clone, Debug, StdError)]
struct OutputFailure {
    error: String,
}


impl fmt::Display for OutputFailure {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "({})", self.error)
    }
}

#[tokio::main]
async fn main() -> Result<(), Error> {
    let func = handler_fn(handler);
    lambda_runtime::run(func).await?;

    Ok(())
}

async fn handler(event: Input, _: Context) -> Result<OutputSuccess, OutputFailure> {
    match serde_json::to_string(&event) {
        Ok(v) => {
            Ok(OutputSuccess {
                message: v,
            })
        }
        Err(e) => {
            Err(OutputFailure {
                error: format!("{:?}", event),
            })
        }
    }
}
