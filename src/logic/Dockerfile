FROM python:3.10-slim

RUN mkdir -p /app

WORKDIR /app

COPY poetry.lock pyproject.toml /app/

COPY . /app/

RUN pip install poetry
RUN poetry config virtualenvs.create false 
RUN poetry install --no-interaction --no-ansi --no-root

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]