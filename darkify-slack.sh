#!/bin/bash

SLACK_PATH='/usr/lib/slack'
CSS_URL='https://raw.githubusercontent.com/laCour/slack-night-mode/master/css/raw/variants/black-monospaced.css'

sudo bash -c "cat >> \"${SLACK_PATH}\"/resources/app.asar.unpacked/src/static/ssb-interop.js" << EOF
document.addEventListener('DOMContentLoaded', function() {
 $.ajax({
   url: '${CSS_URL}',
   success: function(css) {
     overrides = \`
        .p-threads_view {
            background: #222;
        }
        .p-threads_view__divider_line {
            border-color: #111;
        }
        .p-threads_view__divider_label {
            background: #111;
        }
        .p-threads_view_header__channel_name {
            color: #c7c7c7;
        }
        .p-threads_view_root {
            border-color: #444;
        }
        .p-threads_view_reply {
            border-color: #444;
        }
        .p_threads_view_load_newer_button,
        .p_threads_view_load_older_button {
            background: rgba(255, 255, 255, 0.05);
            border-color: #444;
        }
        .p-threads_view__footer {
            border-color: #444;
        }
        .p-threads_view__default_background {
            background: rgba(255, 255, 255, 0.05);
        }
    \`
    \$("<style></style>").appendTo('head').html(css + overrides);
   }
 });
});
EOF
