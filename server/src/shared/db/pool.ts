import pg from "pg";
import { env } from "../config/env";

export const pool = new pg.Pool({
    connectionString: env.DATABASE_URL,
    max: 10,
    idleTimeoutMillis: 30_000,
    connectionTimeoutMillis: 5_000,
});

pool.on("error", (err) => {
    console.error("Unexpected PostgreSQL pool error:", err);
});