
FROM ltntstools-builder

RUN mkdir /src
RUN cd /src && git clone https://github.com/LTNGlobal-opensource/ltntstools-build-environment.git
WORKDIR /src

ENV SHELL /bin/bash

CMD [ "/bin/bash" ]
