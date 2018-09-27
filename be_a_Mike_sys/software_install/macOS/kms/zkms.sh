#!/bin/bash

export GST_DEBUG='3,Kurento*:4,kms*:5,rtpendpoint:4,webrtcendpoint:4,KurentoRecorderEndpointImpl:5,\
KmsRecorderEndpoint:5,RecorderEndpointImpl:5'
export GST_DEBUG_DUMP_DOT_DIR="/shared/graph"
kurento-media-server/server/kurento-media-server --modules-path=. \
  --modules-config-path=./config --conf-file=./config/kurento.conf.json --gst-plugin-path=.
