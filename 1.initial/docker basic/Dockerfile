FROM python:3.9

RUN pip install pandas

WORKDIR /app

COPY simple-pipeline.py /app

ENTRYPOINT [ "python", "simple-pipeline.py" ]