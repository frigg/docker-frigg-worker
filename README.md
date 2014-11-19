# frigg-worker in a docker container

## Setup
Install docker and run:

```bash
git clone https://github.com/frigg/docker-frigg-worker.git
cd docker-frigg-worker && make
```

## Usage
```bash
make           # Build image and run a worker
make setup     # Build image
make run       # Run a worker
make killall   # Kill all workers
```
