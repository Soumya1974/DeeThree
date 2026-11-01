-- Up Migration
CREATE TABLE uploads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    title VARCHAR(150) NOT NULL,
    description TEXT,

    character_id SMALLINT NOT NULL
        CHECK (character_id BETWEEN 1 AND 4),

    blend_file_key TEXT NOT NULL UNIQUE,
    thumbnail_key TEXT,

    file_size_bytes BIGINT NOT NULL
        CHECK (file_size_bytes > 0 AND file_size_bytes <= 10485760),

    file_checksum VARCHAR(64),

    status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'processing', 'published', 'rejected')),

    visibility VARCHAR(20) NOT NULL DEFAULT 'public'
        CHECK (visibility IN ('public', 'private')),

    rejection_reason TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    published_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
-- Down Migration
DROP TABLE uploads;