#bash
nix eval --json --expr 'import ./xray/default.nix' > ./xray/versions/gen1.json --impure
