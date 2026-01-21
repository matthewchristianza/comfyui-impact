FROM timpietruskyblibla/runpod-worker-comfy:3.6.0-sdxl

# Install Impact Pack dependencies first
RUN pip install --no-cache-dir ultralytics segment-anything opencv-python-headless scipy scikit-image piexif

# Clone Impact Pack and its submodules
RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    cd /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    git submodule update --init --recursive

# Create Impact Pack config to skip dependency check
RUN mkdir -p /comfyui/custom_nodes/ComfyUI-Impact-Pack/config && \
    echo '{"skip_dependency_check": true}' > /comfyui/custom_nodes/ComfyUI-Impact-Pack/config/config.json

# Download YOLO face detection model
RUN mkdir -p /comfyui/models/ultralytics/bbox && \
    wget -q -O /comfyui/models/ultralytics/bbox/face_yolov8m.pt \
        https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt
