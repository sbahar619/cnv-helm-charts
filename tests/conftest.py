import yaml
import os
import uuid
import pytest
import logging

from tests.utils import get_git_root, delete_file

LOGGER = logging.getLogger(__name__)

@pytest.fixture()
def values_file():
    return 'values.yaml'

@pytest.fixture()
def update_values_file(request, values_file):
    def finalizer(filename):
        delete_file(filename)

    git_root = get_git_root()
    if git_root:
        # Construct absolute path to values.yaml
        values_file = os.path.join(git_root, values_file)
    # Read the original values file
    with open(values_file, 'r') as f:
        values_data = yaml.safe_load(f)

    # Update 'enable' key to True
    def update_enable_value(data):
        if isinstance(data, dict):
            if 'enable' in data:
                data['enable'] = True
            for value in data.values():
                update_enable_value(value)
        elif isinstance(data, list):
            for item in data:
                update_enable_value(item)
        return data

    values_data = update_enable_value(values_data)

    # Generate a unique filename for the updated values file
    unique_filename = f'/tmp/updated_values_{str(uuid.uuid4())[:8]}.yaml'

    # Write updated values to the unique filename
    with open(unique_filename, 'w') as f:
        yaml.dump(values_data, f)

    with open(unique_filename, 'r') as f:
        file_content = f.read()
        LOGGER.debug(f"File {unique_filename} content:\n{file_content}")

    # Register finalizer to delete the file after the test
    request.addfinalizer(lambda: finalizer(unique_filename))
    
    return unique_filename