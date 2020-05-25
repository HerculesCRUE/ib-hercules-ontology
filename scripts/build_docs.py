import os
import requests

from common import OUTPUT_FOLDER, try_create_dir

LOCAL_RESOURCES_FOLDER = os.path.join('..', 'common')
LODE_ENDPOINT = 'http://150.146.207.114/lode/extract'
ONTOLOGY_URL = 'https://herculescrue.github.io/ib-hercules-ontology/current/asio.xml'
OUTPUT_FILE_NAME = 'asio.html'

def extract_docs_from(onto_url, lode_endpoint):
    payload = {
        'url': onto_url,
        'owlapi': 'true',
        'lang': 'en'
    }
    return requests.get(f"{LODE_ENDPOINT}", params=payload).text

def save_docs(file_name, docs_content):
    with open(file_name, 'w') as f:
        f.write(docs_content)

def use_local_sources(docs_content, resources_folder):
    external_endpoint = 'http://150.146.207.114/lode'
    external_calls_count = docs_content.count(external_endpoint)
    return docs_content.replace(external_endpoint, resources_folder, external_calls_count - 1)

if __name__ == '__main__':
    try_create_dir(OUTPUT_FOLDER)
    docs_content = extract_docs_from(ONTOLOGY_URL, LODE_ENDPOINT)
    docs_content = use_local_sources(docs_content, LOCAL_RESOURCES_FOLDER)
    save_docs(os.path.join(OUTPUT_FOLDER, OUTPUT_FILE_NAME), docs_content)
