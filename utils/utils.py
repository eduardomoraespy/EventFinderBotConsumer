import os
from pymongo import MongoClient
import dotenv
from typing import List, Dict, Tuple
dotenv.load_dotenv()

DB_NAME = os.getenv('DB_NAME')
COLLECTION_NAME = os.getenv('COLLECTION_NAME')
COLLECTION_NAME_INFO_EVENTS = os.getenv('COLLECTION_NAME_INFO_EVENTS')


def recover_pending() ->Tuple[bool, list]:
    try:
        control_bool = False
        client = MongoClient()
        db = client[DB_NAME]

        result_filter = list(db[COLLECTION_NAME].find({'status':'pending'}))

        if len(result_filter) > 0:
            result_filter = result_filter[0]
            control_bool = True

    except Exception as e:
        return (False, e)
    
    return (control_bool, result_filter)


def save_records(list_extract: List[Dict]) ->Tuple[bool, str]:
    try:
        client = MongoClient()
        db = client[DB_NAME]

        for iterator in list_extract:
            result_filter = list(db[COLLECTION_NAME_INFO_EVENTS].find({'event_title':iterator['event_title']}))

            if len(result_filter) == 0:
                db[COLLECTION_NAME_INFO_EVENTS].insert_one(iterator)

    except Exception as e:
        return (False, e)
    
    return (True, 'Salvo com sucesso')