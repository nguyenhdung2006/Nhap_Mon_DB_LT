-- Tạo bảng book theo schema trong ảnh
CREATE TABLE book (
                      book_id SERIAL PRIMARY KEY,
                      title VARCHAR(255),
                      author VARCHAR(100),
                      genre VARCHAR(50),
                      price DECIMAL(10,2),
                      description TEXT,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO book (title, author, genre, price, description) VALUES
                                                                ('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 'Fantasy', 20.00, 'A young boy discovers he is a wizard.'),
                                                                ('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 'Fantasy', 22.00, 'Harry returns to Hogwarts for his second year.'),
                                                                ('The Casual Vacancy', 'J. Rowling', 'Fiction', 15.00, 'A local election in a small English town.'),
                                                                ('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 18.00, 'A hobbit goes on an adventure to find treasure.'),
                                                                ('Clean Code', 'Robert C. Martin', 'Education', 45.00, 'A handbook of agile software craftsmanship.'),
                                                                ('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 12.00, 'A story of wealth and love in the 1920s.'),
                                                                ('A Game of Thrones', 'George R.R. Martin', 'Fantasy', 25.00, 'Noble families fight for control of the Iron Throne.'),
                                                                ('Database Systems', 'Abraham Silberschatz', 'Education', 120.00, 'Comprehensive guide to database concepts.');

EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';
EXPLAIN ANALYZE SELECT * FROM book WHERE author ILIKE '%Rowling%';

CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX idx_book_author_trgm ON book USING gin (author gin_trgm_ops);

CREATE INDEX idx_book_genre ON book USING btree (genre);

CREATE INDEX idx_book_description_fts ON book USING GIN (to_tsvector('english', description));


EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';
EXPLAIN ANALYZE SELECT * FROM book WHERE author ILIKE '%Rowling%';

CLUSTER book USING idx_book_genre;


ANALYZE book;

EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';