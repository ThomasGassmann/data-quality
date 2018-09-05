from datetime import datetime
from scripts.init.indicator import Indicator
from scripts.init import utils
import time
import unittest


class TestIndicator(unittest.TestCase):
    @classmethod
    def setUpClass(self):
        pass

    @staticmethod
    def get_test_case_name():
        """Generate unique name for unit test case."""
        time.sleep(1)
        test_case_name = 'test {}'.format(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        return test_case_name

    def test_verify_indicator_parameters_completeness(self):
        # Create test indicator group
        test_case_name = TestIndicator.get_test_case_name()
        mutation_create_indicator_group = '''mutation{createIndicatorGroup(input:{indicatorGroup:{name:"test_case_name"}}){indicatorGroup{id}}}'''
        mutation_create_indicator_group = mutation_create_indicator_group.replace('test_case_name', str(test_case_name))  # Use replace() instead of format() because of curly braces
        indicator_group = utils.execute_graphql_request(mutation_create_indicator_group)
        indicator_group_id = indicator_group['data']['createIndicatorGroup']['indicatorGroup']['id']

        # Create test indicator
        indicator_type_id = 1  # Completeness
        mutation_create_indicator = '''mutation{createIndicator(input:{indicator:{name:"test_case_name",flagActive:true,indicatorTypeId:indicator_type_id,indicatorGroupId:indicator_group_id}}){indicator{id}}}'''
        mutation_create_indicator = mutation_create_indicator.replace('indicator_type_id', str(indicator_type_id))  # Use replace() instead of format() because of curly braces
        mutation_create_indicator = mutation_create_indicator.replace('test_case_name', str(test_case_name))  # Use replace() instead of format() because of curly braces
        mutation_create_indicator = mutation_create_indicator.replace('indicator_group_id', str(indicator_group_id))  # Use replace() instead of format() because of curly braces
        indicator = utils.execute_graphql_request(mutation_create_indicator)
        indicator_id = indicator['data']['createIndicator']['indicator']['id']

        # Create test indicator parameters
        default_parameters = {
            1: "==",  # Alert operator
            2: "0",  # Alert threshold
            3: "['email_1', 'email_2', 'email_3']",  # Distribution list
            4: "['dimension_1', 'dimension_2', 'dimension_3']",  # Dimension
            5: "['measure_1', 'measure_2', 'measure_3']",  # Measures
            6: "Source",  # Source
            7: "Source request",  # Source request
            8: "Target",  # Target
            9: "Target request"  # Target request
            }

        for param_key, param_value in default_parameters.items():
            mutation_create_parameter = '''mutation{createParameter(input:{parameter:{parameterTypeId:param_key,value:"param_value",indicatorId:indicator_id}}){parameter{id}}}'''
            mutation_create_parameter = mutation_create_parameter.replace('param_key', str(param_key))  # Use replace() instead of format() because of curly braces
            mutation_create_parameter = mutation_create_parameter.replace('param_value', str(param_value))  # Use replace() instead of format() because of curly braces
            mutation_create_parameter = mutation_create_parameter.replace('indicator_id', str(indicator_id))  # Use replace() instead of format() because of curly braces
            utils.execute_graphql_request(mutation_create_parameter)

        # Get list of parameters
        query_get_parameters = '''query{indicatorById(id:indicator_id){parametersByIndicatorId{nodes{parameterTypeId,value}}}}'''
        query_get_parameters = query_get_parameters.replace('indicator_id', str(indicator_id))  # Use replace() instead of format() because of curly braces
        parameters = utils.execute_graphql_request(query_get_parameters)
        parameters = parameters['data']['indicatorById']['parametersByIndicatorId']['nodes']

        indicator = Indicator()
        verified_parameters = indicator.verify_indicator_parameters(indicator_type_id, parameters)

        # Assert list of parameters is correct
        self.assertEqual(len(verified_parameters), 9)
        self.assertEqual(len(verified_parameters[3]), 3)
        self.assertEqual(len(verified_parameters[4]), 3)
        self.assertEqual(len(verified_parameters[5]), 3)


    def test_verify_indicator_parameters_freshness(self):
        # Create test indicator group
        test_case_name = TestIndicator.get_test_case_name()
        mutation_create_indicator_group = '''mutation{createIndicatorGroup(input:{indicatorGroup:{name:"test_case_name"}}){indicatorGroup{id}}}'''
        mutation_create_indicator_group = mutation_create_indicator_group.replace('test_case_name', str(test_case_name))  # Use replace() instead of format() because of curly braces
        indicator_group = utils.execute_graphql_request(mutation_create_indicator_group)
        indicator_group_id = indicator_group['data']['createIndicatorGroup']['indicatorGroup']['id']

        # Create test indicator
        indicator_type_id = 2  # Freshness
        mutation_create_indicator = '''mutation{createIndicator(input:{indicator:{name:"test_case_name",flagActive:true,indicatorTypeId:indicator_type_id,indicatorGroupId:indicator_group_id}}){indicator{id}}}'''
        mutation_create_indicator = mutation_create_indicator.replace('indicator_type_id', str(indicator_type_id))  # Use replace() instead of format() because of curly braces
        mutation_create_indicator = mutation_create_indicator.replace('test_case_name', str(test_case_name))  # Use replace() instead of format() because of curly braces
        mutation_create_indicator = mutation_create_indicator.replace('indicator_group_id', str(indicator_group_id))  # Use replace() instead of format() because of curly braces
        indicator = utils.execute_graphql_request(mutation_create_indicator)
        indicator_id = indicator['data']['createIndicator']['indicator']['id']

        # Create test indicator parameters
        default_parameters = {
            1: "==",  # Alert operator
            2: "0",  # Alert threshold
            3: "['email_1', 'email_2', 'email_3']",  # Distribution list
            4: "['dimension_1', 'dimension_2', 'dimension_3']",  # Dimension
            5: "['measure_1', 'measure_2', 'measure_3']",  # Measures
            8: "Target",  # Target
            9: "Target request"  # Target request
            }

        for param_key, param_value in default_parameters.items():
            mutation_create_parameter = '''mutation{createParameter(input:{parameter:{parameterTypeId:param_key,value:"param_value",indicatorId:indicator_id}}){parameter{id}}}'''
            mutation_create_parameter = mutation_create_parameter.replace('param_key', str(param_key))  # Use replace() instead of format() because of curly braces
            mutation_create_parameter = mutation_create_parameter.replace('param_value', str(param_value))  # Use replace() instead of format() because of curly braces
            mutation_create_parameter = mutation_create_parameter.replace('indicator_id', str(indicator_id))  # Use replace() instead of format() because of curly braces
            utils.execute_graphql_request(mutation_create_parameter)

        # Get list of parameters
        query_get_parameters = '''query{indicatorById(id:indicator_id){parametersByIndicatorId{nodes{parameterTypeId,value}}}}'''
        query_get_parameters = query_get_parameters.replace('indicator_id', str(indicator_id))  # Use replace() instead of format() because of curly braces
        parameters = utils.execute_graphql_request(query_get_parameters)
        parameters = parameters['data']['indicatorById']['parametersByIndicatorId']['nodes']

        indicator = Indicator()
        verified_parameters = indicator.verify_indicator_parameters(indicator_type_id, parameters)

        # Assert list of parameters is correct
        self.assertEqual(len(verified_parameters), 7)
        self.assertEqual(len(verified_parameters[3]), 3)
        self.assertEqual(len(verified_parameters[4]), 3)
        self.assertEqual(len(verified_parameters[5]), 3)

    def test_verify_indicator_parameters_latency(self):
        # Create test indicator group
        test_case_name = TestIndicator.get_test_case_name()
        mutation_create_indicator_group = '''mutation{createIndicatorGroup(input:{indicatorGroup:{name:"test_case_name"}}){indicatorGroup{id}}}'''
        mutation_create_indicator_group = mutation_create_indicator_group.replace('test_case_name', str(test_case_name))  # Use replace() instead of format() because of curly braces
        indicator_group = utils.execute_graphql_request(mutation_create_indicator_group)
        indicator_group_id = indicator_group['data']['createIndicatorGroup']['indicatorGroup']['id']

        # Create test indicator
        indicator_type_id = 3  # Latency
        mutation_create_indicator = '''mutation{createIndicator(input:{indicator:{name:"test_case_name",flagActive:true,indicatorTypeId:indicator_type_id,indicatorGroupId:indicator_group_id}}){indicator{id}}}'''
        mutation_create_indicator = mutation_create_indicator.replace('indicator_type_id', str(indicator_type_id))  # Use replace() instead of format() because of curly braces
        mutation_create_indicator = mutation_create_indicator.replace('test_case_name', str(test_case_name))  # Use replace() instead of format() because of curly braces
        mutation_create_indicator = mutation_create_indicator.replace('indicator_group_id', str(indicator_group_id))  # Use replace() instead of format() because of curly braces
        indicator = utils.execute_graphql_request(mutation_create_indicator)
        indicator_id = indicator['data']['createIndicator']['indicator']['id']

        # Create test indicator parameters
        default_parameters = {
            1: "==",  # Alert operator
            2: "0",  # Alert threshold
            3: "['email_1', 'email_2', 'email_3']",  # Distribution list
            4: "['dimension_1', 'dimension_2', 'dimension_3']",  # Dimension
            5: "['measure_1', 'measure_2', 'measure_3']",  # Measures
            6: "Source",  # Source
            7: "Source request",  # Source request
            8: "Target",  # Target
            9: "Target request"  # Target request
            }

        for param_key, param_value in default_parameters.items():
            mutation_create_parameter = '''mutation{createParameter(input:{parameter:{parameterTypeId:param_key,value:"param_value",indicatorId:indicator_id}}){parameter{id}}}'''
            mutation_create_parameter = mutation_create_parameter.replace('param_key', str(param_key))  # Use replace() instead of format() because of curly braces
            mutation_create_parameter = mutation_create_parameter.replace('param_value', str(param_value))  # Use replace() instead of format() because of curly braces
            mutation_create_parameter = mutation_create_parameter.replace('indicator_id', str(indicator_id))  # Use replace() instead of format() because of curly braces
            utils.execute_graphql_request(mutation_create_parameter)

        # Get list of parameters
        query_get_parameters = '''query{indicatorById(id:indicator_id){parametersByIndicatorId{nodes{parameterTypeId,value}}}}'''
        query_get_parameters = query_get_parameters.replace('indicator_id', str(indicator_id))  # Use replace() instead of format() because of curly braces
        parameters = utils.execute_graphql_request(query_get_parameters)
        parameters = parameters['data']['indicatorById']['parametersByIndicatorId']['nodes']

        indicator = Indicator()
        verified_parameters = indicator.verify_indicator_parameters(indicator_type_id, parameters)

        # Assert list of parameters is correct
        self.assertEqual(len(verified_parameters), 9)
        self.assertEqual(len(verified_parameters[3]), 3)
        self.assertEqual(len(verified_parameters[4]), 3)
        self.assertEqual(len(verified_parameters[5]), 3)

    def test_verify_indicator_parameters_validity(self):
        # Create test indicator group
        test_case_name = TestIndicator.get_test_case_name()
        mutation_create_indicator_group = '''mutation{createIndicatorGroup(input:{indicatorGroup:{name:"test_case_name"}}){indicatorGroup{id}}}'''
        mutation_create_indicator_group = mutation_create_indicator_group.replace('test_case_name', str(test_case_name))  # Use replace() instead of format() because of curly braces
        indicator_group = utils.execute_graphql_request(mutation_create_indicator_group)
        indicator_group_id = indicator_group['data']['createIndicatorGroup']['indicatorGroup']['id']

        # Create test indicator
        indicator_type_id = 4  # Validity
        mutation_create_indicator = '''mutation{createIndicator(input:{indicator:{name:"test_case_name",flagActive:true,indicatorTypeId:indicator_type_id,indicatorGroupId:indicator_group_id}}){indicator{id}}}'''
        mutation_create_indicator = mutation_create_indicator.replace('indicator_type_id', str(indicator_type_id))  # Use replace() instead of format() because of curly braces
        mutation_create_indicator = mutation_create_indicator.replace('test_case_name', str(test_case_name))  # Use replace() instead of format() because of curly braces
        mutation_create_indicator = mutation_create_indicator.replace('indicator_group_id', str(indicator_group_id))  # Use replace() instead of format() because of curly braces
        indicator = utils.execute_graphql_request(mutation_create_indicator)
        indicator_id = indicator['data']['createIndicator']['indicator']['id']

        # Create test indicator parameters
        default_parameters = {
            1: "==",  # Alert operator
            2: "0",  # Alert threshold
            3: "['email_1', 'email_2', 'email_3']",  # Distribution list
            4: "['dimension_1', 'dimension_2', 'dimension_3']",  # Dimension
            5: "['measure_1', 'measure_2', 'measure_3']",  # Measures
            8: "Target",  # Target
            9: "Target request"  # Target request
            }

        for param_key, param_value in default_parameters.items():
            mutation_create_parameter = '''mutation{createParameter(input:{parameter:{parameterTypeId:param_key,value:"param_value",indicatorId:indicator_id}}){parameter{id}}}'''
            mutation_create_parameter = mutation_create_parameter.replace('param_key', str(param_key))  # Use replace() instead of format() because of curly braces
            mutation_create_parameter = mutation_create_parameter.replace('param_value', str(param_value))  # Use replace() instead of format() because of curly braces
            mutation_create_parameter = mutation_create_parameter.replace('indicator_id', str(indicator_id))  # Use replace() instead of format() because of curly braces
            utils.execute_graphql_request(mutation_create_parameter)

        # Get list of parameters
        query_get_parameters = '''query{indicatorById(id:indicator_id){parametersByIndicatorId{nodes{parameterTypeId,value}}}}'''
        query_get_parameters = query_get_parameters.replace('indicator_id', str(indicator_id))  # Use replace() instead of format() because of curly braces
        parameters = utils.execute_graphql_request(query_get_parameters)
        parameters = parameters['data']['indicatorById']['parametersByIndicatorId']['nodes']

        indicator = Indicator()
        verified_parameters = indicator.verify_indicator_parameters(indicator_type_id, parameters)

        # Assert list of parameters is correct
        self.assertEqual(len(verified_parameters), 7)
        self.assertEqual(len(verified_parameters[3]), 3)
        self.assertEqual(len(verified_parameters[4]), 3)
        self.assertEqual(len(verified_parameters[5]), 3)

    def test_is_alert(self):
        indicator = Indicator()

        equal = indicator.is_alert(0, '==', 0)
        self.assertTrue(equal)

        greater = indicator.is_alert(1, '>', 0)
        self.assertTrue(greater)

        greater_equal = indicator.is_alert(1, '>=', 0)
        self.assertTrue(greater_equal)

        smaller = indicator.is_alert(0, '<', 1)
        self.assertTrue(smaller)

        smaller_equal = indicator.is_alert(0, '<=', 1)
        self.assertTrue(smaller_equal)

        different = indicator.is_alert(1, '!=', 2)
        self.assertTrue(different)

    @classmethod
    def tearDownClass(self):
        pass


if __name__ == '__main__':
    unittest.main()
