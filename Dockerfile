# Dockerfile for ardupilot on Alpine Linux with MAVSim (http://mavsim.info)
#
# This is for ArduPlane (fixed-wing aircraft using JSBSim)
#
# Designed for Research & Development on the ArduPilot SITL simulation
#
# Copyright (C)2017 PARC, a Xerox company
# Licensed under GPL, Version 3
#
FROM gmyoungbloodparc/ardupilot-sitl:latest
MAINTAINER Michael Youngblood <Michael.Youngblood@parc.com>
#
# 
#########################################################################################

ENV INSTANCE mavsim
ENV SESSION jeff

EXPOSE 22
EXPOSE 10000-10001
EXPOSE 14550-14559

RUN apk update && apk add --no-cache \
  openssl \
  openssh \
  py-psycopg2 \
  py-yaml \
  bash \
  vim

RUN pip install sqlalchemy \
  geopy

ADD mavsim_run.sh /
RUN chmod +x /mavsim_run.sh

# Get MAVSim from public repository
WORKDIR "/"
RUN git clone https://gitlab.com/gmyoungblood-parc/mavsim-public.git
RUN mv /mavsim-public /mavsim

# Execution Setup for sim_vehicle autorun
ENV ENV="/etc/profile"
ENV SIM_OPTIONS "--out=udpout:docker.for.mac.localhost:14559 --out=udpout:0.0.0.0:14553"
ENV SPEEDUP 1
ENV LOGGING_DATABASE "postgresql://postgres:123456@docker.for.mac.localhost:33121/apm_missions"
ENV MAVSIM_OPTIONS ""

# WORKDIR "/mavsim"
ENTRYPOINT ["/mavsim_run.sh"]

# fin.
