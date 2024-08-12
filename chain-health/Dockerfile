FROM paritytech/ws-health-exporter
USER root

RUN apt update
RUN apt install -y curl

USER nobody:nogroup

EXPOSE 8001
CMD ["python", "./exporter.py"]