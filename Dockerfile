FROM python:3.6-slim-stretch

RUN apt update
RUN apt install -y python3-dev gcc

# Install pytorch and fastai
RUN pip install torch_nightly -f https://download.pytorch.org/whl/nightly/cpu/torch_nightly.html
RUN pip install fastai

# Install starlette and uvicorn
RUN pip install starlette uvicorn python-multipart aiohttp

ADD bear.py bear.py
ADD export.pkl export.pkl

# Run it once to trigger resnet download
RUN python bear.py

EXPOSE 8008

# Start the server
CMD ["python", "cougar.py", "serve"]
