import random
from django.db import connections
from django.db.utils import OperationalError

class DatabaseRouter:
    def db_for_read(self, model, **hints):
        """
        Directs read operations to one of the databases.
        """
        dbs = ['default', 'db_b']
        for db in dbs:
            try:
                connection = connections[db]
                connection.ensure_connection()
                if connection.is_usable():
                    return db
            except OperationalError:
                continue
        return 'default'

    def db_for_write(self, model, **hints):
        """
        Directs write operations to the primary database.
        """
        return 'default'

    def allow_relation(self, obj1, obj2, **hints):
        """
        Allow any relation if both models are in the same database.
        """
        db_list = ('default', 'db_b')
        if obj1._state.db in db_list and obj2._state.db in db_list:
            return True
        return None

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        """
        Ensure that all models end up in the primary database.
        """
        return db == 'default'