**Xray-Nix Modular Configuration**

This is a POC. It contains an example of a modular Xray (V2Ray) configuration done wit Nix.
The idea here is to create a .nix file that will call other default files from the respective orders, then we do `nix eval` on it and convert the entire thing into Json config that we then use in `services.xray.settingsFile` or `xray -c` if you're on other distro.

I left a sctipt called build.sh in the main directory that will create a new json file in ./xray/versions
The file structure can be anything really since we're using modules. I came up with this:

![image](https://github.com/user-attachments/assets/6b2af807-cd89-4be7-9a69-a4eff1d615fb)


The file that becomes json in the end looks like this:

![image](https://github.com/user-attachments/assets/b2e133ab-9d9e-4cbb-bc43-4ded9214535c)


And turns into this after we run ./build.sh:

![image](https://github.com/user-attachments/assets/af81dbc9-4c80-4b52-a27a-efd9cef9936d)


Users must be called within the inbounds files. it can be done like so:

![image](https://github.com/user-attachments/assets/16cb1239-85ff-4007-9622-d8b89b6a4c3e)
