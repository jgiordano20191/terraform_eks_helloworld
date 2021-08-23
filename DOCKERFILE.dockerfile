FROM python:3

WORKDIR /opt/hello_world #location of python application

COPY requirements.txt ./   #install software requirements
RUN pip install --no-cache-dir -r requirements.txt

ENV FLASK_APP=hello_world.py   #configure
COPY hello_world.py .          #copy

EXPOSE 5000         #flask port

CMD [ "flask", "run", "-h", "0.0.0.0" ]     #execution command