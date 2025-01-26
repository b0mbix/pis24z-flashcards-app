INSERT INTO Users (username, password_hash, created_at) VALUES
('jan_kowalski', '$2b$12$9xN1p', '2024-01-01 10:00:00'),
('anna_nowak', '$2b$12$4h', '2024-01-15 12:00:00'),
('piotr_wisniewski', '$2b$12$oz7NNl8/', '2024-02-01 08:30:00'),
('magdalena_krawczyk', '$2b$12$d5x', '2024-03-01 09:00:00');

INSERT INTO FlashcardSets (user_id, name, description, views_count, is_archived, is_public) VALUES
(1, 'Podstawowe słówka hiszpańskie', 'Zestaw fiszek z podstawowymi słówkami w języku hiszpańskim.', 120, FALSE, TRUE),
(2, 'Historia starożytnej Grecji', 'Fiszki dotyczące wydarzeń i postaci starożytnej Grecji.', 180, FALSE, TRUE),
(3, 'Matematyka zaawansowana', 'Fiszki z trudniejszymi wzorami matematycznymi.', 70, FALSE, FALSE),
(4, 'Podstawy programowania', 'Wprowadzenie do podstaw programowania.', 250, FALSE, TRUE);

INSERT INTO Flashcards (set_id, question, answer) VALUES
(1, 'Jak powiedzieć "dzień dobry" po hiszpańsku?', 'Buenos días'),
(1, 'Jak powiedzieć "do widzenia" po hiszpańsku?', 'Adiós'),
(1, 'Jak powiedzieć "proszę" po hiszpańsku?', 'Por favor'),
(1, 'Jak powiedzieć "dziękuję" po hiszpańsku?', 'Gracias'),
(1, 'Jak powiedzieć "tak" po hiszpańsku?', 'Sí'),
(1, 'Jak powiedzieć "nie" po hiszpańsku?', 'No'),
(1, 'Jak powiedzieć "jabłko" po hiszpańsku?', 'Manzana'),

(2, 'Kto był królem Sparty podczas bitwy pod Termopilami?', 'Leonidas'),
(2, 'W którym roku wybuchła wojna peloponeska?', '431 p.n.e.'),
(2, 'Jak nazywał się słynny filozof grecki, który był uczniem Sokratesa?', 'Platon'),
(2, 'Jakie miasto-państwo zdominowało Grecję po wojnie peloponeskiej?', 'Sparta'),
(2, 'Jak nazywano grecką kolonię w Egipcie założoną przez Aleksandra Wielkiego?', 'Aleksandria'),
(2, 'Co oznacza pojęcie "Agora" w starożytnej Grecji?', 'Rynek publiczny'),
(2, 'Kto napisał "Iliadę" i "Odyseję"?', 'Homer'),

(3, 'Jak brzmi wzór na pole koła?', 'πr²'),
(3, 'Jak brzmi wzór na objętość kuli?', '4/3 πr³'),
(3, 'Co to jest macierz transponowana?', 'Macierz otrzymana przez zamianę wierszy na kolumny.'),
(3, 'Jakie jest równanie prostej w postaci kierunkowej?', 'y = mx + b'),
(3, 'Jak nazywa się liczba niewymierna zaczynająca się od 3.14?', 'Liczba π'),
(3, 'Jak brzmi twierdzenie Pitagorasa?', 'a² + b² = c² dla trójkąta prostokątnego'),
(3, 'Czym jest logarytm naturalny?', 'Logarytm o podstawie e.'),

(4, 'Czym jest zmienna w programowaniu?', 'Miejsce w pamięci przeznaczone na przechowywanie danych.'),
(4, 'Co oznacza instrukcja "if"?', 'Wykonuje kod, jeśli warunek jest prawdziwy.'),
(4, 'Czym różni się pętla "for" od "while"?', 'For wykonuje się określoną liczbę razy, while działa, dopóki warunek jest prawdziwy.'),
(4, 'Czym jest funkcja w programowaniu?', 'Blok kodu wykonujący określone zadanie, który można wywołać.'),
(4, 'Jak nazywa się operator przypisania w większości języków programowania?', 'Operator ='),
(4, 'Co oznacza termin "kompilacja"?', 'Proces tłumaczenia kodu źródłowego na kod maszynowy.'),
(4, 'Czym jest zmienna globalna?', 'Zmienne dostępne w całym programie.');

INSERT INTO Tags (name) VALUES
('Języki'),
('Historia'),
('Matematyka'),
('Programowanie'),
('Hiszpański'),
('Wzory');

INSERT INTO FlashcardSetTags (set_id, tag_id) VALUES
(1, 1),
(1, 5),
(2, 2),
(3, 3),
(3, 6),
(4, 4);

INSERT INTO FlashcardSetFavorites (user_id, set_id) VALUES
(1, 2),
(2, 1),
(3, 4),
(4, 3);

INSERT INTO FlashcardFavorites (user_id, flashcard_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO FlashcardSetStats (user_id, set_id, flashcards_viewed, total_study_time) VALUES
(1, 1, 7, INTERVAL '15 minutes'),
(2, 2, 5, INTERVAL '10 minutes'),
(3, 3, 3, INTERVAL '5 minutes'),
(4, 4, 6, INTERVAL '12 minutes');

INSERT INTO FlashcardStatsSimple (user_id, flashcard_id, view_count) VALUES
(1, 1, 5),
(2, 2, 3),
(3, 3, 4),
(4, 4, 2);

INSERT INTO FlashcardStatsStages (user_id, flashcard_id, view_count, stage, learned) VALUES
(1, 1, 5, 2, TRUE),
(2, 2, 3, 2, TRUE),
(3, 3, 4, 3, FALSE),
(4, 4, 2, 1, TRUE);

INSERT INTO FlashcardStatsPercent (user_id, flashcard_id, view_count, learning_stage) VALUES
(1, 1, 5, 'still_learning'),
(2, 2, 3, 'almost_learned'),
(3, 3, 4, 'learned'),
(4, 4, 2, 'not_learned');
