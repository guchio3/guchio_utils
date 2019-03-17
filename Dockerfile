# base image
FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

# RUN: docker buildするときに実行される
RUN echo "now building..."
