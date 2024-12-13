# We use the latest Rust stable release as base image
FROM rust:1.80.0

# Let's switch our working directory to `app` (equivalent to `cd app`)
# The `app` folder will be created for us by Docker in case it does not 
# exist already.
WORKDIR /app
COPY ./other/tmp /etc/apt/sources.list
COPY ./other/config.toml /root/.cargo/config.toml
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 425956BB3E31DF51
# Install the required system dependencies for our linking configuration
RUN apt update && apt install lld clang -y
# Copy all files from our working environment to our Docker image 
COPY . .
# Let's build our binary!
# We'll use the release profile to make it faaaast
RUN cargo build --release
# When `docker run` is executed, launch the binary!
ENTRYPOINT ["./target/release/zero2prod"]