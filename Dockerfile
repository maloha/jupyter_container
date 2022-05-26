FROM ubuntu:20.04
MAINTAINER "Loïc Mahé"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	libopencv-dev \
    python3-pip \
	python3-opencv && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install tensorflow && \
    pip3 install numpy \
        pandas \
        sklearn \
        matplotlib \
        seaborn \
        jupyter \
        pyyaml \
        tensorflow_datasets \
        h5py && \
    pip3 install keras --no-deps && \
    pip3 install opencv-python && \
    pip3 install imutils

RUN ["mkdir", "notebooks"]

RUN mkdir -p /root/.jupyter
COPY jupyter_notebook_config.py /root/.jupyter

COPY run_jupyter.sh /

# Jupyter and Tensorboard ports
EXPOSE 8888 6006

# Store notebooks in this mounted directory
VOLUME /notebooks

ENTRYPOINT ["/run_jupyter.sh"]
