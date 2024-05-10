import os
import subprocess
import logging 

LOGGER = logging.getLogger(__name__)


def get_git_root():
    # Run git command to get root path of git repository
    try:
        git_root = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode().strip()
        return git_root
    except subprocess.CalledProcessError:
        LOGGER.error("Error: Not in a Git repository or Git is not installed.")
        return None

def helm_template(namespace, values_file):
    # Run helm template command
    cmd = ['helm', 'template', '--debug', f'--namespace={namespace}', '-f', f"{values_file}", '.']
    try:
        result = subprocess.run(cmd, check=True, capture_output=True, text=True)
        LOGGER.debug(f"Helm template command {' '.join(cmd)} output:\n{result.stdout}")
        return True
    except subprocess.CalledProcessError as e:
        LOGGER.error(f"Helm template command {' '.join(cmd)} failed with error: {e}")
        if e.stderr:
            LOGGER.error(f"Command stderr:\n{e.stderr}")
        return False
    
def delete_file(file_path):
    if os.path.exists(file_path):
        try:
            os.remove(file_path)
            LOGGER.debug(f"File '{file_path}' deleted successfully.")
            return True
        except OSError as e:
            LOGGER.error(f"Error deleting file '{file_path}': {e}")
            return False
    else:
        LOGGER.error(f"File '{file_path}' does not exist.")
        return False