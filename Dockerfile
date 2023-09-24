FROM curlimages/curl

RUN curl echo-server-1:80 && echo
RUN curl echo-server-2:80 && echo
RUN curl echo-server-3:80 && echo
