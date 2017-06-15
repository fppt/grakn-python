import subprocess
import shutil
import tempfile
import os.path
import tarfile
import urllib.request
import time
from grakn import GraknError
from requests.exceptions import ConnectionError

from behave.runner import Context
from behave.model import Scenario

grakn_release: str = 'grakn-dist-0.13.0'
grakn_tar: str = f'{grakn_release}.tar.gz'
grakn_download_url: str = f'https://github.com/graknlabs/grakn/releases/download/v0.13.0/{grakn_tar}'
grakn_download_path: str = grakn_tar
temp_dir: str = tempfile.mkdtemp()
grakn_dir: str = f'{temp_dir}/{grakn_release}'
grakn_cmd: str = f'{grakn_dir}/bin/grakn.sh'
graql_cmd: str = f'{grakn_dir}/bin/graql.sh'


def start_grakn():
    if not os.path.isfile(grakn_download_path):
        urllib.request.urlretrieve(grakn_download_url, grakn_download_path)

    tarfile.open(grakn_download_path).extractall(temp_dir)

    subprocess.run([grakn_cmd, 'start'])

    time.sleep(5)


def graql_shell(*args):
    subprocess.run([graql_cmd] + list(args))


def execute_query(context: Context, query: str):
    try:
        context.response = context.graph.execute(query)
        context.error = None
    except (GraknError, ConnectionError) as e:
        context.response = None
        context.error = e


def after_scenario(context: Context, scenario: Scenario):
    if os.path.isdir(grakn_dir):
        subprocess.run([grakn_cmd, 'stop'])
        shutil.rmtree(grakn_dir)
