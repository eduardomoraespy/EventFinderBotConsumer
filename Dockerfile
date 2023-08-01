# Definindo a imagem base
FROM python:3.9


COPY . /EventFinderBotConsumer
WORKDIR /EventFinderBotConsumer


RUN apt-get update && apt-get install -y wget gnupg
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -y google-chrome-stable

RUN update-alternatives --set x-www-browser /usr/bin/google-chrome-stable
RUN update-alternatives --set gnome-www-browser /usr/bin/google-chrome-stable

RUN pip install -r requirements.txt

ENV ROBOT_PYTHON_EXECUTABLE=/usr/local/bin/python
ENV ROBOT_EXECUTABLE=/usr/local/bin/robot

CMD ["robot", "consumer.robot"]
