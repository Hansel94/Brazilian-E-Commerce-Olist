from typing import Dict

from pandas import DataFrame
from sqlalchemy.engine.base import Engine


def load(data_frames: Dict[str, DataFrame], database: Engine):
    """Load the dataframes into the sqlite database.

    Args:
        dataFrames (Dict[str, DataFrame]): A dictionary with keys as the table names
        and values as the dataframes.
    """
    conn = database.connect() 
    
    for table_name, df in data_frames.items(): 
    	df.to_sql(table_name, conn, if_exists="replace") 
    
    conn.close() 
    print("Database created") 
    
