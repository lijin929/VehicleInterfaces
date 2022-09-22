import numpy as np


def set_parameter(mod, name, parameters):
    '''
    set modelica model parameters
    :param mod: modelica model
    :param name: parameter name
    :param parameters: parameter array
    :return:
    '''
    if len(np.shape(parameters)) == 1:
        for i in range(len(parameters)):
            mod.setParameters("%s[%s]=%s" % (name, i+1, parameters[i]))
    if len(np.shape(parameters)) == 2:
        for i in range(len(parameters)):
            for j in range(len(parameters[0])):
                mod.setParameters("%s[%s,%s]=%s" % (name, i+1, j+1, parameters[i, j]))

