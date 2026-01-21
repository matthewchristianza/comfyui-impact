FROM timpietruskyblibla/runpod-worker-comfy:3.6.0-sdxl

# Install Impact Pack (skip sam2 to save space - use existing torch)
RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    cd /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    git submodule update --init --recursive && \
    pip install --no-cache-dir ultralytics segment-anything opencv-python-headless scipy scikit-image piexif

# Download YOLO face detection models
RUN mkdir -p /comfyui/models/ultralytics/bbox && \
    wget -q -O /comfyui/models/ultralytics/bbox/face_yolov8m.pt \
        https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt
