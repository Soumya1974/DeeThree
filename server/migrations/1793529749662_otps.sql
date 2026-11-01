-- Up Migration
CREATE TABLE otps (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    email VARCHAR(255) NOT NULL,
    code_hash TEXT NOT NULL,

    purpose VARCHAR(30) NOT NULL
        CHECK (purpose IN ('signup', 'password_reset')),

    attempts SMALLINT NOT NULL DEFAULT 0
        CHECK (attempts BETWEEN 0 AND 5),

    expires_at TIMESTAMPTZ NOT NULL,
    consumed_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
-- Down Migration
DROP TABLE otps;