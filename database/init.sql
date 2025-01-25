CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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
    total_study_time INTERVAL DEFAULT INTERVAL '0 seconds'
);

CREATE TABLE FlashcardStatsSimple (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    flashcard_id INT REFERENCES Flashcards(id),
    view_count INT DEFAULT 0,
);

CREATE TABLE FlashcardStatsStages (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    flashcard_id INT REFERENCES Flashcards(id),
    view_count INT DEFAULT 0,
    stage INT DEFAULT 1,
    learned BOOLEAN DEFAULT 0
);

CREATE TABLE FlashcardStatsPercent (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    flashcard_id INT REFERENCES Flashcards(id),
    view_count INT DEFAULT 0,
    learning_stage VARCHAR(20) CHECK (learning_stage IN ('not_learned', 'still_learning', 'almost_learned', 'learned')) DEFAULT 'not_learned' 
);
