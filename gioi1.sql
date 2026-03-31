CREATE TABLE post (
                      post_id SERIAL PRIMARY KEY,
                      user_id INT NOT NULL,
                      content TEXT,
                      tags TEXT[],
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      is_public BOOLEAN DEFAULT TRUE
);

CREATE TABLE post_like (
                           user_id INT NOT NULL,
                           post_id INT NOT NULL,
                           liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           PRIMARY KEY (user_id, post_id)
);

INSERT INTO post (user_id, content, tags, created_at, is_public) VALUES
                                                                     (1, 'Hôm nay đi du lịch Đà Lạt tuyệt vời', ARRAY['travel', 'dalat'], NOW() - INTERVAL '2 days', TRUE),
                                                                     (2, 'Chia sẻ kinh nghiệm học lập trình', ARRAY['education', 'coding'], NOW() - INTERVAL '10 days', TRUE),
                                                                     (3, 'Nhật ký cá nhân không chia sẻ', ARRAY['private'], NOW(), FALSE),
                                                                     (1, 'Khám phá văn hóa ẩm thực và Du Lịch Hà Nội', ARRAY['food', 'travel'], NOW() - INTERVAL '1 day', TRUE),
                                                                     (4, 'Review chuyến đi dã ngoại cuối tuần', ARRAY['travel', 'review'], NOW() - INTERVAL '8 days', TRUE);


EXPLAIN ANALYZE
SELECT * FROM post
WHERE is_public = TRUE AND content ILIKE '%du lịch%';

CREATE INDEX idx_post_content_lower ON post (LOWER(content));

EXPLAIN ANALYZE
SELECT * FROM post
WHERE is_public = TRUE AND LOWER(content) LIKE '%du lịch%';

EXPLAIN ANALYZE
SELECT * FROM post WHERE tags @> ARRAY['travel'];

CREATE INDEX idx_post_tags_gin ON post USING GIN (tags);

EXPLAIN ANALYZE
SELECT * FROM post WHERE tags @> ARRAY['travel'];

EXPLAIN ANALYZE
SELECT * FROM post
WHERE is_public = TRUE AND created_at >= NOW() - INTERVAL '7 days';

CREATE INDEX idx_post_recent_public
    ON post(created_at DESC)
    WHERE is_public = TRUE;

EXPLAIN ANALYZE
SELECT * FROM post
WHERE is_public = TRUE AND created_at >= NOW() - INTERVAL '7 days';

EXPLAIN ANALYZE
SELECT * FROM post
WHERE user_id = 1
ORDER BY created_at DESC;

CREATE INDEX idx_post_user_created_at ON post (user_id, created_at DESC);

EXPLAIN ANALYZE
SELECT * FROM post
WHERE user_id = 1
ORDER BY created_at DESC;