#BEGIN_HEADER
#END_HEADER


class variation:
    '''
    Module Name:
    variation

    Module Description:
    A KBase module: variation
    '''

    ######## WARNING FOR GEVENT USERS #######
    # Since asynchronous IO can lead to methods - even the same method -
    # interrupting each other, you must be *very* careful when using global
    # state. A method could easily clobber the state set by another while
    # the latter method is running.
    #########################################
    #BEGIN_CLASS_HEADER
    #END_CLASS_HEADER

    # config contains contents of config file in a hash or None if it couldn't
    # be found
    def __init__(self, config):
        #BEGIN_CONSTRUCTOR
        #END_CONSTRUCTOR
        pass

    def variation_example_method(self, ctx, input):
        # ctx is the context object
        # return variables are: output
        #BEGIN variation_example_method
        #END variation_example_method

        # At some point might do deeper type checking...
        if not isinstance(output, basestring):
            raise ValueError('Method variation_example_method return value ' +
                             'output is not type basestring as required.')
        # return the results
        return [output]
