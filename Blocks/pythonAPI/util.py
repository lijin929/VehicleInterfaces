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

def get_solutions(mod,modelName, name, size):
    '''
    get modelica model solutions results
    :param mod: modelica model
    :param modelName: model part name
    :param name: parameter name
    :param size: output size, [rows, columns]
    :return:
    '''
    output = np.zeros(size)
    if len(size) == 1:
        for i in range(size[0]):
            output[i] = mod.getSolutions("%s.%s[%s]" % (modelName, name, i+1))[0, 0]
    if len(size) == 2:
        for i in range(size[0]):
            for j in range(size[1]):
                output[i, j] = mod.getSolutions("%s.%s[%s,%s]" % (modelName, name, i+1, j+1))[0, 0]
    return output

def get_solutions_TCmatching(mod, name, rows):
    '''
    get TCmatching model solutions results
    :param mod: modelica model
    :param name: model part name
    :param rows: TC lambdaTable rows
    :return:
    '''
    columns = int(mod.getParameters(name + '.columns')[0])
    return {"npCowork": get_solutions(mod, name, 'npCowork', [rows]),
            "TpCowork": get_solutions(mod, name, 'TpCowork', [rows]),
            "Tp": get_solutions(mod, name, 'Tp', [rows, columns]),
            "no": get_solutions(mod, name, 'no', [rows]),
            "To": get_solutions(mod, name, 'To', [rows]),
            "Po": get_solutions(mod, name, 'Po', [rows]),
            "powerLoss": get_solutions(mod, name, 'powerLoss', [rows])}


def get_solutions_gearboxMatchingSIMO(mod, name, rows):
    '''
    get gearboxMatchingSIMO model solutions results
    :param mod: modelica model
    :param name: model part name
    :param rows: gearboxTable rows
    :return:
    '''
    columns = int(mod.getParameters(name + '.columns')[0])
    return {"no": get_solutions(mod, name, 'no', [rows, columns]),
            "To": get_solutions(mod, name, 'To', [rows, columns]),
            "Po": get_solutions(mod, name, 'Po', [rows, columns]),
            "powerLoss": get_solutions(mod, name, 'powerLoss', [rows, columns])}



def get_solutions_gearboxMatchingMIMO(mod, name):
    '''
    get gearboxMatchingMIMO model solutions results
    :param mod: modelica model
    :param name: model part name
    :return:
    '''
    size = [int(mod.getParameters(name + '.rows')[0]),
            int(mod.getParameters(name + '.columns')[0])]
    return {"no": get_solutions(mod, name, 'no', size),
            "To": get_solutions(mod, name, 'To', size),
            "Po": get_solutions(mod, name, 'Po', size),
            "powerLoss": get_solutions(mod, name, 'powerLoss', size)}


def get_solutions_chassis(mod, name):
    '''
    get chassis model solutions results
    :param mod: modelica model
    :param name: model part name
    :return:
    '''
    size = [int(mod.getParameters(name + '.rows')[0]),
            int(mod.getParameters(name + '.columns')[0])]
    return {"velocity": get_solutions(mod, name, 'velocity', size),
            "drivingForce": get_solutions(mod, name, 'drivingForce', size)}


def get_solutions_throustCharacteristics(mod, name):
    '''
    get throustCharacteristics model solutions results
    :param mod: modelica model
    :param name: model part name
    :return:
    '''
    size = [int(mod.getParameters(name + '.rows')[0]),
            int(mod.getParameters(name + '.columns')[0])]
    return {"velocity1": get_solutions(mod, name, 'velocity1', size),
            "dynamicFactor": get_solutions(mod, name, 'dynamicFactor', size)}

def get_solutions_throustResultWithTC(mod, name):
    '''
    get throustResultWithTC model solutions results
    :param mod: modelica model
    :param name: model part name
    :return:
    '''
    size = [int(mod.getParameters(name + '.sizeMT[1]')[0]),
            int(mod.getParameters(name + '.sizeMT[2]')[0])]
    return {"velocityOut": get_solutions(mod, name, 'velocityOut', size),
            "dynamicFactorOut": get_solutions(mod, name, 'dynamicFactorOut', size)}


def get_solutions_throustResultIntersectionForAcc(mod, name):
    '''
    get throustResultIntersectionForAcc model solutions results
    :param mod: modelica model
    :param name: model part name
    :return:
    '''
    size = [int(mod.getParameters(name + '.rows')[0]),
            int(mod.getParameters(name + '.columns')[0])]
    return {"velocityOut": get_solutions(mod, name, 'velocityOut', size),
            "dynamicFactorOut": get_solutions(mod, name, 'dynamicFactorOut', size)}


def get_solutions_accelerationCharacteristics(mod, name):
    '''
    get accelerationCharacteristics model solutions results
    :param mod: modelica model
    :param name: model part name
    :return:
    '''
    size = [int(mod.getParameters(name + '.rows')[0]),
            int(mod.getParameters(name + '.columns')[0])]
    return {"t": get_solutions(mod, name, 't', size),
            "v": get_solutions(mod, name, 'v', size),
            "s": get_solutions(mod, name, 's', size)}



