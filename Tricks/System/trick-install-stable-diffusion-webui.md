# Installation de Stable Diffusion

## Sources :

- https://github.com/AUTOMATIC1111/stable-diffusion-webui

## Ubuntu 24.04

```
# Get sources
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui
cd stable-diffusion-webui

# Install requirements
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install wget git python3 python3-venv libgl1 libglib2.0-0 pip
sudo apt install python3.11 python3.10 python3.10-distutils python3.11-distutils


# Launch Webui
./webui.sh --use-cpu all --precision full --no-half --skip-torch-cuda-test
```
