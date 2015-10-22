FROM kbase/depl:latest
MAINTAINER KBase Developer
# Install the SDK (should go away eventually)
RUN \
  apt-get update && apt-get install -y ant && \
  cd /kb/dev_container/modules && \
  git clone https://github.com/kbase/kb_sdk -b develop && \
  cd /kb/dev_container/modules/kb_sdk && \
  make

# -----------------------------------------

# Insert apt-get instructions here to install
# any required dependencies for your module.

# -----------------------------------------

COPY ./ /kb/module
RUN mkdir -p /kb/module/work
ENV PATH=$PATH:/kb/dev_container/modules/kb_sdk/bin

WORKDIR /kb/module

RUN make

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]