FROM timpietruskyblibla/runpod-worker-comfy:3.6.0-sdxl

# Install system dependencies for OpenCV
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libglib2.0-0 \
        libgl1-mesa-glx \
        libsm6 \
        libxext6 \
        libxrender1 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Impact Pack Python dependencies
RUN pip install --no-cache-dir \
    ultralytics \
    segment-anything \
    "opencv-python==4.8.1.78" \
    scipy \
    scikit-image \
    piexif \
    dill

# Clone Impact Pack with all submodules - pinned to oldest available tag
RUN git clone --recursive https://github.com/ltdrdata/ComfyUI-Impact-Pack /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    cd /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    git checkout 8.8.1 && \
    git submodule update --init --recursive

# Also clone Impact Subpack separately (contains UltralyticsDetectorProvider)
RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Subpack /comfyui/custom_nodes/ComfyUI-Impact-Subpack

# Download YOLO model
RUN mkdir -p /comfyui/models/ultralytics/bbox && \
    wget -q -O /comfyui/models/ultralytics/bbox/face_yolov8m.pt \
        https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt
