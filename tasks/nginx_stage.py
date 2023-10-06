#!/usr/bin/env python

import json
import os
import shlex
import subprocess
import sys

result = {}
try:
    params = json.load(sys.stdin)
    command = params['command']
    user = params.get('user', None)
    skip_nginx = params.get('skip_nginx', False)
    force = params.get('force', False)
    cmd = [
        '/opt/ood/nginx_stage/sbin/nginx_stage', command
    ]
    if command == 'nginx_clean' and user:
        cmd.append('--user')
        cmd.append(user)
    if command == 'nginx_clean' and skip_nginx:
        cmd.append('--skip-nginx')
    if command == 'nginx_clean' and force:
        cmd.append('--force')
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = process.communicate()
    try:
        out = out.decode()
    except (UnicodeDecodeError, AttributeError):
        pass
    try:
        err = err.decode()
    except (UnicodeDecodeError, AttributeError):
        pass
    exitcode = process.returncode
    if exitcode == 0:
        if command in ['nginx_clean','nginx_list']:
            result['puns'] = out.splitlines()
    else:
        result['err'] = err
        result['out'] = out
except Exception as e:
    exitcode = 1
    result['_error'] = {
        'msg': str(e),
        'kind': 'exception',
        'details': {}
    }

json.dump(result, sys.stdout)
sys.exit(exitcode)
