from OMPython import ModelicaSystem


def print_hi(name):
    pass

# 按间距中的绿色按钮以运行脚本。
if __name__ == '__main__':
    # VehicleInterfaces模型库的路径
    LibPath = "D:/Program Files/OpenModelica1.16.2-64bit/lib/omlibrary/VehicleInterfaces 2.0.0/package.mo"
    modelName = "VehicleInterfaces.Task.TCmatching"
    # 加载VehicleInterfaces模型库，并选择导入的model
    mod = ModelicaSystem(fileName=LibPath,
                         modelName=modelName)
    # BuildModel
    mod.buildModel()
    '''
    获取参数
    getQuantities()
    getContinuous()
    getInputs()
    getOutputs()
    getParameters()
    getSimulationOptions()
    getSolutions()
    '''
    quantities = mod.getQuantities()
    parameters = mod.getParameters()
    continuous = mod.getContinuous()
    # inputs = mod.getInputs()
    # 设置参数
    # mod.setParameters("L.L=100")
    # mod.setContinuous()
    # 仿真求解设置
    # mod.setSimulationOptions(["stopTime=1", "stepSize=10"])
    # 开始计算
    mod.simulate()

    np = mod.getSolutions()
