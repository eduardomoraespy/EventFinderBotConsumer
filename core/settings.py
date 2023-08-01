import os
from pathlib import Path
import dotenv
dotenv.load_dotenv()


ROOT = Path(os.path.dirname(os.path.abspath(__file__))).parent
