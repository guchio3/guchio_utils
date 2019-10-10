# check the number of args
if [ $# -ne 1 ]; then
    echo "invalid # of args"
    echo "your's is $#, but only 1 (cpu or gpu) is needed."
fi

mkdir ./mnt
chmod 777 ./mnt

if [ $1 = gpu ]; then
    sh gpu_setup.sh
    sh docker_setup.sh gpu
    sudo docker build -t kaggle_$1 -f kaggle_Dockerfile . --build-arg BASE_IMG="nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04"
elif [ $1 = cpu ]; then
    sh docker_setup.sh cpu
    sudo docker build -t kaggle_$1 -f kaggle_Dockerfile . --build-arg BASE_IMG="ubuntu"
else
    echo "invalid argment, $1"
    exit 1
fi
