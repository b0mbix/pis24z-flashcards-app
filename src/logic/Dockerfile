FROM python:3.10-slim
WORKDIR /app
COPY poetry.lock pyproject.toml /app/

COPY . .

RUN pip install poetry 
RUN poetry config virtualenvs.create false 
RUN poetry install --no-interaction --no-ansi

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]




