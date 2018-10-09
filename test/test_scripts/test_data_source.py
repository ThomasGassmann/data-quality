"""Unit tests for module /scripts/init/data_source.py."""
from datetime import datetime
from scripts.data_source import DataSource
from scripts.constants import DataSourceType
import time
import unittest


class TestDataSource(unittest.TestCase):
    """Unit tests for class DataSource."""

    @classmethod
    def setUpClass(self):
        """Execute this before the tests."""
        pass

    @staticmethod
    def get_test_case_name():
        """Generate unique name for unit test case."""

        time.sleep(1)
        test_case_name = 'test {}'.format(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        return test_case_name

    def test_get_connection_mariadb(self):
        """Unit tests for method get_connection for MariaDB database."""

        # Set connection parameters
        data_source_type_id = DataSourceType.MARIADB_ID
        connection_string = 'driver={MariaDB Unicode};server=db-mariadb;port=3306;Database=star_wars;'
        login = 'root'
        password = '1234'

        # Connect to test Database
        data_source = DataSource()
        connection = data_source.get_connection(data_source_type_id, connection_string, login, password)
        cursor = connection.cursor()
        result = cursor.execute("SELECT name FROM star_wars.planet WHERE name='Tatooine';").fetchone()
        result = result[0]
        cursor.close()
        connection.close()

        # Assert query result
        self.assertEqual(result, 'Tatooine')

    def test_get_connection_sql_server(self):
        """Unit tests for method get_connection for Microsoft SQL Server database."""

        # Set connection parameters
        data_source_type_id = DataSourceType.MSSQL_ID
        connection_string = 'driver={FreeTDS};server=db-sql-server;port=1433;Database=star_wars;tds_version=8.0;'
        login = 'sa'
        password = '1234-abcd'

        # Connect to test Database
        data_source = DataSource()
        connection = data_source.get_connection(data_source_type_id, connection_string, login, password)
        cursor = connection.cursor()
        result = cursor.execute("SELECT name FROM star_wars.dbo.planet WHERE name='Tatooine';").fetchone()
        result = result[0]
        cursor.close()
        connection.close()

        # Assert query result
        self.assertEqual(result, 'Tatooine')

    def test_get_connection_mysql(self):
        """Unit tests for method get_connection for MySQL database."""

        # Set connection parameters
        data_source_type_id = DataSourceType.MYSQL_ID
        connection_string = 'driver={MySQL Unicode};server=db-mysql;port=3306;Database=star_wars;'
        login = 'root'
        password = '1234'

        # Connect to test Database
        data_source = DataSource()
        connection = data_source.get_connection(data_source_type_id, connection_string, login, password)
        cursor = connection.cursor()
        result = cursor.execute("SELECT name FROM star_wars.planet WHERE name='Tatooine';").fetchone()
        result = result[0]
        cursor.close()
        connection.close()

        # Assert query result
        self.assertEqual(result, 'Tatooine')

    def test_get_connection_postgresql(self):
        """Unit tests for method get_connection for PostgreSQL database."""

        # Set connection parameters
        data_source_type_id = DataSourceType.POSTGRESQL_ID
        connection_string = 'driver={PostgreSQL Unicode};server=db-postgresql;port=5432;Database=star_wars;'
        login = 'postgres'
        password = '1234'

        # Connect to test Database
        data_source = DataSource()
        connection = data_source.get_connection(data_source_type_id, connection_string, login, password)
        cursor = connection.cursor()
        result = cursor.execute("SELECT name FROM public.planet WHERE name='Tatooine';").fetchone()
        result = result[0]
        cursor.close()
        connection.close()

        # Assert query result
        self.assertEqual(result, 'Tatooine')

    def test_get_connection_sqlite(self):
        """Unit tests for method get_connection for SQLite database."""

        # Set connection parameters
        data_source_type_id = DataSourceType.SQLITE_ID
        connection_string = './star_wars.db'

        # Connect to test Database
        data_source = DataSource()
        connection = data_source.get_connection(data_source_type_id, connection_string)
        cursor = connection.cursor()
        result = cursor.execute("SELECT name FROM planet WHERE name='Tatooine';").fetchone()
        result = result[0]
        cursor.close()
        connection.close()

        # Assert query result
        self.assertEqual(result, 'Tatooine')

    def test_get_connection_teradata(self):
        """Unit tests for method get_connection for Teradata database."""
        pass

    @classmethod
    def tearDownClass(self):
        """Execute this at the end of the tests."""
        pass


if __name__ == '__main__':
    unittest.main()
