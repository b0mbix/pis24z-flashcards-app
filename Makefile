VENV_DIR = venv

# Zależności
REQUIREMENTS = requirements.txt

# Domyślne zadanie - uruchamia testy
.PHONY: all
all: test

# Tworzenie wirtualnego środowiska
$(VENV_DIR)/bin/activate: $(REQUIREMENTS)
	python3 -m venv $(VENV_DIR)
	$(VENV_DIR)/bin/pip install -r $(REQUIREMENTS)

# Instalacja zależności
.PHONY: install
install: $(VENV_DIR)/bin/activate

# Uruchamianie testów z ustawionym PYTHONPATH
.PHONY: test
test: install
	PYTHONPATH=$(PWD)/src $(VENV_DIR)/bin/pytest tests/

# Uruchamianie aplikacji
.PHONY: run
run: install
	$(VENV_DIR)/bin/python src/main.py

# Czyszczenie środowiska
.PHONY: clean
clean:
	rm -rf $(VENV_DIR)

# Sprawdzanie zależności
.PHONY: lint
lint: install
	$(VENV_DIR)/bin/flake8 src/ tests/

