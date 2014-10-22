# -*- coding: utf-8 -*-

"""
emissary.core
~~~~~~~~~~

This module provides core emissary functionality.
"""

import tempfile
import envoy


__version__ = '0.0.1'
__license__ = 'MIT'
__author__ = 'Susheel Varma'

TMPDIR = tempfile.gettempdir()

# try:
#     import wsme
#     class Response(wsme.types.UserType):
#         """Response object holds the commandline execution response"""
#         statuscode = int
#         command = unicode
#         stdout = unicode
#         stderr = unicode
#         cwd = unicode

#         def __init__(self, command=None):
#             super(Response, self).__init__()
#             self.command = command
#             self.cwd = '.'
#             self.statuscode = 0
#             self.stdout = ""
#             self.stderr = "Error: I'm sorry I cannot do that, Dave!"
# except ImportError:
#     try:
import soaplib
from soaplib.core.model.clazz import ClassModel
from soaplib.core.model.primitive import String, Integer

class Response(soaplib.core.model.clazz.ClassModel):
    """Response object holds the commandline execution response"""
    statuscode = Integer
    command = String
    stdout = String
    stderr = String
    cwd = String

    def __init__(self, command=None):
        super(Response, self).__init__()
        self.command = command
        self.cwd = '.'
        self.statuscode = 0
        self.stdout = ""
        self.stderr = "Error: I'm sorry I cannot do that, Dave!"

def create_response(out, klass=Response):
    if out and issubclass(klass, Response):
        r = klass(' '.join(out.command))
        r.statuscode = out.status_code
        r.stdout = out.std_out
        r.stderr = out.std_err
    return r


def run(command, data=None, timeout=None, kill_timeout=None, env=None, cwd=None):
    try:
        out = envoy.run(command, data, timeout, kill_timeout, env, cwd)
        r = create_response(out)
    except OSError, e:
        r = Response(command)
        r.statuscode = e.errno
        r.stderr = e.strerror
    return r
