# 
FROM python:3.10

# poetry installation
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
ENV PATH="${PATH}:/root/.poetry/bin"


# Copy only poetry.lock and pyproject.toml to cache them in docker layer
WORKDIR /code
COPY poetry.lock pyproject.toml /code/

# Project initialization:
RUN poetry config virtualenvs.create false && poetry install

# 
COPY ./app /code/app

EXPOSE 8000

# 
CMD ["uvicorn", "app.main:app", "--host=0.0.0.0", "--reload"]
