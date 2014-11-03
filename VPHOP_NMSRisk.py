import os
import emissary
import soaplib
from soaplib.core.service import soap, rpc, DefinitionBase
from soaplib.core.model.primitive import String, Integer
from soaplib.core.model.clazz import ClassModel
from soaplib.core.server import wsgi
from time import strftime

CMD_STR = "octave calcolo_rischio_generico.m {input_file} {output_file_1} {output_file_2}"

class RegisterResponse(ClassModel):
    """Response object holds the commandline execution response"""
    statuscode = Integer
    command = String
    stdout = String
    stderr = String
    cwd = String

    output_file_1 = String
    output_file_2 = String

    def __init__(self, command=None):
        self.command = command
        self.cwd = '.'
        self.statuscode = 0
        self.stdout = ""
        self.stderr = "Error: I'm sorry I cannot do that!"

def create_response(out):
    if out:
        r = RegisterResponse(' '.join(out.command))
        r.statuscode = out.status_code
        r.stdout = out.std_out
        r.stderr = out.std_err
    return r

class VPHOP_NMSRisk(DefinitionBase):
    @soap(String, String, _returns=RegisterResponse)
    def register(self, input_file, output_path):
        output_file_1 = os.path.join(output_path, strftime("VPHOP_NMSRisk_RF_%d_%m_%Y__%H_%M_%S")+'.txt')
        output_file_2 = os.path.join(output_path, strftime("VPHOP_NMSRisk_total_output_%d_%m_%Y__%H_%M_%S")+'.txt')
        command = CMD_STR.format(input_file=input_file, output_file_1=output_file_1, output_file_2=output_file_2)
        try:
            out = emissary.envoy.run(command)
            r = create_response(out)
            r.output_file_1 = output_file_1
            r.output_file_2 = output_file_2
            return r
        except OSError, e:
            pass
            r = RegisterResponse(command)
            r.statuscode = e.errno
            return e.strerror
        return r

soap_app = soaplib.core.Application([VPHOP_NMSRisk], 'vphop_nmsrisk', name='VPHOP_NMSRisk')
application = wsgi.Application(soap_app)

if __name__=='__main__':
    try:
        from wsgiref.simple_server import make_server
        server = make_server(host='0.0.0.0', port=8081, app=application)
        server.serve_forever()
    except ImportError:
        print "Error: example server code requires Python >= 2.5"
