CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    birth_date DATE,
    is_premium BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

CREATE TABLE FlashcardSets (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    views_count INT DEFAULT 0,
    is_archived BOOLEAN DEFAULT FALSE,
    is_public BOOLEAN DEFAULT FALSE
);

CREATE TABLE Flashcards (
    id SERIAL PRIMARY KEY,
    set_id INT REFERENCES FlashcardSets(id) ON DELETE CASCADE,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE FlashcardSetTags (
    id SERIAL PRIMARY KEY,
    set_id INT REFERENCES FlashcardSets(id),
    tag_id INT REFERENCES Tags(id)
);

CREATE TABLE FlashcardSetFavorites (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    set_id INT REFERENCES FlashcardSets(id)
);

CREATE TABLE FlashcardFavorites (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    flashcard_id INT REFERENCES Flashcards(id)
);

CREATE TABLE FlashcardSetStats (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    set_id INT REFERENCES FlashcardSets(id),
    flashcards_viewed INT DEFAULT 0,
    total_study_time INTERVAL DEFAULT INTERVAL '0 seconds',
    correct_answers INT DEFAULT 0,
    incorrect_answers INT DEFAULT 0,
    completion_percentage INT DEFAULT 0 
);

CREATE TABLE FlashcardStats (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    flashcard_id INT REFERENCES Flashcards(id),
    view_count INT DEFAULT 0,
    correct_answers INT DEFAULT 0,
    incorrect_answers INT DEFAULT 0,
    total_study_time INTERVAL DEFAULT INTERVAL '0 seconds',
    last_answered_at TIMESTAMP,
    learning_stage VARCHAR(20) DEFAULT 'not_learned' -- Możliwe wartości: 'not_learned', 'learning', 'almost_learned', 'mastered'
);


