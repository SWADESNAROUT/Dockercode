FROM ubuntu:16.04
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:THEPASSWORDYOUCREATED' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
#RUN  ["ssh","start","-D"] 
RUN ssh-keygen -f $HOME/.ssh/id_rsa -N ''
RUN cp $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys
#RUN  ["ssh","restart"] 
#CMD ["/bin/bash", "-D"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
