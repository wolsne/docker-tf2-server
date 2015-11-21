from debian:jessie
maintainer Robin Appelman <robin@icewind.nl>

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install lib32gcc1 wget lib32ncurses5 bzip2
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV USER tf2

RUN useradd $USER
ENV HOME /home/$USER
RUN mkdir $HOME
RUN chown $USER:$USER $HOME

USER $USER
ENV SERVER $HOME/hlserver
RUN mkdir $SERVER
RUN wget -O - http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar -C $SERVER -xvz
ADD ./tf2_ds.txt $SERVER/tf2_ds.txt
ADD ./update.sh $SERVER/update.sh
ADD ./tf.sh $SERVER/tf.sh
RUN $SERVER/update.sh

EXPOSE 27015/udp

WORKDIR /home/$USER/hlserver
ENTRYPOINT ["./tf.sh"]
CMD ["+sv_pure", "1", "+mapcycle", "mapcycle_quickplay_payload.txt", "+map", "pl_badwater", "+maxplayers", "24"]
