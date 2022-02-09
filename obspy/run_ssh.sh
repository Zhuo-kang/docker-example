docker container rm -f obspy_ssh
docker run -d \
        -p 3333:22 \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        -v /mnt/e/docker/NP2021:/home/${USER} \
        -v /mnt/e/pycharm/Data_NP2021:/home/${USER}/data:ro \
        --name obspy_ssh zkguan/obspy