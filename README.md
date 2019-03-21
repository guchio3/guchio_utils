# guchio_utils
a repo which contains my tools and wiki

# tools
### my_lightgbm
* contents
    * .cv returns each model
* base version
    * lightgbm                  2.2.1            py37he6710b0_0

# environments
### kaggle_setup.sh
* setup instances
```
sh kaggle_setup.sh gpu (or cpu)
```

### use env (--privileged --device /dev/fuse は sshfs するため)
```
nvidia-docker run -it --privileged --device /dev/fuse --name kaggle_gpu -v $HOME/.ssh:/root/.ssh -v $HOME/.kaggle:/root/.kaggle -v $PWD:/workspace/kaggle-XXXX -w=/workspace/kaggle-XXXX -p 8888:8888 -e TZ=Asia/Tokyo kaggle_gpu bash
```
