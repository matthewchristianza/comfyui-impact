FROM timpietruskyblibla/runpod-worker-comfy:3.6.0-sdxl

# Install system dependencies for OpenCV
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends libglib2.0-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Impact Pack Python dependencies
RUN pip install --no-cache-dir \
    ultralytics \
    segment-anything \
    scipy \
    scikit-image \
    piexif

# Remove opencv-python (has GUI dependencies) and use only headless version
RUN pip uninstall -y opencv-python && \
    pip install --no-cache-dir "opencv-python-headless==4.8.1.78"

# Clone Impact Pack
RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    cd /comfyui/custom_nodes/ComfyUI-Impact-Pack && \
    git submodule update --init --recursive

# Download YOLO model
RUN mkdir -p /comfyui/models/ultralytics/bbox && \
    wget -q -O /comfyui/models/ultralytics/bbox/face_yolov8m.pt \
        https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt
