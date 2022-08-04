import datetime
from dataclasses import dataclass, field
from typing import Optional


@dataclass
class MigrationData:
    id: int
    description: str
    script: str
    checksum: str
    total_queries: int
    sql_queries: list = field(default_factory=list)
    installed_on: str = ""
    done_queries: int = 0
    status: str = ""
    success: int = 0
