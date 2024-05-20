# Используем официальный образ NVIDIA CUDA
FROM nvidia/cuda:11.2.2-cudnn8-runtime-ubuntu20.04

# Устанавливаем Python и необходимые зависимости
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.8 \
    python3-pip \
    python3-dev \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    git && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем pip, setuptools и wheel
RUN python3 -m pip install --upgrade pip setuptools wheel

# Копирование файла требований зависимостей Python в контейнер
COPY requirements.txt /workspace/requirements.txt

# Установка зависимостей Python из файла требований
RUN pip install --no-cache-dir -r /workspace/requirements.txt

# Копирование оставшегося исходного кода проекта в контейнер
COPY . /workspace

# Установка рабочей директории
WORKDIR /workspace

# Команда по умолчанию, запускающая оболочку bash
CMD ["bash"]