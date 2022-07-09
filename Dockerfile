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

#this script will run the build command for the user's docker image
#the user should provide specific environment variables
COPY entrypoint.sh /usr/local/bin

# Specify the executable to run once this container is run
CMD ["entrypoint.sh"]
