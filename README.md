# Dover

Dover performs interactive command-line to interact with DigitalOcean through `doctl` commands.

## Requirements
- `doctl`
- `git`

Firstly you have to install Doctl for this script to be working, you also have to do `doctl auth init` in the first place.
Only works in MacOS or Linux. In windows currently you have to install using WSL2

## Installation

1. Clone this repository

    ```BASH
    git clone https://github.com/erstevn/dover.git
    ```

2. Include binary to your linux binaries (optional)
    ```BASH
    ln -sf $(pwd)/dover /usr/bin/dover
    ```

## Usage

**Basic Usage:**

```BASH
./dover
```

**Or if you included to your binaries folder:**

```BASH
dover
```



## Features
- Set current session Droplet target
- Show available droplet sizes
- Resize current droplet
- Exit

## License
MIT LICENSE Copyright © 2023 Azvya Erstevan I <erstevn@gmail.com>
