use std::{collections::HashMap, fmt::Display};

const DEFAULT_PORT: u16 = 8080;

#[derive(Debug, Clone)]
struct ServerConfig<T> {
    host: String,
    port: u16,
    metadata: HashMap<String, T>,
}

trait Renderable {
    fn render(&self) -> String;
}

impl<T: Display> ServerConfig<T> {
    fn new(host: impl Into<String>, metadata: HashMap<String, T>) -> Self {
        Self {
            host: host.into(),
            port: DEFAULT_PORT,
            metadata,
        }
    }

    async fn connect(&self) -> Result<String, Box<dyn std::error::Error>> {
        let endpoint = format!("https://{}:{}", self.host, self.port);
        if self.metadata.is_empty() {
            return Err("metadata must not be empty".into());
        }
        Ok(endpoint)
    }
}

fn main() {
    // Values stay prominent while control flow retains its own identity.
    let metadata = HashMap::from([("environment".into(), "production")]);
    let config = ServerConfig::new("vulkan.example", metadata);
    println!("{config:#?}");
}
