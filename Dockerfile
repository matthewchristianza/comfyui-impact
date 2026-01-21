FROM timpietruskyblibla/runpod-worker-comfy:3.6.0-sdxl

# Install Impact Pack with all dependencies
RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    cd /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    git submodule update --init --recursive && \
    pip install -r requirements.txt && \
    python install.py

# Install ultralytics for YOLO detection
RUN pip install ultralytics

# Download YOLO face detection models
RUN mkdir -p /comfyui/models/ultralytics/bbox && \
    mkdir -p /comfyui/models/ultralytics/segm && \
    wget -O /comfyui/models/ultralytics/bbox/face_yolov8m.pt \
        https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt && \
    wget -O /comfyui/models/ultralytics/bbox/face_yolov8n.pt \
        https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n.pt
