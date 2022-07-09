FROM ubuntu
ARG USERNAME=img-bldr

# add needed base packages for ensuing commands
RUN apt update && \
    apt-get install -y \
    apt-transport-https ca-certificates \
    curl software-properties-common libssl-dev \
    libffi-dev git wget


# add Docker key and repo and packages and then run the docker service
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && apt-get upgrade -y && apt-get autoremove -y && \
    apt-get install -y docker-ce containerd.io


# todo: figure out if this is needed for my own kubernetes cluster (in the future)
# optional - add kubectl key and repo and package
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
#     echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
#     apt-get install -y kubectl

#this script will run the build command for the user's docker image
#the user should provide specific environment variables
COPY entrypoint.sh /usr/local/bin

# create image-builder user and add it do docker group
# this is for the purpose if I need to debug anything about the container??
# is it even needed?
# RUN groupadd -r ${USERNAME} && useradd -r -m -g ${USERNAME} ${USERNAME} && \
#     usermod -aG docker ${USERNAME}
# WORKDIR /home/${USERNAME}
# USER ${USERNAME}

# Specify the executable to run once this container is run
CMD ["entrypoint.sh"]
