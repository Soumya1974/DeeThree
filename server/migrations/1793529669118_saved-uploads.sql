-- Up Migration
CREATE TABLE saved_uploads (
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    upload_id UUID NOT NULL REFERENCES uploads(id) ON DELETE CASCADE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    PRIMARY KEY (user_id, upload_id)
);
-- Down Migration
DROP TABLE saved_uploads;