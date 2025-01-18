INSERT INTO Users (username, email, password_hash, birth_date, is_premium, created_at, last_login) VALUES
('jan_kowalski', 'jan.kowalski@example.com', '$2b$12$9xN1p', '1985-02-10', TRUE, '2024-01-01 10:00:00', '2024-12-01 18:00:00'),
('anna_nowak', 'anna.nowak@example.com', '$2b$12$4h', '1992-07-15', FALSE, '2024-01-15 12:00:00', '2024-12-15 14:00:00'),
('piotr_wisniewski', 'piotr.wisniewski@example.com', '$2b$12$oz7NNl8/', '1990-11-20', TRUE, '2024-02-01 08:30:00', NULL),
('magdalena_krawczyk', 'magdalena.krawczyk@example.com', '$2b$12$d5x', '2000-04-08', FALSE, '2024-03-01 09:00:00', '2024-12-10 16:00:00');

INSERT INTO FlashcardSets (user_id, name, description, created_at, updated_at, views_count, is_archived, is_public) VALUES
(1, 'Podstawowe słówka hiszpańskie', 'Zestaw fiszek z podstawowymi słówkami w języku hiszpańskim.', '2024-01-02 10:00:00', '2024-01-02 10:00:00', 120, FALSE, TRUE),
(2, 'Historia starożytnej Grecji', 'Fiszki dotyczące wydarzeń i postaci starożytnej Grecji.', '2024-01-03 12:00:00', '2024-01-03 12:00:00', 180, FALSE, TRUE),
(3, 'Matematyka zaawansowana', 'Fiszki z trudniejszymi wzorami matematycznymi.', '2024-01-04 08:00:00', '2024-01-04 08:00:00', 70, FALSE, FALSE),
(4, 'Podstawy programowania', 'Wprowadzenie do podstaw programowania.', '2024-01-05 14:00:00', '2024-01-05 14:00:00', 250, FALSE, TRUE);

INSERT INTO Flashcards (set_id, question, answer, created_at, updated_at) VALUES
(1, 'Jak powiedzieć "dzień dobry" po hiszpańsku?', 'Buenos días', '2024-01-02 10:10:00', '2024-01-02 10:10:00'),
(1, 'Jak powiedzieć "do widzenia" po hiszpańsku?', 'Adiós', '2024-01-02 10:11:00', '2024-01-02 10:11:00'),
(1, 'Jak powiedzieć "proszę" po hiszpańsku?', 'Por favor', '2024-01-02 10:12:00', '2024-01-02 10:12:00'),
(2, 'Kto był królem Sparty podczas bitwy pod Termopilami?', 'Leonidas', '2024-01-03 12:10:00', '2024-01-03 12:10:00'),
(3, 'Jak brzmi wzór na pole koła?', 'πr²', '2024-01-04 08:10:00', '2024-01-04 08:10:00'),
(4, 'Czym jest zmienna w programowaniu?', 'Miejsce w pamięci przeznaczone na przechowywanie danych.', '2024-01-05 14:10:00', '2024-01-05 14:10:00');

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

INSERT INTO FlashcardSetStats (user_id, set_id, flashcards_viewed, total_study_time, correct_answers, incorrect_answers, completion_percentage) VALUES
(1, 1, 7, INTERVAL '15 minutes', 6, 1, 85),
(2, 2, 5, INTERVAL '10 minutes', 4, 1, 70),
(3, 3, 3, INTERVAL '5 minutes', 2, 1, 50),
(4, 4, 6, INTERVAL '12 minutes', 5, 1, 80);

INSERT INTO FlashcardStats (user_id, flashcard_id, view_count, correct_answers, incorrect_answers, total_study_time, last_answered_at, learning_stage) VALUES
(1, 1, 5, 4, 1, INTERVAL '8 minutes', '2024-12-20 10:00:00', 'learning'),
(2, 2, 3, 2, 1, INTERVAL '6 minutes', '2024-12-20 11:00:00', 'almost_learned'),
(3, 3, 4, 3, 1, INTERVAL '10 minutes', '2024-12-21 12:00:00', 'mastered'),
(4, 4, 2, 2, 0, INTERVAL '3 minutes', '2024-12-22 14:00:00', 'learning');
