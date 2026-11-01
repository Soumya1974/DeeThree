-- Up Migration
CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    upload_id UUID NOT NULL REFERENCES uploads(id) ON DELETE CASCADE,

    parent_comment_id UUID REFERENCES comments(id) ON DELETE CASCADE,

    body TEXT NOT NULL
        CHECK (char_length(trim(body)) BETWEEN 1 AND 2000),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);
-- Down Migration
DROP TABLE comments;