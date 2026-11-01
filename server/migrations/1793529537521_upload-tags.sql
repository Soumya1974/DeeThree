-- Up Migration
CREATE TABLE upload_tags (
    upload_id UUID NOT NULL REFERENCES uploads(id) ON DELETE CASCADE,
    tag_id UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    PRIMARY KEY (upload_id, tag_id)
);
-- Down Migration
DROP TABLE upload_tags;