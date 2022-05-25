import pandas
import pyomo
import pyomo.opt
import pyomo.environ as pe
import logging
import sys

from ShortesPathClass.ClassDefintion import SPInterdiction


if __name__ == '__main__':

    #Obtain the scenario/instance to be solved (being passed by the master script on solstorm)
    scenario = str(sys.argv[1])    
    
    #Then, set up the model (based on the scenario) and solve it 
    print('-------------Scenario ' + scenario + '---------------')
    
    general_data_file = 'sample_nodes_data.csv'
    scenario_specific_data_file = scenario+'.csv' 

    m = SPInterdiction(general_data_file, scenario_specific_data_file)
    m.solve()
    m.printSolution()
    
    print('---------------------------------------------------')
    print()

    # Note that the print output (logger) is saved in a file called 'results_'+scenario+'.txt'
    # The user can also decide to manually save data 