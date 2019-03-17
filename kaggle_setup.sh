# check the number of args
if [ $# -ne 1 ]; then
    echo "invalid # of args"
    echo "your's is $#, but only 1 (cpu or gpu) is needed."
fi

if [ $1 = gpu ]; then
    sh gpu_setup.sh
    sh docker_setup.sh gpu
elif [ $1 = cpu ]; then
    sh docker_setup.sh cpu
else
    echo "invalid argment, $1"
    exit 1
fi

docker build -t kaggle_$1 -f kaggle_$1_dockerfile .
