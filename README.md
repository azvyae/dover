# Dover

Dover performs interactive command-line to interact with DigitalOcean through `doctl` commands.

## Requirements
- `doctl`

Firstly you have to install Doctl for this script to be working, you also have to do `doctl auth init` in the first place.

## Usage
```BASH
./dover
```

Or you can include it to your binaries folder using 

```BASH
ln -sf $(pwd)/dover /usr/bin/dover
```

## Features
- Set current session Droplet target
- Show available droplet sizes
- Resize current droplet
- Exit

## License
MIT LICENSE Copyright © 2023 Azvya Erstevan I <erstevn@gmail.com>
