import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

required = [
    "click",
    "invoke",
    "rich",
    "PyInquirer",
    "pyyaml",
    "python-dotenv",
    "pyfiglet",
    "sqlparse",
    "mysql-connector-python",
    "sqlite3",
]

setuptools.setup(
    name="db-migration-tool",
    version="0.1.0",
    author="Fredrik Haglund",
    author_email="fr3h4g@gmail.com",
    description="A command line utility",
    long_description=long_description,
    long_description_content_type="text/markdown",
    packages=setuptools.find_packages(),
    entry_points={
        "console_scripts": [
            "db-migration-tool = dbmt.main:start",
            "dbmigrationtool = dbmt.main:start",
            "dbmt = dbmt.main:start",
            "dmt = dbmt.main:start",
        ]
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.7",
    install_requires=required,
)
