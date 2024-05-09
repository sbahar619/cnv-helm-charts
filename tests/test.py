import yaml
import os
import subprocess
import uuid
import logging 
import argparse

parser = argparse.ArgumentParser(description='Your script description')
parser.add_argument('-v', '--verbose', action='store_true', help='Increase logging verbosity to DEBUG')
# Add other command line arguments as needed
args = parser.parse_args()

# Set logging configuration
if args.verbose:
    logging.basicConfig(format='%(levelname)s: %(asctime)s %(message)s',
                level=logging.DEBUG,)
else:
    # configuring the logger to display log message
    # along with log level and time
    logging.basicConfig(format='%(levelname)s: %(asctime)s %(message)s',
                level=logging.INFO,)


def get_git_root():
    # Run git command to get root path of git repository
    try:
        git_root = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode().strip()
        return git_root
    except subprocess.CalledProcessError:
        logging.error("Error: Not in a Git repository or Git is not installed.")
        return None

def update_values_file(values_file):
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
        logging.debug(f"File {unique_filename} content:\n{file_content}")

    return unique_filename

def helm_template(namespace, values_file):
    # Run helm template command
    cmd = ['helm', 'template', '--debug', f'--namespace={namespace}', '-f', f"{values_file}", '.']
    try:
        result = subprocess.run(cmd, check=True, capture_output=True, text=True)
        logging.debug(f"Helm template command {' '.join(cmd)} output:\n{result.stdout}")
        return True
    except subprocess.CalledProcessError as e:
        logging.error(f"Helm template command {' '.join(cmd)} failed with error: {e}")
        if e.stderr:
            logging.error(f"Command stderr:\n{e.stderr}")
        return False
    
def delete_file(file_path):
    if os.path.exists(file_path):
        try:
            os.remove(file_path)
            logging.debug(f"File '{file_path}' deleted successfully.")
            return True
        except OSError as e:
            logging.error(f"Error deleting file '{file_path}': {e}")
            return False
    else:
        logging.error(f"File '{file_path}' does not exist.")
        return False

def main():
    # Path to the values file
    values_file = 'values.yaml'

    # Update values file
    test_values_file = update_values_file(values_file)

    # Run helm template command with updated values file
    if helm_template('test', test_values_file):
        logging.info("Helm template command ran successfully.")
    else:
        logging.info("Helm template command failed.")
    
    delete_file(test_values_file)

if __name__ == "__main__":
    main()