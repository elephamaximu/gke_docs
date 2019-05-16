FROM gcr.io/google_appengine/python

RUN virtualenv -p python3 /env
ENV PATH /env/bin:$PATH

ADD requirements.txt /app/requirements.txt
RUN /env/bin/pip install --upgrade pip && /env/bin/pip install -r /app/requirements.txt
# RUN /env/bin/python3 aa.py
ADD . /app

CMD gunicorn -b :$PORT ttsProject.wsgi --timeout=300
