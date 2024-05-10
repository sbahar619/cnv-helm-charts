import logging 

from tests.conftest import update_values_file

from tests.utils import helm_template, delete_file

LOGGER = logging.getLogger(__name__)

def test_templates(update_values_file):
    # Run helm template command with updated values file
    success = helm_template('test', update_values_file)
    assert success, "Helm template command failed."
    LOGGER.info("Helm template command ran successfully.")